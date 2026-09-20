---@type ProfileTemplate, Revenant
local a = ...
local b = a.key

a.config = {externalConfigs = "../config/defaultConfig", description = "Dwarf Fortress", defaultShift = 0, keyDelay = 30, historyDepth = 50}

-- The library contains some utility functiions that we will often use for menuing.
a.library = {
   ---@type AssignAlterHistory
   wiper = {t = "ah", g = 2},
   ---@type AssignGroup|[AssignAlterHistory,AssignKey]
   back = {{t = "ah", 1, refresh = true}, {"/e", g = 1, inject = "wiper"}, {"_val", g = 0}, template = true},
   ---@type AssignInstance
   back_build = {t = "i", "back", sub = {_val = "/eb"}},
   ---@type AssignInstance
   back_workshop = {t = "i", "back", sub = {_val = "/ebo"}},
}

b.m4 = " " -- pause/unpause

b.m7 = "f" -- toggle water depth
b.m8 = "r" -- toggle slopes

-- The alter history macro makes Revenant forget that m3 was ever pressed.
-- This way middle mouse does not interrupt key sequences or reset cycles when building.
---@type [AssignKey, AssignAlterHistory]
b.m3 = {"/3", {t = "ah", 0, refresh = true, dir = "up"}}


-- This key cycles through build modes, mining, channeling stairs etc.
-- When G-shift is pressed the order of the cycle reverses.
---@type [AssignControl,AssignCycle|[AssignSequence|[AssignSequence]]]
b.g1 = {
   {type = "cyclecontrol", "builder", -2, g = 1, c = "^g1", relative = true, priority = 2},
   {type = "cycle", {{"/2", 100, c = "^g9-g1", t = "s"}, "m", t = "s", ad = 0}, "u", "t", "r", "x", cancel = -2000, n = "builder", g = 2},
}

-- zone menu, G-shift: stockpile menu.
b.g2 = {"z", {"p", g = 1}}

-- Creatures menu, subsequent presses cycle through tabs.
-- G-shift: nobles menu
---@type [AssignGroup|[AssignCycle],AssignKey]
b.g3 = {{{t = "c", "u", "\t", cn = 1, limit = 1, finish = "stall"}, g = 0}, {"n", g = 1}}

-- Building menu. Changes the mouse into building mode afterwards, see below
---@type [AssignKey,AssignGroup|[AssignCycle,AssignAlterHistory]]
b.g4 = {"b", {{t = "c", "v", "g", "t", "f", "m", cancel = -2000}, {t = "ah"}, g = 1}}

-- Work orders menu. G-Shift: open the task menu
b.g5 = {"o", {"t", g = 1}}

-- fortress stocks. G-Shift: labor menu
b.g6 = {"k", {"y", g = 1}}

-- justice menu. subsequent presses cycle through tabs.
-- G-shift: Objects menu
---@type [AssignCycle,AssignKey]
b.g7 = {{t = "c", "j", "\t", cn = 1, limit = 1, finish = "stall", g = 0}, {"O", g = 1}}

-- Minecart hauling routes menu.
-- G-shift: Traffic areas menu. Subsequent presses cycle through traffic options.
---@type [AssignKey,AssignCycle]
b.g8 = {"H", {t = "c", "T", "r", "x", "l", "h", range = {2}, cancel = -1500, g = 1}}

-- Remove Mining/building orders. Note that if we are already in building mode, we need to insert a right click.
-- With G-shift we cycle through the various item designation (forbid, dump, burn) options.
-- The order is just my personal preference.
---@type [AssignCycle,AssignSequence|[AssignSequence,AssignKey]]
b.g9 = {
   {t = "c", "i", "p", "f", "m", "F", range = {2}, cancel = -1500, g = 1},
   {t = "s", {t = "s", "/2", 100, c = "^g1-g9"}, "x", ad = 0}
}

-- Open DFHack
b.g10 = "*D"

-- Recenter Menu, mouse bindings change into a travel mode sub-profile, see below
b.g11 = "h"

--escape
b.g12 = "/e"

-- This is how "sub-profiles" work: For three seconds after g11 is pressed other bindings on the mouse change to F-keys to select a recenter location and close the menu.
-- The location history is then wiped to make sure that repeated g11 presses don't leave the mouse in travel mode when exiting.
b._c_travel = {
   c = "^g11",
   priority = 2,
   blocking = true,
   historyTimeout = 3000,
   inject = "wiper",

   -- All just F-keys for the different locations...
   g1 = {"/01", "/e", t = "s"},
   g2 = {"/02", "/e", t = "s"},
   g3 = {"/03", "/e", t = "s"},
   g4 = {"/04", "/e", t = "s"},
   g5 = {"/05", "/e", t = "s"},
   g6 = {"/06", "/e", t = "s"},
   g7 = {"/07", "/e", t = "s"},
   g11 = "/e"
}

