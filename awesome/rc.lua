pcall(require, "luarocks.loader")
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local lain = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

require("layouts")
local vars = require("vars")
local menu_items = require("menu")

-- Custom widget -- 
--local volume_widget   = require("awesome-wm-widgets.volume-widget.volume")
local pactl           = require("awesome-wm-widgets.pactl-widget.volume")
local net_widget      = require("awesome-wm-widgets.net-speed-widget.net-speed")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local todo_widget     = require("awesome-wm-widgets.todo-widget.todo")

-- End Custom --
-- Custom Vars --
local scrot_dir = os.getenv("HOME") .. "/Pictures/scrot/"
local modkey = "Mod4"
-- End Custom Vars --

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/" .. "main/theme.lua")


-- Menubar configuration
local mymainmenu = awful.menu({ items = menu_items}); --Who wrote it?

menubar.utils.terminal = "alacritty" -- Set the terminal for applications that require it
local terminal = menubar.utils.terminal;

-- }}}

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock("  %H : %M  ")
local function rounded_rect(cr, w, h)
	gears.shape.rounded_rect(cr, w, h, 4)
end
mytextclock = wibox.container.background(mytextclock, "#222222BB", function(cr, w, h)
	gears.shape.rounded_rect(cr, w, h, 4)
end);

local cw = calendar_widget({
	placement = 'top_right',
	theme = 'nord',
	radius = 0,
});

mytextclock:connect_signal("button::press",
	function(_, _, _, button)
		if button == 1 then cw.toggle() end
	end)
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 450 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
--local praisewidget = wibox.widget.textbox("test")
local emptywidget = wibox.widget.textbox("")
--emptywidget = wibox.container.background(emptywidget, "#11111100")

--local praisewidget = wibox.widget.imagebox(.. "/Project/stable-diffusion-webui/outputs/img2img-images/2024-02-07/00002-452827312.png", true);



awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    --gears.wallpaper.maximized("/tmp/1.jpg", s)
    gears.wallpaper.set("#222222")
    -- Each screen has its own tag table.
    awful.tag({ "Ⅰ" , "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    --[[s.mylayoutbox:buttons(gears.table.join())
                    	awful.button({ }, 1, function () awful.layout.inc( 1) end),
                    	awful.button({ }, 3, function () awful.layout.inc(-1) end),
                        awful.button({ }, 4, function () awful.layout.inc( 1) end),
                        awful.button({ }, 5, function () awful.layout.inc(-1) end)))
			 --]]
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
	--[[widget_template = {
        {
            {
                {
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    left = 5,
                    right = 5,
                    widget = wibox.container.margin
                },
                widget = wibox.container.place
            },
            id     = 'background_role',
            widget = wibox.container.background,
            shape  = rounded_rect,
            bg     = "#FFFFFF"
        },
        widget = wibox.container.margin,
    },
--]]
}
    -- Create a tasklist widget --
    --[[
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,

	buttons = tasklist_buttons,
	layout = wibox.layout.flex.horizontal(),
}
--]]
--[ [
s.mytasklist = awful.widget.tasklist {
	screen   = s,
	filter   = awful.widget.tasklist.filter.currenttags,
	buttons  = tasklist_buttons,
	style    = {
		shape_border_width = 1,
		shape_border_color = beautiful.bg_focus,
		shape  = gears.shape.rectangle,
	},
	layout   = {
		spacing = 2,
		--[[
		spacing_widget = {
			{
				forecd_width = 5,
				shape        = gears.shape.circle,
				widget       = wibox.widget.separator
			},
			valign = 'center',
			halign = 'center',
			widget = wibox.container.place,
		},
		--]]
		layout  = wibox.layout.flex.horizontal
	},
	-- Notice that there is *NO* wibox.wibox prefix, it is a template,
	-- not a widget instance.
	widget_template = {
		{
			{
				{
					{
						id     = 'icon_role',
						widget = wibox.widget.imagebox,
					},
					margins = 3,
					widget  = wibox.container.margin,
				},
				{
					id     = 'text_role',
					widget = wibox.widget.textbox,
				},
				layout = wibox.layout.fixed.horizontal,

            },
            left  = 10,
            right = 10,
            widget = wibox.container.margin,
        },
        id     = 'background_role',
        widget = wibox.container.background,
    },
}
--]]

    -- Create the wibox
    --s.topbox = awful.wibar({ position = "top", screen = s, --[[bg = "#FFFFFF00"--]]})
    s.topbox = awful.wibar({ position = "top", screen = s, bg = "#FFFFFF00"})
    --s.topbox = wibox.container.background(s.topbox, "#11111100")

    s.botbox= awful.wibar({ position = "bottom", screen = s })

    -- Add widgets to the wibox
    s.topbox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
	    layout = wibox.layout.fixed.horizontal,
            s.mylayoutbox,
            s.mytaglist,
            s.mypromptbox,
        },
        --s.mytasklist, -- Middle widget
