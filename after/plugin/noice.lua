--https://www.lazyvim.org/plugins/ui#noicenvim

local noice = require("noice")
local lsp = require("noice.lsp")

vim.keymap.set("c", "<S-Enter>", function() vim.lsp.buf.definition() end)
vim.keymap.set("n", "<leader>snl", function() noice.cmd("last") end)
vim.keymap.set("n", "<leader>snh", function() noice.cmd("history") end)
vim.keymap.set("n", "<leader>sna", function() noice.cmd("all") end)
vim.keymap.set("n", "<leader>snd", function() noice.cmd("dismiss") end)
vim.keymap.set({"i", "n", "s"}, "<c-f>", function() if not lsp.scroll(4) then return "<c-f>" end end, {silent = true, expr = true})
vim.keymap.set({"i", "n", "s"}, "<c-b>", function() if not lsp.scroll(-4) then return "<c-b>" end end, {silent = true, expr = true})

noice.setup({
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    -- you can enable a preset for easier configuration
    routes = {
        {
            filter = {
                event = "msg_show",
                any = {
                    { find = "%d+L, %d+B" },
                    { find = "; after #%d+" },
                    { find = "; before #%d+" },
                },
            },
            view = "mini",
        },
    },
    presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
    },
})
