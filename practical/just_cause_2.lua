---@type ProfileTemplate, Revenant
local a = ...
local b = a.key
a.config = {extends = "_default_game_profile", description = "Causa justio secunda", clearLog = false}

---@type [AssignKey,AssignCycle]
b.g1 = {
   "f", -- grapple
   {t = "c", "1", "2", cancel = -200, g = 1} -- 1 weapon / dual wield
}

---@type [AssignCycle|[AssignKey,AssignKey],AssignKey]
b.g2 = {
   {t = "c", "/s", {"/s", t = "d"}, cancel = -200}, -- toggle sprint
   {"3", g = 1} -- 2 Handed weapon
}

b.g3 = {
   "e", -- interact
   {"4", g = 1} -- beacon
}

b.g4 = " " -- jump

b.g5 = {
   "\t", -- evade
   {"#d", g = 1} -- stunt jump
}
---@type AssignCycle|[AssignKey,AssignKey]
b.g6 = {t = "c", "/c", {"/c", t = "d"}, cancel = -200} -- crouch
b.g7 = "q" -- melee attack
b.g8 = "r" -- reload
b.g9 = "/01" -- PDA
b.g10 = "g" -- toggle explosives
b.g11 = "x" -- handbrake
b.g12 = "/e" -- escape