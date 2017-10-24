local wibox = require("wibox")
local vicious = require("vicious")
local debug = require("debug")
local current_dir = debug.getinfo(1).source:match("(.*)[/\\]"):sub(2)

return function(options)
    options = options or {}
    local icons_dir = options.icons_dir or current_dir .. '/icons'

    local imagebox = wibox.widget.imagebox()
    local textbox = wibox.widget.textbox()

    vicious.register({}, vicious.widgets.volume, function(_, args)
        textbox:set_text(args[1] .. "%")
        if args[2] == "♩" then
            imagebox:set_image(icons_dir .. '/status/audio-volume-muted.png')
        elseif args[1] >= 66 then
            imagebox:set_image(icons_dir .. '/status/audio-volume-high.png')
        elseif args[1] >= 33 then
            imagebox:set_image(icons_dir .. '/status/audio-volume-medium.png')
        else
            imagebox:set_image(icons_dir .. '/status/audio-volume-low.png')
        end
    end, options.timeout or 0.5, options.id or "Master")

    return {
        imagebox,
        textbox,
        layout = wibox.layout.fixed.horizontal
    }
end
