local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()

local module = {}

module.x       = "#FF0000"
module.accent  = xrdb.color4
module.error   = xrdb.color9
module.fg      = xrdb.foreground
module.bg      = xrdb.background
module.bg1     = xrdb.color0
module.mute    = xrdb.color7
module.success = xrdb.color6
module.muter   = "#000000"

return module
