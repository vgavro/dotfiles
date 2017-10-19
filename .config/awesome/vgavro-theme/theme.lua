local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

function get_theme_dir()
  local debug = require("debug")
  return debug.getinfo(1).source:match("(.*)[/\\]"):sub(2)
end

function get_themes_dir()
  local gfs = require("gears.filesystem")
  return gfs.get_themes_dir()
end

-- Color utils
-- Based on https://github.com/MrTheSoulz/NerdPack/blob/master/Libs/DiesalTools-1.0/DiesalTools-1.0.lua
function rgb_color(color)
  return tonumber(string.sub(color, 2, 3), 16), tonumber(string.sub(color, 4, 5), 16),
         tonumber(string.sub(color, 6, 7), 16)
end

-- Mixes a color with pure white to produce a lighter color
function tint_color(color, percent)
  percent = math.min(1, math.max(0, percent))
  local r, g, b = rgb_color(color)
  return string.format("#%02x%02x%02x", math.floor((255-r)*percent+r),
                       math.floor((255-g)*percent+g), math.floor((255-b)*percent+b))
end

-- Mixes a color with pure black to produce a darker color
function shade_color(color, percent, to, from)
  percent = math.min(1, math.max(0, percent))
  local r, g, b = rgb_color(color)
  return string.format("#%02x%02x%02x", math.floor(-r*percent+r), math.floor(-g*percent+g),
                       math.floor(-b*percent+b))
end

function opacity(percent)
  return string.format("%02x", math.floor(255*percent))
end

local PARENT_THEME_NAME = 'default'
local PRIMARY = "#30569C"
local ALERT = "#FF9800"
local WHITE = "#FFFFFF"

local theme = dofile(get_themes_dir() .. "/" .. PARENT_THEME_NAME .. "/theme.lua")

-- Custom properties
theme.opacity_normal = 0.9
theme.opacity_focus = 1
theme.wibar_height = 16
-- Custom properties for awesome-wm-widgets
-- TODO: reuse this colors in own widgets
--theme.widget_main_color = PRIMARY
--theme.widget_red = "#E53935"
--theme.widget_yellow = "#C0CA33"
--theme.widget_green = "#43A047"
--theme.widget_black = "#000000"
--theme.widget_transparent = "#00000000"

theme.font = "xos4 Terminus 10"

theme.bg_normal = shade_color(WHITE, 1) .. opacity(0.8)
theme.bg_focus = PRIMARY
theme.bg_urgent = ALERT
theme.bg_minimize = shade_color(WHITE, 0.7)
theme.bg_systray = theme.bg_normal

theme.fg_normal = shade_color(WHITE, 0.1)
theme.fg_focus  = WHITE
theme.fg_urgent = WHITE
theme.fg_minimize = theme.fg_normal

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(2)
theme.border_normal = shade_color(WHITE, 0.8)
theme.border_focus  = PRIMARY
theme.border_marked = shade_color(ALERT, 0.5)

theme.wallpaper = get_theme_dir() .. "/wallpaper.jpg"

theme.awesome_icon = nil  -- Menu button hidden
return theme
