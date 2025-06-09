require('plugins')

-- general config
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.termguicolors = true
vim.opt.colorcolumn = '120'
vim.cmd [[
  highlight ColorColumn ctermbg=0 guibg=#2e2e2e
]]

vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 5
vim.o.confirm = true

vim.cmd.colorscheme 'paper'

-- use buffers like tabs
vim.api.nvim_create_user_command('Q', 'q', { desc = 'Close neovim' })
vim.keymap.set('n', 'gt', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', 'gT', ':bprevious<CR>', { desc = 'Prev buffer' })

-- close buffer instead 
vim.cmd([[
  cnoreabbrev <expr> q  getcmdtype() == ':' && getcmdline() == 'q'  ? 'bdelete' : 'q'
]])


-- float term
vim.g.floaterm_title = '$1|$2'
vim.g.floaterm_giteditor = 'vim'
vim.g.floaterm_width = 0.999
vim.g.floaterm_height = 0.40
vim.g.floaterm_wintype = 'float'
vim.g.floaterm_position = 'bottom'
vim.g.floaterm_keymap_toggle = '<F1>'
vim.g.floaterm_keymap_new    = '<F3>'
vim.g.floaterm_keymap_prev   = '<F11>'
vim.g.floaterm_keymap_next   = '<F12>'


-- linter
-- vim.g.python_pep8_indent_hang_closing = 0
-- vim.g.ale_linters = {
--     javascript = {'eslint'},
--     python = {'flake8', 'mypy', 'pyright', 'ruff'}
-- }
-- vim.g.ale_python_flake8_options = '--max-line-length=120'
-- vim.g.ale_sign_error = '✘'
-- vim.g.ale_sign_warning = '▲'
-- vim.g.ale_echo_msg_error_str = 'E'
-- vim.g.ale_echo_msg_warning_str = 'W'
-- vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
-- vim.g.ale_virtualtext_cursor = 0
-- vim.g.ale_lint_on_text_changed = 'never'

-- vim.api.nvim_set_keymap('n', 'q', '<Nop>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-]>', '<C-w>T<C-]>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<C-]>', ':TabExpand 1<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-]>', ':tab split | :tjump <C-R>=expand("<cword>")<CR><CR>', { noremap = true, silent = true })
--


-- ui utils
require('ibl').setup({
    indent = { char = '│' },
    scope = { enabled = false },
})

require('mini.indentscope').setup({
    symbol = '│',
    options = { try_as_border = true },
})


-- bufferline / tabs
require('bufferline').setup({
  options = {
    mode = 'buffers',
    diagnostics = 'nvim_lsp',
    always_show_bufferline = true,
    show_buffer_close_icons = true,
    show_close_icon = false,
    -- separator_style = 'slant',
    color_icons = true,
    themable = true,
    style_preset = bufferline.style_preset.no_italic,
    separator_style = 'thin',
    indicator = {
      icon = '▎',
      style = 'icon',
    },
  },
})

require('lualine').setup({
    sections = {
        lualine_c = {
            {
              'filename',
              file_status = true,
              path = 1 -- 0 = filename, 1 = relative path, 2 = absolute path
            }
        }
    }
})


-- file explorer
require('neo-tree').setup({
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
})
vim.keymap.set('n', '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })


-- fuzzy search 
require('fzf-lua').setup()
vim.keymap.set('n', '<C-P>', '<cmd>lua require("fzf-lua").files()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-g>', "<cmd>lua require('fzf-lua').live_grep_resume({ cmd = 'git grep -i --line-number --column --color=always' })<CR>", { noremap = true, silent = true })


-- lsp 
require('lspconfig').pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
  	enabled = true,
  	maxLineLength = 120
        },
        pyflakes = { enabled = false },
        mccabe = { enabled = false },
        black = { enabled = false },
        isort = { enabled = false },
        pylint = { enabled = false },
        yapf = { enabled = false },
      },
    },
  },
})


-- autocomplete
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
})


-- git
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
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
}


-- definitions preview
require('goto-preview').setup({
  default_mappings = false,
  width = 120,
  height = 25,
  border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"},
  preview_window_title = { enable = true, position = "center" },
stack_floating_preview_windows = true,
same_file_float_preview = false
})

vim.keymap.set("n", "<C-]>", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, silent = true })
