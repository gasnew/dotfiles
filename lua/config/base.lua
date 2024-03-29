-- ensure the packer plugin manager is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")
  -- Treesitter
  --use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- Collection of common configurations for the Nvim LSP client
  use("neovim/nvim-lspconfig")
  -- Visualize lsp progress
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end
  })

  -- Autocompletion framework
  use("hrsh7th/nvim-cmp")
  use({
    -- cmp LSP completion
    "hrsh7th/cmp-nvim-lsp",
    -- cmp Snippet completion
    "hrsh7th/cmp-vsnip",
    -- cmp Path completion
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    after = { "hrsh7th/nvim-cmp" },
    requires = { "hrsh7th/nvim-cmp" },
  })
  -- See hrsh7th other plugins for more great completion sources!
  -- Snippet engine
  use('hrsh7th/vim-vsnip')
  -- Adds extra functionality over rust analyzer
  use("simrat39/rust-tools.nvim")

  -- Optional
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")
  use("nvim-telescope/telescope.nvim")

  -- Some color scheme other then default
  use("arcticicestudio/nord-vim")
  --use("szebniok/tree-sitter-wgsl")

  -- TypeScript
  use("jose-elias-alvarez/typescript.nvim")
  --use {
  --  "pmizio/typescript-tools.nvim",
  --  requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --  config = function()
  --    require("typescript-tools").setup {}
  --  end,
  --}
end)

-- the first run will install packer and our plugins
if packer_bootstrap then
  require("packer").sync()
  return
end


-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"

local function on_attach(client, buffer)
  -- This callback is called when the LSP is atttached/enabled for this buffer
  -- we could set keymaps related to LSP, etc here.
  client.server_capabilities.semanticTokensProvider = nil
end

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  --server = {
  --  -- on_attach is a callback called when the language server attachs to the buffer
  --  on_attach = on_attach,
  --  settings = {
  --    -- to enable rust-analyzer settings visit:
  --    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
  --    ["rust-analyzer"] = {
  --      -- enable clippy on save
  --      --checkOnSave = {
  --      --  command = "clippy",
  --      --},
  --    },
  --  },
  --},
}

require("rust-tools").setup(opts)

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require("cmp")
cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },

  -- Installed sources
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "path" },
    { name = "buffer" },
  },
})


-- Configure tree-sitter-wgsl
--vim.filetype.add({extension = {wgsl = "wgsl"}})

--local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
--parser_config.wgsl = {
--    install_info = {
--        url = "https://github.com/szebniok/tree-sitter-wgsl",
--        files = {"src/parser.c"}
--    },
--}

--require'nvim-treesitter.configs'.setup {
--    ensure_installed = {"wgsl"},
--    highlight = {
--        enable = true
--    },
--    incremental_selection = {
--        enable = true,
--        keymaps = {
--            init_selection = "gnn",
--            node_incremental = "grn",
--            scope_incremental = "grc",
--            node_decremental = "grm",
--        },
--    },
--}

--vim.wo.foldmethod = "expr"
--vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
--vim.o.foldlevelstart = 99 -- do not close folds when a buffer is opened

-- TypeScript
require("typescript").setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
    },
    server = { -- pass options to lspconfig's setup method
        on_attach = on_attach
    },
})
