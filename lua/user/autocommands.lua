-- vim.api.nvim_create_autocmd({ "User" }, {
--   pattern = { "AlphaReady" },
--   callback = function()
--     vim.cmd [[
--       set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
--     ]]
--   end,
-- })

vim.cmd [[ autocmd BufRead * autocmd FileType <buffer> ++once
  \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
]]

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AlphaReady" },
  callback = function()
    vim.cmd [[
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "Jaq", "qf", "help", "man", "lspinfo", "spectre_panel", "lir", "DressingSelect" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "Jaq" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> <M-r> :close<CR>
      " nnoremap <silent> <buffer> <M-r> <NOP>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "" },
  callback = function()
    local buf_ft = vim.bo.filetype
    if buf_ft == "" or buf_ft == nil then
      vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      nnoremap <silent> <buffer> <C-j> j<CR>
      nnoremap <silent> <buffer> <C-k> k<CR>
      set nobuflisted 
    ]]
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "term://*" },
  callback = function()
    vim.cmd "startinsert!"
    vim.cmd "set cmdheight=1"
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lir" },
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   callback = function()
--     vim.cmd [[
--       if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
--     ]]
--   end,
-- })

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd "quit"
  end,
})

if vim.fn.has "nvim-0.8" == 1 then
  vim.api.nvim_create_autocmd(
    { "CursorMoved", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed"}, 
    {
      callback = function()
        require("user.winbar").get_winbar()
      end,
    }
  )
end

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd({ "Colorscheme" }, {
  callback = function()
    vim.cmd [[
      highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
      highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.rs" },
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd "checktime"
  end,
})
