-- need to install forn awesome and set font_icon in theme.lua
local beautiful = require("beautiful")
local gears = require("gears")
local module = {images={wine="wine.svg",signalFull="PiCellSignalFullBold.svg",signalSlash="PiCellSignalSlashBold.svg"}}
  

function module.get_icon_with_color(name,color)
    local icon_name = module.images[name]
    if(icon_name=="" or icon_name == nil)then
        icon_name = module.images.wine
    end
    return gears.color.recolor_image(beautiful.icons_path .. icon_name , color)
end

return module
