vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>q", vim.cmd.q)

-- File tree
vim.keymap.set("n", "<leader><F6>", "<cmd>NvimTreeToggle<CR>", {
  desc = "Toggle file tree",
})

-- Clipboard copy
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', {
  desc = "Copy to system clipboard",
})

vim.keymap.set("n", "<leader>Y", '"+yy', {
  desc = "Copy line to system clipboard",
})

-- Clipboard paste
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', {
  desc = "Paste from system clipboard",
})

vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', {
  desc = "Paste before from system clipboard",
})

-- Format
vim.keymap.set("n", "<leader>cf", function()
  vim.lsp.buf.format()
end)

-- Telescope
local function tb(fn)
  return function()
    require("telescope.builtin")[fn]()
  end
end

vim.keymap.set("n", "<leader>ff", tb("find_files"))
vim.keymap.set("n", "<leader>fr", tb("oldfiles"))
vim.keymap.set("n", "<leader>fg", tb("live_grep"))
vim.keymap.set("n", "<leader>fw", tb("grep_string"))

vim.keymap.set("n", "<leader>fd", tb("lsp_definitions"))
vim.keymap.set("n", "<leader>fD", tb("lsp_declarations"))
vim.keymap.set("n", "<leader>fi", tb("lsp_implementations"))
vim.keymap.set("n", "<leader>ft", tb("lsp_type_definitions"))
vim.keymap.set("n", "<leader>fR", tb("lsp_references"))

vim.keymap.set("n", "<leader>fs", tb("lsp_document_symbols"))
vim.keymap.set("n", "<leader>fS", tb("lsp_workspace_symbols"))

vim.keymap.set("n", "<leader>fx", tb("diagnostics"))

vim.keymap.set("n", "<leader>fc", tb("git_commits"))
vim.keymap.set("n", "<leader>fb", tb("git_branches"))

vim.keymap.set("n", "<leader>bb", tb("buffers"))

-- Build project
vim.keymap.set("n", "<leader>mb", function()
  vim.cmd("!cmake --build build")
end, { desc = "Build project" })

-- Run tests
vim.keymap.set("n", "<leader>mt", function()
  vim.cmd("!ctest --output-on-failure")
end, { desc = "Run tests" })

-- Run python prototype (for your scraper repo)
vim.keymap.set("n", "<leader>mr", function()
  vim.cmd("!./run.sh")
end, { desc = "Run project script" })

-- Open Avante chat
vim.keymap.set("n", "<leader>aa", "<cmd>AvanteToggle<CR>", {
  desc = "Avante chat",
})

-- Ask Avante to explain code
vim.keymap.set("v", "<leader>ae", "<cmd>AvanteAsk Explain this code<CR>", {
  desc = "Explain selection",
})

-- Ask Avante to refactor
vim.keymap.set("v", "<leader>ar", "<cmd>AvanteAsk Refactor this code<CR>", {
  desc = "Refactor selection",
})

-- Generate tests
vim.keymap.set("v", "<leader>at", "<cmd>AvanteAsk Write unit tests for this<CR>", {
  desc = "Generate tests",
})
