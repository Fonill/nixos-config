local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map({"n", "x"}, ";", ":", { desc = "Easier command (map ; to :)" })
map("i", "<C-Delete>", "<C-o>dw", { desc = "Delete a word forward in insert mode" })
map({"n", "x", "i"},"<F1>", ":echo<CR>", {desc = "turn off f1"})

-- Tab management
map("n", "<leader>b", ":tabnew<CR>", { desc = "Open new [b]ab" })
map("n", "<leader>t", ":tabnew | Telescope find_files<CR>", { desc = "Open new [T]ab with telescope" })
map("n", "<leader>x", ":tabclose<CR>", { desc = "Close current tab" })
map("n", "<Tab>", ":tabnext<CR>", { desc = "Next [Tab]" })
map("n", "<S-Tab>", ":tabprev<CR>", { desc = "Prev [Tab]" })

