---@diagnostic disable: inject-field
---@type ProfileTemplate, Revenant
local a = ...
local b = a.key

--[[=============================================================

   This is a demonstration profile for Revenant containing a cheese recommendation system using a global timer and sequence-check conditions.

--=============================================================]] --

a.config = {
   externalConfigs = '../config/defaultConfig',
   description = "Cheesy mouse",
   detectPausedSequences = true,
   -- It's very important to have this option deactivated, so our sequence macro bound to "start" isn't cancelled by other inputs.
   fragileThreads = false
}

---@type AssignSequence|AssignSequence[]
a.start = {
   -- Every 2-4 seconds a different subsequence runs (3000ms base delay with 2000ms of random variance)
   {3000, "", name = "c1", type = "sequence", actionVariance = 2000},
   {3000, "", name = "c2", type = "sequence", actionVariance = 2000},
   {3000, "", name = "c3", type = "sequence", actionVariance = 2000},
   type = "sequence", loop = -1, name = "big cheese"
}

-- The last button on the thumbpad pauses and unpauses the "big cheese" sequence, freezing the current selection.
---@type AssignControl
b.g12 = {type = "macrocontrol", "big cheese", "toggle"} --[[@as AssignControl]]

-- We define three custom groups (the names after the "_c" can be freely chosen).
-- Each custom group inherits a trigger condition based on one of the subsequences to its child macros.
-- This means the bindings for all buttons (except g12) changes depending which sequence is running.
b._c_mouse_1 = {condition = ":c1"}
b._c_mouse_2 = {condition = ":c2"}
b._c_mouse_3 = {condition = ":c3"}

--Finally, we fill the bindings in all three groups with different cheese names!

b._c_mouse_1.g1 = "Gouda!"
b._c_mouse_1.g2 = "Limburger!"
b._c_mouse_1.g3 = "Sirene!"
b._c_mouse_1.g4 = "Feta!"
b._c_mouse_1.g5 = "Gorgonzola!"
b._c_mouse_1.g5 = "Tilsiter!"
b._c_mouse_1.g6 = "Emmentaler!"
b._c_mouse_1.g7 = "Mascarpone!"
b._c_mouse_1.g8 = "Banbury!"
b._c_mouse_1.g9 = "Camembert!"
b._c_mouse_1.g10 = "Liptauer!"
b._c_mouse_1.g11 = "Rokpol!"

b._c_mouse_2.g1 = "Cheddar!"
b._c_mouse_2.g2 = "Humboldt Fog!"
b._c_mouse_2.g3 = "Tilsiter!"
b._c_mouse_2.g4 = "Cheez Whiz!"
b._c_mouse_2.g6 = "Chulchoill!"
b._c_mouse_2.g7 = "Oka!"
b._c_mouse_2.g8 = "Mozzarella!"
b._c_mouse_2.g9 = "Beaufort!"
b._c_mouse_2.g10 = "Stichelton!"
b._c_mouse_2.g11 = "Munster!"

b._c_mouse_3.g1 = "Paneer!"
b._c_mouse_3.g2 = "Halloumi!"
b._c_mouse_3.g3 = "Sulguni!"
b._c_mouse_3.g4 = "Kurut!"
b._c_mouse_3.g5 = "Havarti!"
b._c_mouse_3.g6 = "Teviotdale!"
b._c_mouse_3.g7 = "Colby!"
b._c_mouse_3.g8 = "Reggianito!"
b._c_mouse_3.g9 = "Monterey Jack!"
b._c_mouse_3.g10 = "Abertam!"
b._c_mouse_3.g11 = "Parmesan!"