--	emptywidget,
	nil,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
	    net_widget(),
	    pactl{widget_type='arc'},
	    mytextclock,
	    todo_widget(),
    },
      }
      s.botbox:setup{
	      layout = wibox.layout.fixed.horizontal,
	      nil,
	      s.mytasklist,
	      nil,
      }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
    --[[
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
    --]]
))
-- }}}

local t_script_pid = nil
local t_timer = nil
local t_script_pid = nil

-- Function to check if a process is running by PID
local function is_process_running(pid)
    local handle = io.popen("ps -p " .. pid)
    local result = handle:read("*a")
    handle:close()

    return result:find(tostring(pid)) ~= nil
end
-- Add keybinding

globalkeys = gears.table.join(

--[[
awful.key({ "Ctrl" }, "q", function()
	if not t_script_pid then

		t_script_pid = awful.spawn("xdotool key --repeat 999999 --delay 6 q", {
			detached = true
		})

		if t_script_pid and t_script_pid > 0 then
			naughty.notify({ 
				text = "Key repeat started with PID: " .. t_script_pid,
				timeout = 2
			})
		else
			naughty.notify({ 
				text = "Failed to start key repeat",
				timeout = 2,
				preset = naughty.config.presets.critical
			})
		end
	else
		naughty.notify({ 
			text = "Key repeat is already running PID: " .. t_script_pid,
			timeout = 2,
			preset = naughty.config.presets.info
		})
	end
end, { description = "Start key repeat", group = "custom" }),


--[ [
awful.key({ "Mod1", "Shift" }, "q", function()
	if t_script_pid then
		if is_process_running(t_script_pid) then
			awful.spawn.easy_async_with_shell("kill " .. t_script_pid, function(stdout, stderr, reason, exit_code)
				if exit_code == 0 then
					naughty.notify({ 
						text = "Key repeat stopped",
						timeout = 2
					})
					t_script_pid = nil
				else
					naughty.notify({ 
						text = "Failed to stop key repeat: " .. stderr,
						timeout = 2,
						preset = naughty.config.presets.critical
					})
				end
			end)
		else
			naughty.notify({ 
				text = "Process with PID " .. t_script_pid .. " is no longer running",
				timeout = 2,
				preset = naughty.config.presets.info
			})
			t_script_pid = nil
		end
	else
		naughty.notify({ 
			text = "No key repeat process is running",
			timeout = 2,
			preset = naughty.config.presets.info
		})
	end
end, { description = "Stop key repeat", group = "custom" }),

--]]



--CustomKey
--]]

awful.key({ }, 'XF86AudioRaiseVolume', function() pactl:inc() end),
awful.key({ }, 'XF86AudioLowerVolume', function() pactl:dec() end),
awful.key({ }, 'XF86AudioMute'       , function() pactl:toggle() end),

awful.key({ modkey,  "Control" }, "l", function () awful.util.spawn_with_shell("betterlockscreen -l") end) ,
awful.key({ " ", }, scrot_key, function () awful.util.spawn_with_shell("scrot " .. scrot_dir .. '%Y-%m-%d_%T.png' .. " -q100") end),


--EndCustom


    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey, "Shift" }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)


clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, 	  }, "x",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
awful.button({ }, 1, function (c)
	c:emit_signal("request::activate", "mouse_click", {raise = true})
end),
awful.button({ modkey }, 1, function (c)
	c:emit_signal("request::activate", "mouse_click", {raise = true})
	awful.mouse.client.move(c)
end),
awful.button({ modkey }, 3, function (c)
	c:emit_signal("request::activate", "mouse_click", {raise = true})
	awful.mouse.client.resize(c)
end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false} --titlebar Enable
    },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)


client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

--awful.spawn.with_shell('TERM=alacritty')

-- }}}
