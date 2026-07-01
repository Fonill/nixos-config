return {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        signs = false,
        keywords = {
            SECTION = { icon =  "", color = "section" }
        },
        colors = {
            section = { "#B55EFF" }
        },
    },
}
