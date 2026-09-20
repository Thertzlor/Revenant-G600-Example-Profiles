local a = ... ---@type ProfileTemplate
local b = a.key

a.config = {extends = "_default_game_profile", description = "Dark Souls"}

b.m7 = {"/E", n = "menu left"}
b.m8 = {"/h", n = "menu right"}
b.m4 = {"/u", n = "menu up"}
b.m5 = {"/d", n = "menu down"}

b.g1 = {"e", n = "interact"}

b.g2 = {" ", n = "dash/roll"}

b.g3 = {"q", n = "targeting"}

b.g5 = {{"~/2", n = "parry"}, {"w", "/1", t = "k", g = 1, n = "kick/alt attack"}}

b.g4 = {"/s", n = "strong attack"}

b.g6 = {"r", n = "use item"}

b.g7 = {"f", n = "switch stance"}

b.g10 = {"g", n = "gesture"}

b.g12 = {"/e", n = "menu"}