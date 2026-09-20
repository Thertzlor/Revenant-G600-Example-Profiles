---@type ProfileTemplate, Revenant
local a = ...
local b = a.key

a.config = {
   externalConfigs = "../config/defaultConfig",
   description = "Default Browser Profile",
}

a.library = {
   goTo = {type = "sequence", {"*t", g = 0}, "*l", 50, "_url", "\n", g = 2, actionDelay = 1, dir = "normal", fragile = false} ---@type AssignSequence
}

b.m3 = {"/3", m = 0}

-- While m3 is pressed you can select another button to go to a specific website.
b._c_favorites = {
   condition = "m3",
   blocking = true,
   gshift = 2,
   priority = 2,
   g1 = {type = "instance", "goTo", substitute = {_url = "github.com"}},
   g2 = {type = "instance", "goTo", substitute = {_url = "localhost"}},
   g3 = {type = "instance", "goTo", substitute = {_url = "wikipedia.org"}},
   g4 = {type = "instance", "goTo", substitute = {_url = "google.com"}}
   -- ...these are just generic examples, obviously you can add more.
}

---@type [AssignKey,AssignKey]
b.m4 = {
   --"*#s",
   "*+", -- zoom in
   {"*-", g = 1} -- zoom out
}

b.m5 = {"*0", g = 2} -- standard zoom

b.m7 = {
   {"/5", m = 0}, -- history Back
   {"*~/U", g = 1} -- move tab left
}

b.m8 = {
   {"/4", m = 0}, -- history Forward
   {"*~/D", g = 1} -- move tab right
}

b.g1 = {
   "*w", -- Close tab
   {"*T", g = 1} -- Re-open last closed tab
}

b.g2 = {
   "*/D" -- Next tab
   --	{"*9", g = 1} -- last tab
}

b.g3 = {
   "*/U" -- previous tab
   --	{"*1", g = 1} -- first tab
}

b.g4 = {"*t", -- new tab
   {"*~n", g = 1} -- new private window
}

b.g5 = {
   "/05", -- refresh
   {"*/05", g = 1} -- full refresh
}

---@type [AssignKey,AssignHoldKey]
b.g6 = {
   "*d", -- bookmark
   {"*D", g = 1} -- bookmark all
}

b.g7 = {
   "*f", -- search
   {"f3", g = 1} -- next search result
}

b.g8 = {
   "*I", -- Developer tools
   {"*J", g = 1} -- javascript console
}

b.g9 = {
   "*j", -- downloads
   {"*h", g = 1} -- history
}

b.g10 = {
   {"*B"}, -- toggle bookmarks bar
   {"*O", g = 1} -- toggle side bar
}

b.g11 = "/11" -- Full Screen

b.g12 = {
   "/e", --escape
   {"#/04", g = 1} -- close browser
}