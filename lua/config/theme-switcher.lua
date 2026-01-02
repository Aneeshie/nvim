local M = {}

-- Available themes in order
M.themes = {
	"catppuccin",
	"gruvbox",
	"rose-pine",
	"tokyonight",
}

-- Persistence file path
local data_path = vim.fn.stdpath("data") .. "/theme_settings.json"

-- Load saved settings from file
local function load_settings()
	local file = io.open(data_path, "r")
	if file then
		local content = file:read("*all")
		file:close()
		local success, settings = pcall(vim.json.decode, content)
		if success and settings then
			return settings
		end
	end
	return { theme = "catppuccin", transparent = false }
end

-- Save settings to file
local function save_settings(settings)
	local file = io.open(data_path, "w")
	if file then
		local content = vim.json.encode(settings)
		file:write(content)
		file:close()
	end
end

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
	
	-- Save the theme setting
	local settings = load_settings()
	settings.theme = theme_name
	save_settings(settings)
	
	-- Show notification with current theme
	local theme_display = {
		["catppuccin"] = "Catppuccin Macchiato",
		["gruvbox"] = "Gruvbox Hard",
		["rose-pine"] = "Rose Pine",
		["tokyonight"] = "Tokyo Night",
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

-- Toggle background transparency
local transparent_enabled = load_settings().transparent or false

local function apply_transparency()
	if transparent_enabled then
		-- Make main UI groups transparent so the terminal background shows through
		vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])
		vim.cmd([[highlight NormalNC guibg=NONE ctermbg=NONE]])
		vim.cmd([[highlight SignColumn guibg=NONE ctermbg=NONE]])
		vim.cmd([[highlight LineNr guibg=NONE ctermbg=NONE]])
		vim.cmd([[highlight StatusLine guibg=NONE ctermbg=NONE]])
		vim.cmd([[highlight StatusLineNC guibg=NONE ctermbg=NONE]])
		vim.cmd([[highlight EndOfBuffer guibg=NONE ctermbg=NONE]])
		vim.notify("Background transparency: ON", vim.log.levels.INFO, {
			title = "UI",
			timeout = 1200,
		})
	else
		-- Re-apply the current colorscheme to restore default backgrounds
		local current = vim.g.colors_name or "catppuccin"
		pcall(function()
			vim.cmd.colorscheme(current)
		end)
		vim.notify("Background transparency: OFF", vim.log.levels.INFO, {
			title = "UI",
			timeout = 1200,
		})
	end
end

function M.toggle_transparency()
	transparent_enabled = not transparent_enabled
	apply_transparency()
	
	-- Save transparency setting
	local settings = load_settings()
	settings.transparent = transparent_enabled
	save_settings(settings)
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
	-- Load saved settings
	local settings = load_settings()
	transparent_enabled = settings.transparent or false
	
	-- Try to set the saved theme first, then fallback
	local fallback_themes = { settings.theme, "catppuccin", "default", "habamax" }
	
	for _, theme in ipairs(fallback_themes) do
		if theme and set_theme(theme) then
			-- Apply transparency if it was enabled
			if transparent_enabled then
				apply_transparency()
			end
			break
		end
	end
end

return M
