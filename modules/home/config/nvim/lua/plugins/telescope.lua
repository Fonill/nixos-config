return {
  'nvim-telescope/telescope.nvim', version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- optional but recommended
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
  config = function()
    local map = vim.keymap.set
    local builtin = require("telescope.builtin")
    map("n", "<leader>ff", builtin.find_files, {desc = "find files"})
    map("n", "<leader>fw", builtin.live_grep, {desc = "live grep"})
    require("telescope").setup({
      extensions = {
        ["ui-select"] = require("telescope.themes").get_dropdown(),
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
  end

}
