---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
--local themes_path = gfs.get_themes_dir()
local theme_path = os.getenv("HOME") .. "/.config/awesome/themes/theme/"

local theme = {}

theme.font          = "sans 8"

theme.bg_normal     = "#581014"
theme.bg_focus      = "#c59c1c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#2a0001"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#c59c1c"
theme.fg_focus      = "#581014"
theme.fg_urgent     = "#c59c1c"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(1)
theme.border_width  = dpi(2)
theme.border_normal = "#000000"
theme.border_focus  = "#6b080b"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_path.."icons/submenu.png"
theme.awesome_icon = theme_path.."ussr_logo.png"

theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = theme_path.."icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme_path.."icons/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = theme_path.."icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = theme_path.."icons/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme_path.."icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme_path.."icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active   = theme_path.."icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active    = theme_path.."icons/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme_path.."icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme_path.."icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active   = theme_path.."icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active    = theme_path.."icons/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme_path.."icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme_path.."icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active   = theme_path.."icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active    = theme_path.."icons/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme_path.."icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme_path.."icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme_path.."icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme_path.."icons/titlebar/maximized_focus_active.png"

theme.wallpaper = theme_path.."background"

-- You can use your own layout icons like this:
theme.layout_fairh       = theme_path.."icons/layouts/fairhw.png"
theme.layout_fairv       = theme_path.."icons/layouts/fairvw.png"
theme.layout_floating    = theme_path.."icons/layouts/floatingw.png"
theme.layout_magnifier   = theme_path.."icons/layouts/magnifierw.png"
theme.layout_max         = theme_path.."icons/layouts/maxw.png"
theme.layout_fullscreen  = theme_path.."icons/layouts/fullscreenw.png"
theme.layout_tilebottom  = theme_path.."icons/layouts/tilebottomw.png"
theme.layout_tileleft    = theme_path.."icons/layouts/tileleftw.png"
theme.layout_tile        = theme_path.."icons/layouts/tilew.png"
theme.layout_tiletop     = theme_path.."icons/layouts/tiletopw.png"
theme.layout_spiral      = theme_path.."icons/layouts/spiralw.png"
theme.layout_dwindle     = theme_path.."icons/layouts/dwindlew.png"
theme.layout_cornernw    = theme_path.."icons/layouts/cornernww.png"
theme.layout_cornerne    = theme_path.."icons/layouts/cornernew.png"
theme.layout_cornersw    = theme_path.."icons/layouts/cornersww.png"
theme.layout_cornerse    = theme_path.."icons/layouts/cornersew.png"

-- Generate Awesome icon:
--theme.awesome_icon = theme_assets.awesome_icon(
--    theme.menu_height, theme.bg_focus, theme.fg_focus
--)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil;

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
