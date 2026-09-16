---@type ProfileTemplate, Revenant
local a, rv = ...
local b = a.key
-- We require developerMode for the math.random calls
rv.utils.developerMode()

a.config = {
   externalConfigs = '../config/defaultConfig',
   description = "Static and random combination locks with 4 numbers",
   debugOutput = true,
   showCompiled = false,
   historyDepth = 4, -- We limit the size of the button history to the length of our lock combination.
   historyTimeout = 2000
}

b.g10 = { --Self explanatory. The macro only outputs its text when the 4 keys in the condition have been pressed in this order.
   {"You cracked the static code!", condition = "^g8-g5-g1-g3"},
   {type = "alterhistory", -1} --Wiping the button history after each submission, to prevent brute forcing.
}

b.g11 = {
   {
      "You cracked the randomized code!",
      name = "randomLock", -- For this macro we generate a condition option with four random buttons as our combination.
      process = function(c, o) -- We also log the combination, so you can look at the logitech console or debug events to "cheat".
         return c, rv.tbl:intersect(o, {condition = rv:pipe(string.gsub("^g0-g0-g0-g0", '0', function() return math.random(9) end), "(random combination)")})
      end
   },
   {type = "alterhistory", -1},
}