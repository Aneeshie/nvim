local M = {}

-- Available themes in order
M.themes = {
	"catppuccin",
	"gruvbox",
	"rose-pine",
}

-- Store last error for full display
local last_error = nil

-- Truncate long error messages
local function truncate_error(err, max_length)
	max_length = max_length or 50
	if #err <= max_length then
		return err
	end
	return err:sub(1, max_length) .. "..."
end

-- Check if colorscheme exists
local function colorscheme_exists(name)
	local success = pcall(function()
		vim.cmd("colorscheme " .. name)
	end)
	return success
end

-- Get current theme index
local function get_current_theme_index()
	local current = vim.g.colors_name or "catppuccin"
	for i, theme in ipairs(M.themes) do
		if current == theme then
			return i
		end
	end
	return 1 -- Default to first theme if not found
end

-- Set theme with proper loading
local function set_theme(theme_name)
	-- First check if theme exists
	if not colorscheme_exists(theme_name) then
		local err = "Theme '" .. theme_name .. "' not installed. Install with :Lazy sync"
		last_error = err
		vim.notify("⚠️  " .. truncate_error(err, 40), vim.log.levels.WARN, {
			title = "Theme Missing",
			timeout = 3000,
		})
		return false
	end
	
	local success, err = pcall(function()
		vim.cmd.colorscheme(theme_name)
	end)
	
	if not success then
		last_error = err
		vim.notify("❌ " .. truncate_error(err, 40), vim.log.levels.ERROR, {
			title = "Theme Error",
			timeout = 3000,
		})
		return false
	end
	
	-- Show notification with current theme
	local theme_display = {
		["catppuccin"] = "Catppuccin Macchiato",
		["gruvbox"] = "Gruvbox Hard",
		["rose-pine"] = "Rose Pine",
	}
	
	vim.notify("󰏘 " .. (theme_display[theme_name] or theme_name), vim.log.levels.INFO, {
		title = "Theme Switched",
		timeout = 1500,
	})
	
	return true
end

-- Cycle to next theme
function M.cycle_theme()
	local current_index = get_current_theme_index()
	local next_index = current_index % #M.themes + 1
	local next_theme = M.themes[next_index]
	
	set_theme(next_theme)
end

-- Set specific theme by name
function M.set_theme(theme_name)
	if vim.tbl_contains(M.themes, theme_name) then
		set_theme(theme_name)
	else
		vim.notify("Theme not available: " .. theme_name, vim.log.levels.WARN)
	end
end

-- Show full error details
function M.show_last_error()
	if last_error then
		vim.notify(last_error, vim.log.levels.ERROR, {
			title = "Full Error Details",
			timeout = 5000,
		})
	else
		vim.notify("No recent errors", vim.log.levels.INFO, {
			title = "Error History",
			timeout = 1000,
		})
	end
end

-- Initialize with default theme
function M.setup()
	-- Try to set a working theme
	local fallback_themes = { "catppuccin", "default", "habamax" }
	
	for _, theme in ipairs(fallback_themes) do
		if set_theme(theme) then
			break
		end
	end
end

return M
