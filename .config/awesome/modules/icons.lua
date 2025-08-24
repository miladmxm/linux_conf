-- need to install forn awesome and set font_icon in theme.lua
local wibox = require('wibox')
local beautiful = require("beautiful")

local M = {}

M.home = wibox.widget.textbox()
M.home:set_markup("<span font='" .. beautiful.font_icon .. "'>&#xf015;</span>") -- &#xf015; is the unicode for the home icon
M.folder = wibox.widget.textbox()
M.folder:set_markup("<span font='" .. beautiful.font_icon .. "'>&#xf07b;</span>") -- &#xf07b; is the unicode for the folder
M.code="<span font='" .. beautiful.font_icon .. "'>&#xf121;</span>" -- &#xf121; is the unicode for the code icon
M.network="<span font='" .. beautiful.font_icon .. "'>&#xf012;</span>"-- &#xf0ac; is the unicode for the network icon
return M