-- DFHack subprofile, currently only stonesense is mapped, feel free to add whatever plugins you like.
b._c_dfHack = {
   c = "^g10",
   priority = 2,
   blocking = true,
   historyTimeout = 3000,
   inject = "wiper",

   g1 = "ssense\n"
}

-- In the building subprofile things get really interesting:
-- The keys on the keypad correspond to the building's position on the menu.
-- g4-g1 goes to the workshops submenu, which activates another sub-profile on the mouse
-- with bindings for the different workshops.
b._c_building = {
   c = "^g4",
   priority = 2,
   blocking = true,
   historyTimeout = 3000,

   g1 = "o", -- Workshops
   g2 = "f", -- Furniture
   g3 = "p", -- Doors/Hatches
   g4 = "n", -- Constructions
   g5 = "m", -- Machines/Fluids
   g6 = "r", -- Cages/restraints
   g7 = "t", -- Traps
   g8 = "y", -- Military
   g9 = {"T", inject = "wiper"} -- Trade Depot
}

-- From here on out, we divide up the submenus into nested and non-nested sub-profiles.
-- We don't wipe the button history for menus with submenus because we need to know  what we pressed to select the next bindings.
-- Also note how we overwrite the standard escape binding on g12 with a binding that lets us return to the previous building menu instead of fully exiting.
b._c_workshop_submenus = {
   c = "^g4-g1",
   priority = 3,
   blocking = true,
   historyTimeout = 3000,

   g1 = "l", -- Clothing/Leather
   g2 = "f", -- Farming
   g3 = "u", -- Furnaces
   g12 = {"back_build", t = "l", g = 2} ---@type AssignLink
}

-- These are the bindings without submenus and here we DO wipe the history after the press.
-- This is because if we press g4 to select the ashery/soapmaker shop,
-- the condition "^g4" is technically true which would put us back into the building subprofile even though we exited the menu.
-- By wiping the button history we only reactivate the building bindings, the NEXT time we press g4.
-- Items in position higher than 10 are selected via G-shift.
b._c_workshop_direct = {
   c = "^g4-g1",
   priority = 3,
   blocking = true,
   historyTimeout = 3000,
   inject = "wiper",

   g1 = {"i", g = 1}, --G-Shift: Metalsmith
   g2 = {"R", g = 1}, -- G-Shift: Screw Press
   g3 = {"g", g = 1}, -- G-Shift: Siege
   g4 = {"y", {"P", g = 1}}, -- Ashery, G-shift: Soap Maker's workshop
   g5 = {"b", {"t", g = 1}}, -- Bowyer, G-Shift: Stoneworker
   g6 = "p", -- Carpenter
   g7 = "r", -- Crafts
   g8 = "j", -- Jeweler
   g9 = "I", -- Magma Forge
   g10 = "h", -- Mechanic
}

b._c_furniture = {
   c = "^g4-g2",
   priority = 3,
   blocking = true,
   historyTimeout = 3000,
   inject = "wiper",

   g1 = {"b", {"y", g = 1}}, -- Bed, G-Shift: Display
   g2 = {"r", {"p", g = 1}}, -- Chair, G-Shift: Offering Place
   g3 = {"t", {"i", g = 1}}, -- Table, G-Shift: Instrument
   g4 = "h", -- Chest
   g5 = "n", -- Cabinet
   g6 = "x", -- Burial
   g7 = "l", -- Slab
   g8 = "u", -- Statue
   g9 = "T", -- Traction Bench
   g10 = "o", -- Bookcase
   g12 = {"back_build", t = "l", g = 2, inject = {}} ---@type AssignLink
}

b._c_doors = {
   c = "^g4-g3",
   priority = 3,
   blocking = true,
   historyTimeout = 3000,
   inject = "wiper",

   g1 = "r", -- Door
   g2 = "h", -- Hatch
   g12 = {"back_build", t = "l", g = 2, inject = {}} ---@type AssignLink
}

