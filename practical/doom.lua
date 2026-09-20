---@type ProfileTemplate, Revenant
local a = ...
local b = a.key

a.config = {extends = "_default_game_profile", description = "Rip and Tear!", clearLog = false}

b.m4 = "\t" -- map

b.m5 = "/a" -- mission info

b.m7 = "r" -- change weapon mod

b.m8 = {"/01", {"/02", g = 1}} -- Change Equipment

b.g1 = "f" -- glory kill

b.g2 = "e" -- interact

b.g3 = "q" -- weapon switch

b.g4 = {"g", {"t", g = 1}} -- Chainsaw/BFG

b.g5 = {"4", {"3", g = 1}} -- Assault rifle / Plasma rifle

b.g6 = {"6", {"2", g = 1}} -- super shotgun / combat shotgun

b.g8 = {"7", {"5", g = 1}} --  Gauss cannon/ Rocket launcher

b.g9 = {"8", {"1", g = 1}} -- Chaingun/Pistol

b.g7 = {"c", {"/s", g = 1}} --crouch

b.g10 = "/a" -- Mission info