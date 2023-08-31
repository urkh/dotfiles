require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'voldikss/vim-floaterm'
    use {'catppuccin/nvim', as = 'catppuccin'}
    use 'Vimjas/vim-python-pep8-indent'
    use 'lewis6991/gitsigns.nvim'
    use 'dense-analysis/ale'

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
          -- Soporte LSP
          {'neovim/nvim-lspconfig'},
          {'williamboman/mason.nvim'},
          {'williamboman/mason-lspconfig.nvim'},

          -- Autocompletado
          {'hrsh7th/nvim-cmp'},
          {'hrsh7th/cmp-buffer'},
          {'hrsh7th/cmp-path'},
          {'saadparwaiz1/cmp_luasnip'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'hrsh7th/cmp-nvim-lua'},

          -- Snippets
          {'L3MON4D3/LuaSnip'},
          {'rafamadriz/friendly-snippets'},
        }
    }

end)

local lsp = require('lsp-zero')
-- lsp.preset('recommended')
lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
  sign_icons = {
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = 'ⓘ'
  }
})

lsp.nvim_workspace()
lsp.setup()


-- Git setup
require('gitsigns').setup {
    signs = {
      add          = { text = '+' },
      change       = { text = '~' },
      delete       = { text = '-' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1000,
      follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 500,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
    yadm = {
      enable = false
    },
}

require('lualine').setup {
    options = {
        theme = 'auto'
    }
}

-- vim configs
vim.opt.showmatch = true
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoindent = false
vim.opt.smartindent = false
-- vim.opt.noshowmode = true
-- vim.opt.clipboard = {'unnamedplus', 'unnamed'}
vim.opt.clipboard = 'unnamedplus'
-- vim.api.nvim_set_hl(0, 'ColorColumn', { ctermbg=0, bg='lightgrey' })
-- vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.colorcolumn = '120'
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
-- vim.g.mapleader = ' '
vim.cmd.colorscheme('catppuccin')


-- float term
vim.g.floaterm_title = '$1|$2'
vim.g.floaterm_giteditor = 'vim'
vim.g.floaterm_width = 0.999
vim.g.floaterm_height = 0.40
vim.g.floaterm_wintype = 'float'
vim.g.floaterm_position = 'bottom'
vim.g.floaterm_keymap_toggle = '<F12>'
vim.g.floaterm_keymap_new    = '<F3>'
vim.g.floaterm_keymap_prev   = '<F1>'
vim.g.floaterm_keymap_next   = '<F2>'


-- linters
vim.g.python_pep8_indent_hang_closing = 0
vim.g.ale_linters = {
    javascript = {'eslint'},
    python = {'flake8', 'mypy', 'pylint', 'pyright', 'ruff'}
}
-- vim.g.ale_linters = {['python'] = 'pylint'}
vim.g.ale_python_flake8_options = '--max-line-length=120'
vim.g.ale_sign_error = '✘'
vim.g.ale_sign_warning = '▲'
vim.g.ale_echo_msg_error_str = 'E'
vim.g.ale_echo_msg_warning_str = 'W'
vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
vim.g.ale_virtualtext_cursor = 0
vim.g.ale_lint_on_text_changed = 'never'


-- cmp
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 1},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
    documentation = cmp.config.window.bordered(),
    completion = cmp.config.window.bordered({
        winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None'
    }),
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-f>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
})
