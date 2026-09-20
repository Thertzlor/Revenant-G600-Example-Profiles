---@type ProfileTemplate, Revenant
local a = ...
local b = a.key

a.config = {clearLog = true, externalConfigs = "../config/defaultConfig", noMacroExtension = true, debugOutput = true}

b.m4 = "/05"
b.m5 = "/09"

b.g1 = "e"
b.g2 = "/s"
b.g3 = "i"
b.g4 = "/c"
b.g5 = "r"
b.g6 = "q"
b.g9 = "m"
b.g10 = "\t"
b.g12 = {{"/e", n = "esc"}, {t = "doc", g = 1}, t = "g"}

a.documentation = {
   m3 = "middle mouse",
   m4 = "+quicksave:",
   m5 = "+quickload:",
   g1 = "+interaction:",
   g2 = "+sprint:",
   g3 = "+inventory:",
   g4 = "+crouch:",
   g5 = "+reload:",
   g6 = "+q:",
   g9 = "+map:",
   g10 = "+tab menu:",
   esc = "+Escape.\nG-Shift for documentation mode"
}