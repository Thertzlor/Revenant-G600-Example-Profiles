local a, rv = ... ---@type ProfileTemplate, Revenant
local b = a.key
rv.utils.developerMode()
a.config = {
   externalConfigs = "../config/defaultConfig",
   description = "Visual Studio Code\nPowered by Revenant.",
   historyDepth = 10,
   fragileThreads = false,
   defaultThreadInterrupt = true,
   defaultMode = 1,
   multiClickTime = 200
}

-- A number of keys change their bindings when the search key (g4) is pressed
b._c_active_search = {
   c = "g4", --
   g = 2,
   m3 = {"#w", doc = "whole words"},
   m4 = {"#l", doc = "find in selection"},
   m7 = {"#r", doc = "RegEx"},
   m8 = {"#c", doc = "case sensitive"},
}

-- This is what they do normally.
b._c_no_search = {
   c = "-g4",
   m3 = {"/3", {t = "doc", g = 1}, doc = "middle click/actviate doc mode"},
   m4 = {"*s", {"*ks", g = 1}, doc = "Save/Save All"},
   m7 = {"*/D", doc = "previous tab"},
   m8 = {"*/U", doc = "next tab"},
}

b.m5 = "*z" -- Revert

---@type [AssignCycle,AssignSequence]
b.g1 = {
   {t = "c", "*~e", "*~f", "*~g", doc = "Switch between Explorer, Search and Source Control."},
   {t = "s", "*~p", 200, "/b", play = "hold", n = "Quick Navigation", g = 1}
}

---@type [AssignKeyBuffer,AssignKey]
b.g2 = {
   {"~", t = "kb", g = 0, doc = "find Definition of object"},
   {"/12", g = 2, doc = "find occurrences of object"}
}

b.g3 = {
   {type = "sequence", 2000, {t = "ah", -1}},
   {type = "holdkey", "/d", 300, {"\n", {t = "ah", -1}}, b = true, priority = 2, condition = "^g3"},
   "*~r",
   doc = "Refactor menu"
} -- refactor

---@type [AssignKeyBuffer,AssignSequence]
b.g4 = {{t = "kb", "~", g = 1}, {"*f", t = "s", g = 2}, doc = "Search / Global Search"}

---@type [AssignKeyBuffer,AssignKey]
b.g5 = {
   {t = "kb", "~", g = 1, doc = "Previous search result"},
   {"/03", g = 2, doc = "Next search result"}
}

---@type [AssignKey,AssignKey]
b.g6 = {
   {"*/04", doc = "close current file"},
   {"#vls*k/04", g = 1, doc = "Close Other Files"}
}

---@type [AssignCycle,AssignCycle]
b.g7 = {
   {t = "c", "*#b", "*#u", doc = "Expand/Unexpand current bracket"},
   {t = "c", "*k*0", "*k*j", g = 1, doc = "Expand/Unexpand All Brackets"}
}

b.g8 = {
   {"*M", doc = "problems"},
   {"*U", doc = "output", g = 1}
}

b.g9 = {
   {"*/#", doc = "Comment/Uncomment"},
   {"~#a", g = 1, doc = "Multiline Comment"}
}

b.g10 = {
   {"*,", doc = "Preferences"},
   {"*k*s", doc = "shortcuts", g = 1}
}

b.g11 = {
   {"/05", doc = "Debug"},
   {"*D", doc = "Run menu", g = 1}
}

b.g12 = "/e" -- escape