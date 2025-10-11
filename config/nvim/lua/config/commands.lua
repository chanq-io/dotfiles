vim.g.mapleader = " "

vim.api.nvim_create_user_command('Node', 'split | terminal node <args>',  { nargs = '*' })
vim.api.nvim_create_user_command('CargoBuild', 'split | terminal cargo build <args>', { nargs = '*' })
vim.api.nvim_create_user_command('CargoRun', 'split | terminal cargo run <args>', { nargs = '*' })
vim.api.nvim_create_user_command('CargoTestAll', 'split | terminal cargo make test-all <args>', { nargs = '*' })
vim.api.nvim_create_user_command('CargoTestUnitExact', 'split | terminal <args> cargo make --no-workspace test-unit-exact', { nargs = '*' })
vim.api.nvim_create_user_command('CargoTestIntegrationExact', 'split | terminal <args> cargo make --no-workspace test-integration-exact', { nargs = '*' })
vim.api.nvim_create_user_command('CargoTestCrate', 'split | terminal <args> cargo make --no-workspace test-crate', { nargs = '*' })
vim.api.nvim_create_user_command('CargoTestCrateUnit', 'split | terminal <args> cargo make --no-workspace test-crate-unit', { nargs = '*' })
vim.api.nvim_create_user_command('CargoTestUnit', 'split | terminal cargo make test-unit <args>', { nargs = '*' })
vim.api.nvim_create_user_command('CppFastBuild', 'split | terminal cd build && make -j10 <args>', { nargs = '*' })
vim.api.nvim_create_user_command('CppTestAll', 'split | terminal cd build && make -j12 md_test <args>', { nargs = '*' })
vim.api.nvim_create_user_command('CppTest', 'split | terminal cd build && make -j12 <args>', { nargs = '*' })
vim.api.nvim_create_user_command('CppCleanBuild', 'split | terminal rm -rf build && mkdir build && cd build && cmake --preset all .. && make -j12 <args>', { nargs = '*' })
vim.api.nvim_create_user_command('Run', 'split | terminal <args>', { nargs = '*', complete = 'file' } )

vim.cmd [[
    no <F2> :ZettelNew
    no <F3> :ZettelOpen<CR>
    no <F7> :CargoTestCrate
    no <F8> :CargoTestCrateUnit
    no <F9> :CargoTestIntegrationExact
    no <F10> :CargoTestUnitExact
    no <F11> :CargoTestUnit --workspace<CR>
    no <F12> :CargoTestAll --workspace<CR>
    no <leader>c :Copilot panel<CR>
    no <leader>f :Telescope find_files<CR>
    no <leader>s :Telescope live_grep<CR>
    no <leader>b :Telescope buffers<CR>
    no <leader>C :Telescope commands<CR>
    no <leader>l :Telescope builtin.lsp_
    map <C-n> :Telescope file_browser<CR>
    no <leader>j :%!jq .<CR>
    no <leader>- :resize 
    no <leader>= :vertical resize 
    no <leader>L :call vimspector#Launch()<CR>
    no <leader>R :call vimspector#Reset()<CR>
    no <leader>A :call vimspector#AddWatch()<CR>
    no <leader>E :call vimspector#Evaluate()<CR>
    no <leader>B :call vimspector#ToggleBreakpoint()<CR>
    no <leader>N :call vimspector#StepInto()<CR>
    no <leader>U :call vimspector#StepOut()<CR>
    no <leader>O :call vimspector#StepOver()<CR>
    no <D-u> :CppFastBuild<CR>
    no <D-y> :CppCleanBuild<CR>
    no <D-o> :CppTest
]]
