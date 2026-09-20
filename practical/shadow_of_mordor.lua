---@type ProfileTemplate, Revenant
local a = ...
local b = a.key

a.config = {extends = "_default_game_profile.lua", showCompiled = true, description = "ORCS!", mouseModeConfig = {"default", "stealth"}, LCDHidePrimaryMode = true, defaultMode = 0}

a.library = {
   runTimer = {type = "sequence", {type = "flag", {"runner", true}}, 1000, {type = "flag", {"runner", false}}}
}

---@type [AssignKey,AssignKey,AssignLink]
b.m3 = {{" ", c = "g1", b = true}, {"z", c = "m2", b = true}, {type = "link", "runTimer", c = "g2"}, "/3"}

b.m7 = {"e", {"r", g = 1}, n = "wraith powers"}

b.m8 = {"c", {"t", g = 1}, n = "wraith powers 2"}

b.m4 = {"x", n = "shadow strike"}

b.m5 = {"quote", n = "dagger throw"}

b.g1 = "/c"

---@type [AssignKey,AssignKey,AssignFlag]
b.g2 = {
   {t = "d", " "},
   {t = "u", " ",  dir = "up", c = "*runner"},
   {t = "f", {"runner", false}, dir = "up"},
   unlock = "condition", n = "sprint"
}

b.g3 = {"/e", {"\n", g = 1}, name = "menu"}

---@type AssignHoldKey|[AssignCycle|[AssignGroup|[AssignKey,AssignModeChange],AssignGroup|[AssignKey,AssignModeChange]],string,AssignGroup|[AssignKey,AssignControl,AssignModeChange]]
b.g4 = {
   type = "holdkey",
   {type = "cycle", {{t = "d", "/s"}, {2, t = "m"}}, {{t = "u", "/s"}, {t = "m", 1}}, n = "toggle"}, "",
   {{type = "keyup", "/s"}, {type = "cyclecontrol", "toggle", 1}, {t = "m", 1}}, init = true, holdTime = 350, release = "hold"
}


---@type AssignGroup|[AssignKey,AssignSequence]
b.g5 = {
   {"f", name = "execution"},
   {t = "s", {t = "d", "/s", m = 1}, 400, {{"/1", c = "-g5"}, {"/2", c = "g5"}}, 50, {t = "u", "/s", m = 1}, name = "takedown", keyDelay = 70, g = 1}, n = "kill"
}

b.g6 = {"g", name = "attract"}

b.g7 = {"v", name = "wraith world"}

b.g8 = {"2", name = "power", t = "k"}

b.g9 = {"m", name = "map"}

b.g10 = {"i", {"k", g = 1}, name = "branded activate/dispatch"}

b.g11 = {"2", name = "weapon power"}