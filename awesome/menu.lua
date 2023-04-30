local awful = require("awful")

-- Menu --
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "edit theme",editor_cmd .." ".. os.getenv("HOME") .. "/.config/awesome/themes/" .. "main/theme.lua"},
   { "edit widgets",editor_cmd .." ".. os.getenv("HOME") .. "/.config/awesome/awesome-wm-widgets"},
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome",       myawesomemenu},
                                    { "Firefox",       browser      },
                                    { "TextEditor",    texteditor   },
                                    { "Office",    {
					{"Writer", "libreoffice --writer" },
					{"Calc",   "libreoffice --calc"   },
					{"Impress","libreoffice --impress"},
				    }},
                                    { "FileManager",   filemanager  },
                                    { "Shutdown", { 
					{"Shutdown", "shutdown"       },
					{"Now",      "shutdown now"   },
					{"Reboot",   "shutdown now -r"},
					{"Cancel",   "shutdown -c"    },
			    		}},
                                 }
                })

