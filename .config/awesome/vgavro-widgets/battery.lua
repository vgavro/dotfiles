local wibox = require("wibox")
local vicious = require("vicious")
local debug = require("debug")
local current_dir = debug.getinfo(1).source:match("(.*)[/\\]"):sub(2)

return function(options)
    options = options or {}
    local icons_dir = options.icons_dir or current_dir .. '/icons'

    local imagebox = wibox.widget.imagebox()
    local textbox = wibox.widget.textbox()

    vicious.register({}, vicious.widgets.bat, function(_, args)
        textbox:set_text(args[2] .. "%")
        if args[1] == "↯" then
            imagebox:set_image(icons_dir .. "/status/battery-full-charged.png")
        elseif args[1] == "+" then
            imagebox:set_image(icons_dir .. "/status/battery-full-charging.png")
        elseif args[2] >= 75 then
            imagebox:set_image(icons_dir .. "/status/battery-full.png")
        elseif args[2] >= 25 then
            imagebox:set_image(icons_dir .. "/status/battery-half.png")
        else
            imagebox:set_image(icons_dir .. "/status/battery-low.png")
        end
    end, options.timeout or 2, options.id or 'BAT0')

    return {
        imagebox,
        textbox,
        layout = wibox.layout.fixed.horizontal
    }
end
