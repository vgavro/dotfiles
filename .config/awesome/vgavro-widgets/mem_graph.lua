local wibox = require("wibox")
local vicious = require("vicious")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()

return function(options)
    options = options or {}

    local graph = wibox.widget {
        max_value = 100,
        color = options.color or xrdb.color10,  -- green
        background_color = beautiful.bg_normal,
        forced_width = options.forced_width or 40,
        step_width = options.step_width or 2,
        step_spacing = options.step_spacing or 1,
        widget = wibox.widget.graph,
    }
    local textbox = wibox.widget {
        font = options.font,
        widget = wibox.widget.textbox,
    }

    vicious.register({}, vicious.widgets.mem, function (_, args)
        graph:add_value(args[1])
        textbox:set_text(args[1] .. "%")
    end, options.timeout or 2)  -- timeout

    return {
        wibox.container.mirror(graph, { horizontal = true, vertical = true }),
        textbox,
        layout = wibox.layout.stack
    }
end
