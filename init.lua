require('plugins')

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
vim.opt.clipboard = {'unnamedplus', 'unnamed'}
vim.api.nvim_set_hl(0, 'ColorColumn', { ctermbg=0, bg='lightgrey' })
vim.opt.colorcolumn = '120'
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true

-- theme
vim.cmd('colorscheme catppuccin-frappe')

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

vim.g.python_pep8_indent_hang_closing = 0

vim.g.ale_linters = {
    javascript = {'eslint'},
    python = {'flake8', 'mypy', 'pyright', 'ruff'}
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

vim.keymap.set('n', '<c-P>', '<cmd>lua require("fzf-lua").files()<CR>', { silent = true })


local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'pyright', 'vuels'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

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
    -- yadm = {
    --     enable = false
    -- },
}


-- File explorer
local function on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', '<enter>', api.node.open.tab, opts('Open: New Tab'))
end

require('nvim-tree').setup({
    on_attach = on_attach,
    sort_by = 'case_sensitive',
    view = {
        adaptive_size = true,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

vim.keymap.set('n', '<Leader><Tab>', ':NvimTreeToggle<CR>', {remap = true})


-- buffer line
local lualine = require('lualine')
lualine.setup({
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

local bufferline = require('bufferline')
bufferline.setup({
    options = {
        mode = 'tabs',
        style_preset = bufferline.style_preset.no_italic,
    }
})