b._c_construction = {
   c = "^g4-g4",
   priority = 3,
   blocking = true,
   historyTimeout = 3000,
   inject = "wiper",

   g1 = {"l", {"g", g = 1}}, -- Wall, G-Shift: Floor grate
   g2 = {"l", {"M", g = 1}}, -- Wall, G-Shift: Vertical bars [Why the fuck is there no key for Reinforced wall?]
   g3 = {"f", {"m", g = 1}}, -- Floor, G-Shift, Floor bars
   g4 = {"r", {"y", g = 1}}, -- Ramp, G-Shift: Glass Window
   g5 = {"t", {"Y", g = 1}}, -- Stairs, G-Shift: Gem Window
   g6 = {"b", {"p", g = 1}}, -- Bridge, G-Shift: Support
   g7 = {"o", {"k", g = 1}}, -- Paved road, G-Shift: Track
   g8 = {"O", {"K", g = 1}}, -- Dirt road, G-Shift: Track Stop
   g9 = "F", -- Fortification
   g10 = "G", -- Wall grate
   g12 = {"back_build", t = "l", g = 2, inject = {}} ---@type AssignLink
}

b._c_machines = {
   c = "^g4-g5",
   priority = 3,
   blocking = true,
   historyTimeout = 3000,
   inject = "wiper",

   g1 = {"l", {"r", g = 1}}, -- Lever, G-Shift: Rollers
   g2 = "L", -- Well
   g3 = "f", -- Floodgate
   g4 = "p", -- Screw pump
   g5 = "h", -- Water wheel
   g6 = "m", -- Windmill
   g7 = "g", -- Gear assembly
   g8 = "a", -- Horizontal axle
   g9 = "A", -- Vertical axle
   g10 = "n", -- Millstone
   g12 = {"back_build", t = "l", g = 2, inject = {}} ---@type AssignLink
}

b._c_cages = {
   c = "^g4-g6",
   priority = 3,
   blocking = true,
   historyTimeout = 3000,
   inject = "wiper",

   g1 = "h", -- Rope/Chain
   g2 = "g", -- Cage
   g3 = "t", -- Animal Trap
   g12 = {"back_build", t = "l", g = 2, inject = {}} ---@type AssignLink
}

b._c_traps = {
   c = "^g4-g7",
   priority = 3,
   blocking = true,
   historyTimeout = 3000,
   inject = "wiper",

   g1 = "p", -- Pressure plate
   g2 = "t", -- Stone-fall
   g3 = "o", -- Weapon
   g4 = "g", -- Cage
   g5 = "u", -- Upright spike
   g12 = {"back_build", t = "l", g = 2, inject = {}} ---@type AssignLink
}

b._c_military = {
   c = "^g4-g8",
   priority = 3,
   blocking = true,
   historyTimeout = 3000,
   inject = "wiper",

   g1 = "t", -- Archery target
   g2 = "r", -- Weapon rack
   g3 = "n", -- Armor stand
   g4 = "b", -- Ballista
   g5 = "p", -- Catapult
   g6 = "u", -- Bolt thrower
   g12 = {"back_build", t = "l", g = 2, inject = {}} ---@type AssignLink
}

-- The following are submenus of the workshop section, note how escape goes back to the main workshop menu.
b._c_clothing = {
   c = "^g4-g1-g1",
   priority = 4,
   blocking = true,
   historyTimeout = 3000,
   inject = "wiper",

   g1 = "l", -- Leather
   g2 = "o", -- Loom
   g3 = "k", -- Clothes
   g4 = "y", -- Dyer
   g12 = {"back_workshop", t = "l", g = 2, inject = {}} ---@type AssignLink
}

b._c_farming = {
   c = "^g4-g1-g2",
   priority = 4,
   blocking = true,
   historyTimeout = 3000,
   inject = "wiper",

   g1 = {{"h", g = 1}, "p", t = "g"}, -- Farm plot, G-Shift: Hive
   g2 = "l", -- Still
   g3 = "b", -- Butcher
   g4 = "t", -- Tanner
   g5 = "y", -- Fishery
   g6 = "k", -- Kitchen
   g7 = "f", -- Farmer
   g8 = "q", -- Quern
   g9 = "v", -- Vermin Catcher
   g10 = "n", -- Nest box
   g12 = {"back_workshop", t = "l", g = 2, inject = {}} ---@type AssignLink
}

b._c_furnace = {
   c = "^g4-g1-g3",
   priority = 4,
   blocking = true,
   historyTimeout = 3000,
   inject = "wiper",

   g1 = "g", -- Glass Furnace
   g2 = "k", -- Kiln
   g3 = "G", -- Magma glass furnace
   g4 = "K", -- Magma kiln
   g5 = "L", -- Magma smelter
   g6 = "l", -- Smelter
   g7 = "f", -- Wood furnace
   g12 = {"back_workshop", t = "l", g = 2, inject = {}} ---@type AssignLink
}