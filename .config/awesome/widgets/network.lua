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

local function set_icon_color(icon_name,color)
    return gears.color.recolor_image(beautiful.icons_path .. icon_name , color)
end

local network_icon = wibox.widget {
    image=set_icon_color("PiCellSignalFullBold.svg",beautiful.mute),
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
            network_icon.image = gears.color.recolor_image(beautiful.icons_path .. "PiCellSignalFullBold.svg", beautiful.mute)
        else
            network_icon.image = gears.color.recolor_image(beautiful.icons_path .. "PiCellSignalSlashBold.svg", beautiful.mute)
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
                network_icon:set_image(set_icon_color("PiCellSignalFullBold.svg",beautiful.accent))
            else
                network_icon:set_image(set_icon_color("PiCellSignalFullBold.svg",beautiful.mute))
            end
        end)
    end
    
end

network:init()

return network.net_widget
