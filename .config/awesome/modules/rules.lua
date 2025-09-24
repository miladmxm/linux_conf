local awful = require("awful")
local keys = require("modules.keys")

local rules = {
  {
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      keys = keys.client_keys,
      buttons = keys.client_buttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  },
  {
    rule_any = {
      instance = { "copyq", "pinentry" },
      class = {
        "Arandr",
        "Flows",
        "Blueman-manager",
        "Pavucontrol",
        "Gpick",
        "Kruler",
        "MessageWin",
        "Sxiv",
        "Tor Browser",
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
        "persepolis",
        "Gcolor3",
      },
      name = { "Event Tester" },
      role = { "pop-up" },
    },
    properties = {
      floating = true,
      placement = awful.placement.centered,
      size_hints = { max_height = 300, min_width = 200 },
    },
  },
  {
    rule = { instance = "Flyterm" },
    properties = { floating = true },
    callback = function(c)
      c:geometry({ width = 900, height = 600 })
    end,
  },
  {
    rule = { class = "Zathura" },
    properties = { floating = true, fullscreen = true },
  },
  {
    rule = { class = "Google-chrome" },
    properties = { tag = tags[2] },
  },
  {
    rule = { class = "v2rayN" },
    properties = { tag = tags[7] },
  },
  {
    rule = { class = "Pcmanfm" },
    properties = { tag = tags[4] },
  },
  {
    rule = { class = "mpv" },
    properties = { tag = tags[6] },
  },
  {
    rule = { class = "Code" },
    properties = { tag = tags[3] },
  },
  {
    rule = { class = "TelegramDesktop" },
    properties = { tag = tags[8] },
  },
}

return rules
