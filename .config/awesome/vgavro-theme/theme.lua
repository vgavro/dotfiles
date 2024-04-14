local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gfs = require("gears.filesystem")
local debug = require("debug")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local current_dir = debug.getinfo(1).source:match("(.*)[/\\]"):sub(2)

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

local WHITE = "#FFFFFF"

local theme = dofile(gfs.get_themes_dir() .. "/default/theme.lua")

-- Custom properties (used only in my rc.lua)
theme.opacity_normal = 0.9
theme.opacity_focus = 1
theme.wibar_height = 16

-- pacman -S terminus-font
-- NOTE: use "Terminus 10" for less than Full HD
theme.font = "Terminus 12"

--theme.bg_normal = shade_color(WHITE, 1) .. opacity(0.8)
theme.bg_normal = "#1e1e1e"
-- theme.bg_focus = -- xrdb.color4 -- DarkBlue
-- theme.bg_focus = "#1358a0"
theme.bg_focus = '#195da5'
-- theme.bg_focus = "#00aaff"
-- #87afff
theme.bg_urgent = xrdb.color11  -- Yellow
theme.bg_minimize = shade_color(WHITE, 0.7)
theme.bg_systray = theme.bg_normal

theme.fg_normal = shade_color(WHITE, 0.1)
theme.fg_focus  = WHITE
theme.fg_urgent = WHITE
theme.fg_minimize = theme.fg_normal

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(2)
theme.border_normal = shade_color(WHITE, 0.8)
-- theme.border_focus  = xrdb.color4 -- DarkBlue
theme.border_focus  = theme.bg_focus
theme.border_marked = xrdb.color3  -- DarkYellow

-- https://awesomewm.org/doc/api/classes/awful.widget.taglist.html
theme.taglist_fg_focus = theme.fg_focus
theme.taglist_bg_focus = theme.bg_focus
theme.taglist_fg_urgent = theme.fg_urgent
theme.taglist_bg_urgent = theme.bg_urgent
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_fg_empty = theme.fg_normal
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_fg_volatile = theme.fg_normal
theme.taglist_bg_volatile = theme.bg_normal
-- ...


theme.wallpaper = current_dir .. "/wallpaper.jpg"

-- theme.awesome_icon = nil  -- Menu button hidden
return theme
