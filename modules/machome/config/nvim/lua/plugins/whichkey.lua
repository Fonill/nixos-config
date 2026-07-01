return {
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
        require("which-key").setup()

        -- Document existing key chains
        require("which-key").add({
            { "<leader>f", group = "[F]ind" },
            { "<leader>f_", hidden = true },
        })
    end,
}
