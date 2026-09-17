---@type ProfileTemplate, Revenant
local a = ...
local b = a.key

a.config = {
   externalConfigs = '../config/defaultConfig',
   description = "several implementations of multi-tap.",
   multiClickTime = 250,
   defaultMode = 0
}

a.scopeDefaults = {
   cyclical = true
}


b.mode_1.g1 = "1"
b.mode_1.g2 = {"a", "b", "c", type = "multiclick"}
b.mode_1.g3 = {"d", "e", "f", type = "multiclick"}
b.mode_1.g4 = {"g", "h", "i", type = "multiclick"}
b.mode_1.g5 = {"j", "k", "l", type = "multiclick"}
b.mode_1.g6 = {"m", "n", "o", type = "multiclick"}
b.mode_1.g7 = {"p", "q", "r", "s", type = "multiclick"}
b.mode_1.g8 = {"t", "u", "v", type = "multiclick"}
b.mode_1.g9 = {"w", "x", "y", "z", type = "multiclick"}
b.mode_1.g10 = {"*"}
b.mode_1.g11 = " "
b.mode_1.g12 = "#"







b.shift_1.g1 = "1"
b.shift_1.g2 = "2"
b.shift_1.g3 = "3"
b.shift_1.g4 = "4"
b.shift_1.g5 = "5"
b.shift_1.g6 = "6"
b.shift_1.g7 = "7"
b.shift_1.g8 = "8"
b.shift_1.g9 = "9"
b.shift_1.g11 = "0"