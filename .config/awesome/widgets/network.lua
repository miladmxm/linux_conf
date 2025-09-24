local wibox = require("wibox")
local Icons = require("modules.icons")
local beautiful = require("beautiful")
local naughty = require("naughty")
local awful = require("awful")
local gears = require("gears")
local connectedColor = beautiful.accent
local disconnectedColor = beautiful.mute
local network = {}

local network_state = {status = false};


-- local function showVW()
    
-- end
awful.spawn.easy_async("")
-- awful.popup {
--     widget = {
--         {
--             {
--                 text   = "foobar",
--                 widget = wibox.widget.textbox
--             },
--             {
                
--                     {
--                     text   = "foobar",
--                     widget = wibox.widget.textbox
--                     },
--                     bg     = "#ff00ff",
--                     clip   = true,
--                     shape  = gears.shape.rounded_bar,
--                     widget = wibox.widget.background
          
--             },
--             {
--                 value         = 0.5,
--                 forced_height = 30,
--                 forced_width  = 100,
--                 shape  = gears.shape.rounded_bar,
--                 widget        = wibox.widget.progressbar
--             },
--             layout = wibox.layout.fixed.vertical,
--         },
--         margins = 10,
--         widget  = wibox.container.margin
--     },
--     border_color = beautiful.mute,
--     border_width = 2,
--     placement    = awful.placement.centered,
--     ontop = true,
--     shape        = gears.shape.rounded_rect,
--     visible      = true,
-- }
local function toggle_network_status()
    local net_status = "on"
    if(network_state.status)then
        net_status = "off"
    end
    awful.spawn.easy_async("nmcli networking "..net_status.."",function ()
        network_state.status = not network_state.status
        network:set_widget_icon()
    end)
end


local network_icon = wibox.widget {
    image=Icons.get_icon_with_color("signalFull",beautiful.mute),
    resize = true,
    forced_width=20,
    forced_height=20,
    widget = wibox.widget.imagebox
}

network.net_widget = wibox.widget {
    {
        network_icon,
        halign = "center",
        valign = "center",
        widget = wibox.container.place
    },
    widget = wibox.container.background,
    buttons = gears.table.join(awful.button({ }, 3, function ()
 toggle_network_status()
                                          end))
}
function network:set_widget_icon()
        if(network_state.status)then
            network_icon.image = Icons.get_icon_with_color("signalFull", disconnectedColor)
        else
            network_icon.image = Icons.get_icon_with_color("signalSlash", disconnectedColor)
        end
end

local function check_network_status()
        awful.spawn.easy_async("nmcli networking",function (out)
            if(out:match("enabled"))then
                network_state.status = true
            else
                network_state.status = false
            end
            network:set_widget_icon();
        end)
end

function network:init ()
    local obj = setmetatable({}, network)
    check_network_status()
    obj.timer = timer({ timeout = 5 })
    obj.timer:connect_signal("timeout", function() network:update() end)
    obj.timer:start()

    network:update();
    return network.net_widget;
end

function network:update()

    if(network_state.status) then
        awful.spawn.easy_async("nmcli -t -f STATE,CONNECTIVITY general status",function (out)
            if(out:match("connected:full")) then
                network_icon:set_image(Icons.get_icon_with_color("signalFull",connectedColor))
            else
                network_icon:set_image(Icons.get_icon_with_color("signalFull",disconnectedColor))
            end
        end)
    end
end

return network:init()
