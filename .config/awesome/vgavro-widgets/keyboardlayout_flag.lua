local wibox = require("wibox")
local awful = require("awful")
local debug = require("debug")
local current_dir = debug.getinfo(1).source:match("(.*)[/\\]"):sub(2)

function get_image_name(code)
    -- using regexp because original widget set text with spaces around
    return "/" .. code:match("^%s*(.-)%s*$") .. ".png"
end

return function(options)
    options = options or {}
    local flags_dir =  options.flags_dir or current_dir .. '/flags'

    local keyboardlayout = awful.widget.keyboardlayout()
    local code = keyboardlayout.widget._private.layout.text
    local imagebox = wibox.widget.imagebox(flags_dir .. get_image_name(code))

    function change_keyboard_layout ()
        awful.spawn("xkb-switch -n")
    end
    imagebox:connect_signal('button::press', change_keyboard_layout)

    keyboardlayout.widget.set_text = function(self, code)
        if code then
            self.set_text(code)  -- In case original widget is also used somewhere
            imagebox:set_image(flags_dir .. get_image_name(code))
        end
    end

    return imagebox
end
