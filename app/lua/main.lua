local lvgl = require("lvgl")

-- Global variables to store screens
local current_screen = nil
local screens = {}

-- Screen manager
local ScreenManager = {}

function ScreenManager.show_screen(screen_name)
  -- Hide current screen if exists
  if current_screen then
    current_screen:add_flag(lvgl.FLAG.HIDDEN)
  end

  -- Create screen if not exists
  if not screens[screen_name] then
    if screen_name == "root" then
      screens[screen_name] = require("screens.root_screen").create()
    elseif screen_name == "calculator" then
      screens[screen_name] = require("screens.calculator_screen").create()
    elseif screen_name == "icons" then
      screens[screen_name] = require("screens.icons_screen").create()
    elseif screen_name == "calendar" then
      screens[screen_name] = require("screens.calendar_screen").create()
    elseif screen_name == "games" then
      screens[screen_name] = require("screens.games.init").create()
    elseif screen_name == "games_tic_tac_toe" then
      screens[screen_name] = require("screens.games.tic_tac_toe.tic_tac_toe").create()
    elseif screen_name == "settings" then
      screens[screen_name] = require("screens.settings_screen").create()
    elseif screen_name == "music" then
      screens[screen_name] = require("screens.music_screen").create()
    end
  end

  -- Show the selected screen
  if screens[screen_name] then
    screens[screen_name]:clear_flag(lvgl.FLAG.HIDDEN)
    current_screen = screens[screen_name]
  end
end

-- Initialize the application
local function init_app()
  -- Create and show root screen
  ScreenManager.show_screen("root")
end

-- Export ScreenManager for other modules to use
_G.ScreenManager = ScreenManager

-- Start the application
init_app()
