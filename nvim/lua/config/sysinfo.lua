-- System-info components for lualine: CPU utilization + memory usage.
--
-- Both values are sampled on a background timer and cached, so the statusline
-- (which repaints many times a second) just reads cheap cached numbers.
--   CPU  is a true utilization %: the busy/idle tick delta across all cores
--        between two samples, so it needs the short cadence below.
--   MEM  is a subprocess (`vm_stat`) on macOS, so it samples less often.
local uv = vim.uv or vim.loop

local M = { cpu = 0, mem = 0 }

-- Base sample cadence (CPU). Memory samples every MEM_EVERY ticks to avoid
-- spawning the vm_stat subprocess too frequently.
local TICK_MS = 3 * 1000
local MEM_EVERY = 5 -- ~15s

-- Utilization bands -> a plain-language label shown next to the percentage.
local function cpu_word(pct)
  if pct < 25 then return 'idle'
  elseif pct < 60 then return 'light'
  elseif pct < 85 then return 'busy'
  else return 'heavy' end
end

-- Sum CPU tick counters across all cores. times are cumulative since boot;
-- utilization only means something as a delta between two snapshots.
local function cpu_snapshot()
  local busy, total = 0, 0
  for _, core in ipairs(uv.cpu_info()) do
    local t = core.times
    local sum = t.user + t.nice + t.sys + t.idle + t.irq
    busy = busy + (sum - t.idle)
    total = total + sum
  end
  return busy, total
end

local prev_busy, prev_total
local function sample_cpu()
  local busy, total = cpu_snapshot()
  if prev_total then
    local d_total = total - prev_total
    if d_total > 0 then
      M.cpu = math.floor((busy - prev_busy) / d_total * 100 + 0.5)
    end
  end
  prev_busy, prev_total = busy, total
end

-- Sample system memory usage (percent used) without blocking the UI.
--   macOS: parse `vm_stat`. libuv's get_free_memory() under-reports usage on
--          Darwin (the OS counts cache/inactive as "not free"), so we compute
--          in-use pages = active + wired + compressed instead.
--   Linux: /proc/meminfo, used = MemTotal - MemAvailable.
local function sample_mem()
  if vim.fn.has('mac') == 1 then
    vim.system({ 'vm_stat' }, { text = true }, function(res)
      if res.code ~= 0 or not res.stdout then return end
      local out = res.stdout
      local pagesize = tonumber(out:match('page size of (%d+) bytes')) or 4096
      local function pages(label)
        return tonumber(out:match(label .. ':%s+(%d+)%.')) or 0
      end
      local used = (pages('Pages active')
        + pages('Pages wired down')
        + pages('Pages occupied by compressor')) * pagesize
      local total = uv.get_total_memory()
      if total > 0 then M.mem = math.floor(used / total * 100 + 0.5) end
    end)
  else
    local ok, lines = pcall(vim.fn.readfile, '/proc/meminfo')
    if not ok then return end
    local total, avail
    for _, l in ipairs(lines) do
      total = total or tonumber(l:match('^MemTotal:%s+(%d+) kB'))
      avail = avail or tonumber(l:match('^MemAvailable:%s+(%d+) kB'))
    end
    if total and avail and total > 0 then
      M.mem = math.floor((total - avail) / total * 100 + 0.5)
    end
  end
end

local tick = 0
local function sample()
  sample_cpu()
  if tick % MEM_EVERY == 0 then sample_mem() end
  tick = tick + 1
end

-- lualine component functions (each returns its display string).
-- The '%%' is a literal percent escaped TWICE: Lua concatenates a '%%' string,
-- and the Vim statusline then renders '%%' as a single '%'. A bare '%' would be
-- read as a statusline format code and blank the whole bar.
function M.cpu_component() return ('cpu %d'):format(M.cpu) .. '%% ' .. cpu_word(M.cpu) end
function M.mem_component() return ('mem %d'):format(M.mem) .. '%%' end

local timer
function M.start()
  if timer then return end -- idempotent across config reloads
  sample_cpu()             -- prime the CPU snapshot (delta starts next tick)
  sample_mem()             -- prime memory so it isn't blank on startup
  timer = uv.new_timer()
  timer:start(TICK_MS, TICK_MS, vim.schedule_wrap(sample))
end

M.start()

return M
