set number 
set relativenumber
set nowrap
set clipboard=unnamed

command W :SudaWrite
command Run w! | !./run

map J 5j
map K 5k

call plug#begin()
Plug 'BranimirE/fix-auto-scroll.nvim'
Plug 'xiyaowong/transparent.nvim'
Plug 'rmagatti/auto-session'
Plug 'lambdalisue/vim-suda'
Plug 'nvim-tree/nvim-web-devicons' " OPTIONAL: for file icons
Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
Plug 'romgrk/barbar.nvim'
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
Plug 'mikavilpas/yazi.nvim'
Plug 'folke/snacks.nvim'
Plug 'olimorris/persisted.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'junegunn/vim-easy-align'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'rmagatti/auto-session'
Plug 'nanozuki/tabby.nvim'
Plug 'tpope/vim-vinegar'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'ajmwagar/vim-deus'
Plug 'yorickpeterse/happy_hacking.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
call plug#end()

" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

colorscheme happy_hacking

" Remapping leader doesnt work ¯\_(ツ)_/¯ 
nnoremap <Space>ff <cmd>Telescope find_files<cr>
nnoremap <Space>fg <cmd>Telescope live_grep<cr>
nnoremap <Space>fb <cmd>Telescope buffers<cr>
nnoremap <Space>fh <cmd>Telescope help_tags<cr>
nnoremap <Space>tp <cmd>Telescope persisted<cr>
nnoremap <Space>rs <cmd>SessionSearch<cr>
nnoremap <Space>bn <cmd>bnext<cr>
nnoremap <Space>bp <cmd>bprev<cr>
nnoremap <Space>lo <cmd>LspStart<cr>
nnoremap <Space>la <cmp>LspStop<cr>
nnoremap <Space>rn <cmd>Run<cr>
nnoremap <Space>tt <cmd>TransparentToggle<cr>
nnoremap <silent> <Space>1 <Cmd>BufferGoto 1<CR>
nnoremap <silent> <Space>2 <Cmd>BufferGoto 2<CR>
nnoremap <silent> <Space>3 <Cmd>BufferGoto 3<CR>
nnoremap <silent> <Space>4 <Cmd>BufferGoto 4<CR>
nnoremap <silent> <Space>5 <Cmd>BufferGoto 5<CR>
nnoremap <silent> <Space>6 <Cmd>BufferGoto 6<CR>
nnoremap <silent> <Space>7 <Cmd>BufferGoto 7<CR>
nnoremap <silent> <Space>8 <Cmd>BufferGoto 8<CR>
nnoremap <silent> <Space>9 <Cmd>BufferGoto 9<CR>
nnoremap <silent> <Space>0 <Cmd>BufferLast<CR>

lua <<EOF
  require('fix-auto-scroll').setup()
  require('auto-session').setup ({
	  -- TODO: Setup function so that nvim [filename] loads file's session
	  -- For now just use <Space>rs to restore while using filename
	auto_restore_last_session = false, 
	args_allow_files_auto_save = true,
  })
EOF
lua <<EOF
  -- Set up nvim-cmp.
--  local cmp = require'cmp'
--  local cmptoggle = true
--
--  vim.keymap.set("n", "<Space>yo", function()
--  require("yazi").yazi()
--  end)
--
--  vim.keymap.set("n", "<Space>yt", function()
--  require("yazi").toggle()
--  end)
--
--  require("persisted").setup {}
--
--  cmp.setup({
--    enabled = function() -- How to make this toggleable?
--      cmptoggle = not cmptoggle
--      return cmptoggle
--    end,
--    snippet = {
--      expand = function(args)
--        require('luasnip').lsp_expand(args.body)
--      end,
--    },
--    window = {
--      completion = cmp.config.window.bordered(),
--      documentation = cmp.config.window.bordered(),
--    },
--    mapping = cmp.mapping.preset.insert({
--      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--      ['<C-f>'] = cmp.mapping.scroll_docs(4),
--      ['<C-Space>'] = cmp.mapping.complete(),
--      ['<C-e>'] = cmp.mapping.abort(),
--      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--    }),
--    sources = cmp.config.sources({
--      { name = 'nvim_lsp' },
--      { name = 'luasnip' },
--    }, {
--      { name = 'buffer' },
--    })
--  })
--  cmp.setup.cmdline({ '/', '?' }, {
--    mapping = cmp.mapping.preset.cmdline(),
--    sources = {
--      { name = 'buffer' }
--    }
--  })
--  cmp.setup.cmdline(':', {
--    mapping = cmp.mapping.preset.cmdline(),
--    sources = cmp.config.sources({
--      { name = 'path' }
--    }, {
--      { name = 'cmdline' }
--    }),
--    matching = { disallow_symbol_nonprefix_matching = false }
--  })
--
--  local capabilities = require('cmp_nvim_lsp').default_capabilities()
--  require('lspconfig').clangd.setup {
--    capabilities = capabilities
--  }
--
----  require'lspconfig'.gopls.setup{ "gopls" }
--
--  require'lspconfig'.gdscript.setup{}

  -- Disable virtual_text since it's redundant due to lsp_lines.
--  require("lsp_lines").setup({ enabled = false })
--  vim.diagnostic.config({ virtual_text = false })
--  vim.keymap.set(
--  "",
--  "<Space>lt",
--  require("lsp_lines").toggle,
--  { desc = "Toggle lsp_lines" }
-- )

EOF
