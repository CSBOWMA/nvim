return {

    {
        "dracula/vim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme dracula]])
        end,
    },


   {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            --            {"saadparwaiz1/cmp_luasnip"},
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
    },
    'simrat39/rust-tools.nvim',
    'andymass/vim-matchup',
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'lewis6991/gitsigns.nvim',
    'preservim/nerdtree',
    'neovide/neovide',
{
    'dense-analysis/ale',
    config = function()
        -- Configuration goes here.
        local g = vim.g

        g.ale_ruby_rubocop_auto_correct_all = 1

        g.ale_linters = {
            ruby = {'rubocop', 'ruby'},
            lua = {'lua_language_server'},
            cpp = {'clangd'},
            c = {'clangd'},
            rust = {'rust_analyzer'}
        }
    end
},

    {'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        -- lazy.nvim saadparwaiz1/cmp_luasnipwill automatically call setup for you. put your options here, anything missing will use the default:
        -- animation = true,
        -- insert_at_start = true,
        -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
},

{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
},

{
    "windwp/nvim-autopairs",
    dependencies = { "nvim-cmp", },
    opts = {
        fast_wrap = {},
        disable_filetype = { "TelescopePrompt", "vim" },
    },
    config = function(_, opts)
        require("nvim-autopairs").setup(opts)

        -- setup cmp for autopairs
        local cmp_autopairs = require "nvim-autopairs.completion.cmp"
        require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
},

{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
},

{
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
        local navic = require("nvim-navic")

        require("lspconfig").clangd.setup {
            on_attach = function(client, bufnr)
                navic.attach(client, bufnr)
            end
        }
    end
},
-- lazy.nvim
{
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    }
},


    {
        "SmiteshP/nvim-navic",
        dependencies = "neovim/nvim-lspconfig",
        config = function()
            local navic = require("nvim-navic")

            require("lspconfig").clangd.setup {
                on_attach = function(client, bufnr)
                    navic.attach(client, bufnr)
                end
            }
        end
    },


}

