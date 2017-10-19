local wibox = require("wibox")
local awful = require("awful")
local debug = require("debug")
local dir = debug.getinfo(1).source:match("(.*)[/\\]"):sub(2)

local function get_image(code)
    -- Stripping whitespace set by keyboardlayout
    code = code:match("^%s*(.-)%s*$")
    return dir .. "/" .. code  .. ".png"
end

return function(options)
    local keyboardlayout = awful.widget.keyboardlayout()
    local code = get_image(keyboardlayout.widget._private.layout.text)
    local imagebox = wibox.widget.imagebox(code, false)
    keyboardlayout.widget.set_text = function (self, code)
        if code then
            self.set_text(code)  -- In case original widget is also used somewhere
            imagebox:set_image(get_image(code))
        end
    end
    return imagebox
end
