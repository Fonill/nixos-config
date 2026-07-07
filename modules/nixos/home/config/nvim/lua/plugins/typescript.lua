return {
    "pmizio/typescript-tools.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "neovim/nvim-lspconfig"
    },
    opts = {
        filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue",
        },
    },
}
