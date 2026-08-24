return {

    -- ================= THEME =================
    {
        "dracula/vim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("dracula")
        end,
    },

    -- ================= LSP CORE =================
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "SmiteshP/nvim-navic",
        },

        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()

            local navic = require("nvim-navic")

            vim.lsp.config("clangd", {

                cmd = {
                    "clangd",
                    "--clang-tidy",
                    "--background-index",
                    "--completion-style=detailed",
                    "--header-insertion=never",
                },

                on_attach = function(client, bufnr)
                    if client.server_capabilities.documentSymbolProvider then
                        navic.attach(client, bufnr)
                        client.server_capabilities.semanticTokensProvider = true
                    end
                end,
            })

            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = {
                        analysis = {
                            typeCheckingMode = "standard",  -- or "basic" to be quieter still
                            diagnosticMode = "workspace",
                        },
                    },
                },
            })

            vim.lsp.enable("clangd")
            vim.lsp.enable("basedpyright")
        end,
    },

    -- ================= COMPLETION =================
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ select = true })
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                },
            })
        end,
        },

    -- ================= TREESITTER =================
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "c", "cpp", "lua", "python" },
            highlight = { enable = true },
        },
    },

    -- ================= FORMATTING (clang-format) =================
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                c = { "clang_format" },
                cpp = { "clang_format" },
                python = { "ruff" },
            },
            format_on_save = {
                timeout_ms = 1000,
                lsp_fallback = true,
            },
        },
    },

    -- ================= FILE TREE (MODERN REPLACEMENT FOR NERDTree) =================
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 30,
                },
                renderer = {
                    group_empty = true,
                },
            })

        end,
    },

    -- ================= GIT =================
    {
        "lewis6991/gitsigns.nvim",
        config = true,
    },

    -- ================= UI / CMDLINE =================
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            lsp = {
                progress = { enabled = true },
            },
        },
    },

    -- ================= STATUSLINE =================
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true,
    },

    -- ================= AUTO PAIRS =================
    {
        "windwp/nvim-autopairs",
        config = true,
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        version = "*",
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    separator_style = "slant",
                    diagnostics = "nvim_lsp",
                    show_buffer_close_icons = true,
                    show_close_icons = false,
                    always_show_bufferline = true,
                },
            })

            -- Alt + number mapping (1–9)
            for i = 1, 9 do
                vim.keymap.set("n", "<A-" .. i .. ">", function()
                    vim.cmd("BufferLineGoToBuffer " .. i)
                end)
            end

            -- optional extras
            vim.keymap.set("n", "<A-h>", ":BufferLineCyclePrev<CR>")
            vim.keymap.set("n", "<A-l>", ":BufferLineCycleNext<CR>")
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        config = function()
            local telescope = require("telescope")

            telescope.setup({
                defaults = {
                    layout_strategy = "horizontal",

                    layout_config = {
                        prompt_position = "top",
                    },

                    sorting_strategy = "ascending",

                    mappings = {
                        i = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                        },
                    },
                },
            })
        end,
    },

    -- Keybinds
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },

    {
        "tris203/precognition.nvim",
        opts = {},
    },
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = true,
        -- `cmd` lets lazy.nvim create command stubs that load the plugin on first use,
        -- so `:ClaudeCode` and friends work on a fresh start. Without it, a keys-only
        -- spec defers loading until a <leader>a* mapping is pressed and the commands
        -- would not exist yet.
        cmd = {
            "ClaudeCode",
            "ClaudeCodeFocus",
            "ClaudeCodeSelectModel",
            "ClaudeCodeAdd",
            "ClaudeCodeSend",
            "ClaudeCodeTreeAdd",
            "ClaudeCodeStatus",
            "ClaudeCodeStart",
            "ClaudeCodeStop",
            "ClaudeCodeOpen",
            "ClaudeCodeClose",
            "ClaudeCodeDiffAccept",
            "ClaudeCodeDiffDeny",
            "ClaudeCodeCloseAllDiffs",
        },
        keys = {
            { "<leader>a", nil, desc = "AI/Claude Code" },
            { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
            { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
            { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
            { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
            { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
            { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
            {
                "<leader>as",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
            },
            -- Diff management
            { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
        },
    }

}
