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
                    end
                end,
            })

            vim.lsp.enable("clangd")
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
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
            ensure_installed = { "c", "cpp", "lua" },
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
        "m4xshen/hardtime.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {},
    },

    {
        "tris203/precognition.nvim",
        opts = {},
    }
}
