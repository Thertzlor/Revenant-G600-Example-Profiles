---@type ProfileTemplate, Revenant
local a, rv = ...
local b = a.key

a.config = {externalConfigs = '../config/defaultConfig', description = "Non-modifier key detection"}

-- This function imports the file containing the table of pressed keys.
local function _getTable() return rv.importer:loadFile("@profiles/keydetect_ahk/keysdown.lua") end
-- The condition function returns an anonymous function without arguments that does the actual check
local function keydown(key) return function() return _getTable()[key] ~= nil end end

-- This macro triggers only when the minus key is pressed on the keyboard.
-- This works because the condition can include functions to be evaluated whenever the macro triggers.
b.g1 = {"a", condition = keydown("-")}

-- This macro triggers only when the minus key is NOT pressed on the keyboard.
-- The logic mode "not" inverts any result so we don't need a separate "not pressed" check function
b.g2 = {"b", condition = {keydown("-"), logic = "not"}}

-- Polling for keyboard events:
-- Once this sequence is running it checks if the minus key is pressed every 50ms and outputs "c" when it is.
-- This is as close as we can get to *active* keyboard bindings
b.g3 = {type = "sequence", 50, {"c", condition = keydown("-")}, loop = -1, play = "toggle"} --[[@as AssignSequence]]

-- A more sophisticated example of the above macro that avoids button spam:
-- If the minus key is pressed and the "d_p" flag is not already set, the "d" key is pressed.
-- The second macro toggles the flag if it is either set or minus is pressed, but not both, implicitly detecting a key-up event.
-- This results in in "d" being pressed only once.
b.g4 = { type = "sequence",50,{
      {"d", condition = {'*d_p', keydown("-"), logic = "and"}} --[[@as AssignKey]],
      {type = "flag", "d_p", toggle = true, condition = {".d_p", keydown("-"), logic = "xor"}} --[[@as AssignFlag]]
   },loop = -1,play = "toggle"} --[[@as AssignSequence]]