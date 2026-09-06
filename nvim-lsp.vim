"==========================================
" Neovim built-in LSP configuration
"
" Sourced from .vimrc only when running under Neovim. Kept in its own file
" because Vim cannot parse a `lua <<EOF` heredoc inside a skipped if-block
" (lua's own `if`/`end` confuse Vim's :endif scanner).
"
" Requires: npm install -g typescript-language-server typescript
"==========================================

lua <<EOF
local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
  return
end

-- Diagnostics: show them in the sign column and on :LspDiag, but don't let
-- inline virtual text push code around while typing.
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'single', source = 'if_many' },
})

for sign, text in pairs({ Error = 'E', Warn = 'W', Info = 'I', Hint = 'H' }) do
  vim.fn.sign_define('DiagnosticSign' .. sign, {
    text = text,
    texthl = 'Diagnostic' .. sign,
    numhl = '',
  })
end

-- Buffer-local mappings, set only once a server actually attaches.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
  callback = function(args)
    local function map(keys, fn, desc)
      vim.keymap.set('n', keys, fn, { buffer = args.buf, silent = true, desc = desc })
    end

    map('gd', vim.lsp.buf.definition, 'Go to definition')
    map('gD', vim.lsp.buf.type_definition, 'Go to type definition')
    map('gr', vim.lsp.buf.references, 'List references')
    map('gi', vim.lsp.buf.implementation, 'Go to implementation')
    map('K', vim.lsp.buf.hover, 'Hover docs')
    map('<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
    map('<leader>e', vim.diagnostic.open_float, 'Show diagnostic')
    map('[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
    map(']d', vim.diagnostic.goto_next, 'Next diagnostic')
    map('<leader>q', vim.diagnostic.setloclist, 'Diagnostics to loclist')

    -- <C-]> already means "jump to tag"; point it at the language server.
    vim.bo[args.buf].tagfunc = 'v:lua.vim.lsp.tagfunc'
    vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
  end,
})

-- ts_ls is the current name; older lspconfig releases called it tsserver.
local ts_server = lspconfig.ts_ls or lspconfig.tsserver
if ts_server then
  ts_server.setup({
    single_file_support = false,
  })
end
EOF
