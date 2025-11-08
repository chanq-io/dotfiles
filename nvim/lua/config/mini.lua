require('mini.git').setup()
require('mini.indentscope').setup()
local starter = require('mini.starter')
local logo = table.concat({
       "████████████████████████████████████",
       "██▌                              ███",
       "██▌   ░█▀█░█▀▀░█▀█░█░█░▀█▀░█▄█   ███",
       "██▌   ░█░█░█▀▀░█░█░▀▄▀░░█░░█░█   ███",
       "██▌   ░▀░▀░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░▀   ███",
       "██▌                              ███",
       "████████████████████████████████████",
    }, "\n")
starter.setup({
    header = logo,
    items = {
        starter.sections.telescope(),
        {
          action = 'edit ~/Code/personal/zettelkasten/index.md',
          name = 'Open Zettelkasten Index',
          section = 'Shortcuts'
        },
        starter.sections.recent_files(5, false, false),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet("|> ", false),
      starter.gen_hook.aligning("center", "center"),
    },
    footer = ""
})
require('mini.splitjoin').setup()
