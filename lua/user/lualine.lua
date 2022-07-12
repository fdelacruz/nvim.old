local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = "#303030" })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#D4D4D4", bg = "#303030", bold = false })
vim.api.nvim_set_hl(0, "SLProgress", { fg = "#D4D4D4", bg = "#303030" })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#808080", bg = "#252525" })

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local icons = require "user.icons"

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = icons.diagnostics.Error .. " ", warn = icons.diagnostics.Warning .. " " },
  colored = false,
  update_in_insert = false,
  always_visible = false,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = icons.git.Add .. " ", modified = icons.git.Mod .. " ", removed = icons.git.Remove .. " " }, -- changes diff symbols
  cond = hide_in_width,
  separator = "%#SLSeparator#" .. "│ " .. "%*",
}

local mode_map = {
  ['n']    = 'NORMAL',
  ['no']   = 'OP PENDING',
  ['nov']  = 'OP PENDING CHAR',
  ['noV']  = 'OP PENDING LINE',
  ['no�'] = 'OP PENDING BLOCK',
  ['niI']  = 'INSERT (NORMAL)',
  ['niR']  = 'REPLACE (NORMAL)',
  ['niV']  = 'V REPLACE (NORMAL)',
  ['nt']   = 'NORMAL',
  ['v']    = 'VISUAL',
  ['vs']   = 'VISUAL',
  ['V']    = 'V-LINE',
  ['Vs']   = 'V-LINE',
  ['�']   = 'V-BLOCK',
  ['�s']  = 'V-BLOCK',
  ['s']    = 'SELECT',
  ['S']    = 'S-LINE',
  ['�']   = 'S-BLOCK',
  ['i']    = 'INSERT',
  ['ic']   = 'INSERT',
  ['ix']   = 'INSERT',
  ['R']    = 'REPLACE',
  ['Rc']   = 'REPLACE',
  ['Rx']   = 'REPLACE',
  ['Rv']   = 'V-REPLACE',
  ['Rvc']  = 'V-REPLACE',
  ['Rvx']  = 'V-REPLACE',
  ['c']    = 'COMMAND',
  ['cv']   = 'EX',
  ['ce']   = 'EX',
  ['r']    = 'REPLACE',
  ['rm']   = 'MORE',
  ['r?']   = 'CONFIRM',
  ['!']    = 'SHELL',
  ['t']    = 'TERMINAL',
}

-- local mode = {
--   "mode",
--   fmt = function(str)
--     return "" .. str .. ""
--   end,
--   padding = 1,
-- }

local filetype = {
  "filetype",
  icons_enabled = true,
  -- icon = nil,
    padding = { left = 1, right = 0 },
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "%#SLGitIcon#" .. "" .. "%*" .. "%#SLBranchName#",
  color = "Constant",
  colored = false,
  -- icon = "",
}

local progress = {
  "progress",
  color = "SLProgress",
  padding = 1,

  -- fmt = function(str)
  --   print(vim.fn.expand(str))
  --   if str == "1%" then
  --     return "TOP"
  --   end
  --   if str == "100%" then
  --     return "BOT"
  --   end
  --   return str
  -- end,
  -- padding = 0,
}

-- cool function for progress
-- local progress = function()
--   local current_line = vim.fn.line "."
--   local total_lines = vim.fn.line "$"
--   local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
--   local line_ratio = current_line / total_lines
--   local index = math.ceil(line_ratio * #chars)
--   -- return chars[index]
--   return "%#SLProgress#" .. chars[index] .. "%*"
-- end

-- local current_signature = function()
--   if not pcall(require, "lsp_signature") then
--     return
--   end
--   local sig = require("lsp_signature").status_line(30)
--   -- return sig.label .. "🐼" .. sig.hint
--   return "%#SLSeparator#" .. sig.hint .. "%*"
-- end


local spaces = {
  function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end,
  padding = 0,
  separator = "%#SLSeparator#" .. " │" .. "%*",
}

local location = {
  "location",
  padding = 1
}

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {function ()
        return mode_map[vim.api.nvim_get_mode().mode] or "__"
    end},
    lualine_b = { branch, diagnostics },
    lualine_c = {},
    lualine_x = { diff, spaces, "encoding", filetype },
    -- lualine_x = { diff, spaces, filetype },
    lualine_y = { progress },
    lualine_z = { location },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  },
  tabline = {},
  extensions = {},
}
