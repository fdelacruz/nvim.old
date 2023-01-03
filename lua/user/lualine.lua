M = {}
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

-- check if value in table
local function contains(t, value)
  for _, v in pairs(t) do
    if v == value then
      return true
    end
  end
  return false
end

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = "#303030" })
vim.api.nvim_set_hl(0, "SLTermIcon", { fg = "#b668cd", bg = "#282c34" })
vim.api.nvim_set_hl(0, "SLTelescope", { fg = "#D7BA7D", bg = "#282c34" })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#D4D4D4", bg = "#303030", bold = false })
vim.api.nvim_set_hl(0, "SLProgress", { fg = "#D4D4D4", bg = "#303030" })
vim.api.nvim_set_hl(0, "SLFG", { fg = "#abb2bf", bg = "#282c34" })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#808080", bg = "#252525" })
vim.api.nvim_set_hl(0, "SLLSP", { fg = "#5e81ac", bg = "#282c34" })

local hide_in_width_60 = function()
  return vim.o.columns > 60
end

local hide_in_width = function()
  return vim.o.columns > 80
end

local hide_in_width_100 = function()
  return vim.o.columns > 100
end

local icons = require "user.icons"

local virtual_env = {
  function()
    local function env_cleanup(venv)
      if string.find(venv, "/") then
        local final_venv = venv
        for w in venv:gmatch "([^/]+)" do
          final_venv = w
        end
        venv = final_venv
      end
      return venv
    end

    if vim.bo.filetype == "python" then
      local venv = os.getenv "CONDA_DEFAULT_ENV" or os.getenv "VIRTUAL_ENV"
      if venv then
        return string.format("ⓔ ", env_cleanup(venv))
      end
    end
    return ""
  end,
  color = { fg = "green", bg = "#282c34" },
  cond = hide_in_width,
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = {
    error = icons.diagnostics.Error .. " ",
    warn = icons.diagnostics.Warning .. " ",
  },
  colored = true,
  update_in_insert = false,
  always_visible = false,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = icons.git.Add .. " ", modified = icons.git.Mod .. " ", removed = icons.git.Remove .. " " }, -- changes diff symbols
  cond = hide_in_width_60,
  separator = "%#SLSeparator#" .. "│ " .. "%*",
}

local language_server = {
  function()
    local buf_ft = vim.bo.filetype
    local ui_filetypes = {
      "help",
      "packer",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
      "TelescopePrompt",
      "lspinfo",
      "lsp-installer",
      "",
    }

    if contains(ui_filetypes, buf_ft) then
      return M.language_servers
    end

    local clients = vim.lsp.get_active_clients()
    local client_names = {}

    -- add client
    for _, client in pairs(clients) do
      table.insert(client_names, client.name)
    end

    -- add formatter
    local s = require "null-ls.sources"
    local available_sources = s.get_available(buf_ft)
    local registered = {}
    for _, source in ipairs(available_sources) do
      for method in pairs(source.methods) do
        registered[method] = registered[method] or {}
        table.insert(registered[method], source.name)
      end
    end

    local formatter = registered["NULL_LS_FORMATTING"]
    local linter = registered["NULL_LS_DIAGNOSTICS"]
    if formatter ~= nil then
      vim.list_extend(client_names, formatter)
    end
    if linter ~= nil then
      vim.list_extend(client_names, linter)
    end

    -- join client names with commas
    local client_names_str = table.concat(client_names, ", ")

    -- check client_names_str if empty
    local language_servers = ""
    local client_names_str_len = #client_names_str
    if client_names_str_len ~= 0 then
      language_servers = "%#SLLSP#" .. "[" .. client_names_str .. "]" .. "%*"
    end

    M.language_servers = language_servers
    return language_servers:gsub(", anonymous source", "")
  end,

  padding = 0,
  cond = hide_in_width,
  separator = "%#SLSeparator#" .. " │ " .. "%*",
}

local mode_map = {
  ["n"] = "normal",
  ["no"] = "op pending",
  ["nov"] = "op pending char",
  ["noV"] = "op pending line",
  ["no�"] = "op pending block",
  ["niI"] = "insert (normal)",
  ["niR"] = "replace (normal)",
  ["niV"] = "v replace (normAL)",
  ["nt"] = "normal",
  ["v"] = "visual",
  ["vs"] = "visual",
  ["V"] = "v-line",
  ["Vs"] = "v-line",
  ["�"] = "v-blocK",
  ["�s"] = "v-block",
  ["s"] = "select",
  ["S"] = "s-line",
  -- ['�']   = 'S-BLOCK',
  ["i"] = "insert",
  ["ic"] = "insert",
  ["ix"] = "insert",
  ["R"] = "replace",
  ["Rc"] = "replace",
  ["Rx"] = "replace",
  ["Rv"] = "v-replace",
  ["Rvc"] = "v-replace",
  ["Rvx"] = "v-replace",
  ["c"] = "command",
  ["cv"] = "ex",
  ["ce"] = "ex",
  ["r"] = "replace",
  ["rm"] = "more",
  ["r?"] = "confirm",
  ["!"] = "shell",
  ["t"] = "terminal",
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
  fmt = function(str)
    local ui_filetypes = {
      "help",
      "packer",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
      "",
    }

    if str == "TelescopePrompt" then
      local term = "%#SLTelescope#" .. " " .. "%*"
      return term
    end

    if str == "toggleterm" then
      -- 
      local term = "%#SLTermIcon#"
        .. " "
        .. "%*"
        .. "%#SLFG#"
        .. vim.api.nvim_buf_get_var(0, "toggle_number")
        .. "%*"
      return term
    end

    if contains(ui_filetypes, str) then
      return ""
    else
      return str
    end
  end,
  icons_enabled = true,
  padding = { left = 1, right = 0 },
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "%#SLGitIcon#" .. " " .. "%*" .. "%#SLBranchName#",
  color = "Constant",
  colored = false,
  padding = 0,
}

local progress = {
  "progress",
  color = "SLProgress",
  padding = 1,
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

local current_signature = {
  function()
    local buf_ft = vim.bo.filetype

    if buf_ft == "toggleterm" or buf_ft == "TelescopePrompt" then
      return ""
    end
    if not pcall(require, "lsp_signature") then
      return ""
    end
    local sig = require("lsp_signature").status_line(30)
    local hint = sig.hint

    if not require("user.functions").isempty(hint) then
      -- return "%#SLSeparator#│ " .. hint .. "%*"
      return "%#SLSeparator# " .. hint .. "%*"
    end

    return ""
  end,
  cond = hide_in_width_100,
  padding = 0,
}

local spaces = {
  function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end,
  padding = 0,
  separator = "%#SLSeparator#" .. " │" .. "%*",
  cond = hide_in_width_100,
}

local location = {
  "location",
  padding = 1,
}

local mode = {
  function()
    return mode_map[vim.api.nvim_get_mode().mode] or "__"
  end,
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
    lualine_a = { mode },
    lualine_b = { branch, virtual_env, diagnostics},
    lualine_c = {},
    -- lualine_c = { current_signature },
    lualine_x = { diff, language_server, spaces, "encoding", filetype },
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
