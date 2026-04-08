local M = {}

-- Default configurations
M.configs = {}

-- Get day of year (1-365/366)
local function get_day_of_year()
  local now = os.date("*t")
  local year_start = os.time({year = now.year, month = 1, day = 1, hour = 0})
  local now_time = os.time(now)
  local day_of_year = math.floor((now_time - year_start) / 86400) + 1
  return day_of_year
end

-- Get week of year (1-52/53)
local function get_week_of_year()
  return tonumber(os.date("%V"))
end

-- Get month of year (1-12)
local function get_month_of_year()
  return tonumber(os.date("%m"))
end

-- Get the current cycle index based on cycle type
local function get_cycle_index(cycle_type, cycle_days)
  if cycle_type == "weekly" then
    return get_week_of_year()
  elseif cycle_type == "monthly" then
    return get_month_of_year()
  elseif cycle_type == "custom" and cycle_days then
    -- For custom cycle, divide day of year by number of days per cycle
    local day = get_day_of_year()
    return math.floor((day - 1) / cycle_days) + 1
  else -- default to "daily"
    return get_day_of_year()
  end
end

-- Get the value for today based on the values list and cycle type
local function get_cycled_value(values, cycle_type, cycle_days)
  local cycle_index = get_cycle_index(cycle_type, cycle_days)
  local index = (cycle_index - 1) % #values + 1
  return values[index]
end

-- Insert text at cursor position
local function insert_at_cursor(text)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local new_line = line:sub(1, col) .. text .. line:sub(col + 1)
  vim.api.nvim_set_current_line(new_line)
  -- Move cursor after inserted text
  vim.api.nvim_win_set_cursor(0, {row, col + #text})
end

-- Create a command for a given configuration
local function create_command(name, config)
  vim.api.nvim_create_user_command(name, function()
    local value = get_cycled_value(config.values, config.cycle or "daily", config.days)
    insert_at_cursor(value)
  end, {
    desc = "Insert " .. (config.cycle or "daily") .. " cycling value: " .. name
  })
end

-- Setup function to configure the plugin
function M.setup(opts)
  opts = opts or {}
  
  -- Merge user configs with any existing configs
  for name, config in pairs(opts) do
    -- Support both simple array format and config object format
    if type(config) == "table" and config.values then
      -- Full config object with {values = {...}, cycle = "daily/weekly/monthly"}
      M.configs[name] = config
      create_command(name, config)
    elseif type(config) == "table" then
      -- Simple array format, default to daily cycle
      M.configs[name] = {values = config, cycle = "daily"}
      create_command(name, M.configs[name])
    end
  end
end

return M
