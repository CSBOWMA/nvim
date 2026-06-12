-- UI
vim.opt.number = true
vim.opt.relativenumber = false -- change to true if you want navigation speed boost

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8

-- Editing behavior
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

-- System behavior
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Search behavior (modern defaults)
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Performance / LSP responsiveness
vim.opt.updatetime = 200 -- 50 is *too aggressive*, causes UI jitter in some setups

-- Better splits (modern UX improvement)
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Clipboard (modern dev standard)
vim.opt.clipboard = ""

-- File handling
vim.opt.isfname:append("@-@")

vim.opt.termguicolors = true
vim.opt.showtabline = 2
