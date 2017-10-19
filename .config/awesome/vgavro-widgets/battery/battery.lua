local wibox = require("wibox")
local vicious = require("vicious")
local debug = require("debug")
local dir = debug.getinfo(1).source:match("(.*)[/\\]"):sub(2)

return function(options)
    options = options or {}
    local imagebox = wibox.widget.imagebox(nil, false)
    local textbox = wibox.widget.textbox()
    vicious.register({}, vicious.widgets.bat, function(_, args)
        textbox:set_text(args[2] .. "%")
        if args[1] == "↯" then
            imagebox:set_image(dir .. "/battery_plug.png")
        elseif args[1] == "+" then
            imagebox:set_image(dir .. "/battery_charge.png")
        elseif args[2] >= 75 then
            imagebox:set_image(dir .. "/battery_full.png")
        elseif args[2] >= 25 then
            imagebox:set_image(dir .. "/battery_half.png")
        else
            imagebox:set_image(dir .. "/battery_low.png")
        end
    end, options.timeout or 2, options.id or 'BAT0')
    return {imagebox, textbox, layout = wibox.layout.fixed.horizontal}
end
