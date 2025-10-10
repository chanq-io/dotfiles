return {
    url = "https://github.com/benjamin-kruger/fahrenheit-nvim.git",
    name = "fahrenheit-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("fahrenheit")
    end,
}

