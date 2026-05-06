local M = {}

local state_file = vim.fn.stdpath("state") .. "/transparency"
local enabled = false

local transparent_groups = {
  "Normal",
  "NormalNC",
  "NormalFloat",
  "FloatBorder",
  "SignColumn",
  "StatusLine",
  "StatusLineNC",
  "TabLine",
  "TabLineFill",
  "TabLineSel",
  "WinBar",
  "WinBarNC",
  "EndOfBuffer",
  "LineNr",
  "CursorLineNr",
}

local function read_state()
  local ok, lines = pcall(vim.fn.readfile, state_file)

  return ok and lines[1] == "true"
end

local function write_state()
  vim.fn.mkdir(vim.fn.fnamemodify(state_file, ":h"), "p")
  vim.fn.writefile({ enabled and "true" or "false" }, state_file)
end

function M.load()
  enabled = read_state()

  return enabled
end

function M.is_enabled()
  return enabled
end

function M.apply()
  if not enabled then
    return
  end

  for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE" })
  end
end

function M.setup_autocmd()
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("PersistentTransparency", { clear = true }),
    callback = M.apply,
  })
end

function M.set(value)
  enabled = value
  write_state()

  if vim.g.colors_name then
    vim.cmd.colorscheme(vim.g.colors_name)
  end

  M.apply()
end

function M.toggle()
  M.set(not enabled)
  vim.notify("Transparency " .. (enabled and "enabled" or "disabled"))
end

return M
