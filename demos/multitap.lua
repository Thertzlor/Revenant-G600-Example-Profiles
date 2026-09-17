---@type ProfileTemplate, Revenant
local a = ...
local b = a.key

a.config = {
   externalConfigs = '../config/defaultConfig',
   description = "several implementations of multi-tap.",
   multiClickTime = 250,
   showCompiled = false,
   --  clearLog = true,
   defaultMode = 0,
   actionDelay = 1,
   mouseModeCount = 3,
   globalModes = {"multi click", "manual cycle", "hold cycle"}
}

a.scopeDefaults = {
   cyclical = true
}

b.m3 = {type = "mode", 0} --- middle mouse button cycles through modes.

-- The compact and naive approach: cycling multiclick keys.
-- Good for apps that don't delete with backspace, but without a way to "preview" keys.
b.mode_1.g2 = {type = "multiclick", "a", "b", "c"}
b.mode_1.g3 = {type = "multiclick", "d", "e", "f"}
b.mode_1.g4 = {type = "multiclick", "g", "h", "i"}
b.mode_1.g5 = {type = "multiclick", "j", "k", "l"}
b.mode_1.g6 = {type = "multiclick", "m", "n", "o"}
b.mode_1.g7 = {type = "multiclick", "p", "q", "r", "s"}
b.mode_1.g8 = {type = "multiclick", "t", "u", "v"}
b.mode_1.g9 = {type = "multiclick", "w", "x", "y", "z"}
b.mode_1.g1 = {type = "multiclick", ".", ",", "!", "?",}
b.mode_1.g10 = {"*"}
b.mode_1.g11 = " "
b.mode_1.g12 = {type = "keybuffer", "~"} -- Capitalization simply buffers a shift modifier.



b.mode_2.g2 = {
   {type = "key", "backspace", condition = {"^g2", ":s2", l = "and"}, priority = 4},
   {type = "flag", {"caps", false}, condition = {"|g2", "|g12", l = "and"}, priority = 3},
   {type = "keybuffer", "~", condition = ".caps", priority = 2},
   {type = "cycle", "a", "b", "c", cancel = -250} --[[@as AssignCycle]],
   {250, {type = "flag", {"caps", false}}, type = "sequence", name = "s2", stack = 0} --[[@as AssignSequence]],
   type = "group",
   name = "multigroup"
}
-- For the rest of the buttons we either simply copy and paste the assignment...
b.mode_2.g3 = {
   {type = "key", "backspace", condition = {"^g3", ":s3", l = "and"}, priority = 4},
   {type = "flag", {"caps", false}, condition = {"|g3", "|g12", l = "and"}, priority = 3},
   {type = "keybuffer", "~", condition = ".caps", priority = 2},
   {type = "cycle", "d", "e", "f", cancel = -250} --[[@as AssignCycle]],
   {250, {{type = "flag", {"caps", false}}}, type = "sequence", name = "s3", stack = 0} --[[@as AssignSequence]],
   type = "group"
}
-- Or, for a more advanced approach, use modified macro instances for less repetition.
-- Obviously we could use pure lua functions with loops too, I'm just keeping it within the templating language.
b.mode_2.g4 = {
   type = "instance",
   "multigroup",
   update = {{"g", "h", "i"}, selector = {4, 1}, method = "listreplace"},
   substitute = {["^g2"] = "^g4", [":s2"] = ":s4", ["|g2"] = "|g4", ["s2"] = "s4"}
} --[[@as AssignInstance]]

b.mode_2.g5 = {
   type = "instance",
   "multigroup",
   update = {{"j", "k", "l"}, selector = {4, 1}, method = "listreplace"},
   substitute = {["^g2"] = "^g5", [":s2"] = ":s5", ["|g2"] = "|g5", ["s2"] = "s5"}
} --[[@as AssignInstance]]

b.mode_2.g6 = {
   type = "instance",
   "multigroup",
   update = {{"m", "n", "o"}, selector = {4, 1}, method = "listreplace"},
   substitute = {["^g2"] = "^g6", [":s2"] = ":s6", ["|g2"] = "|g6", ["s2"] = "s6"}
} --[[@as AssignInstance]]

b.mode_2.g7 = {
   type = "instance",
   "multigroup",
   update = {{"p", "q", "r", "s"}, selector = {4, 1}, method = "listreplace"},
   substitute = {["^g2"] = "^g7", [":s2"] = ":s7", ["|g2"] = "|g7", ["s2"] = "s7"}
} --[[@as AssignInstance]]

b.mode_2.g8 = {
   type = "instance",
   "multigroup",
   update = {{"t", "u", "v",}, selector = {4, 1}, method = "listreplace"},
   substitute = {["^g2"] = "^g8", [":s2"] = ":s8", ["|g2"] = "|g8", ["s2"] = "s8"}
} --[[@as AssignInstance]]

b.mode_2.g9 = {
   type = "instance",
   "multigroup",
   update = {{"w", "x", "y", "z"}, selector = {4, 1}, method = "listreplace"},
   substitute = {["^g2"] = "^g9", [":s2"] = ":s9", ["|g2"] = "|g9", ["s2"] = "s9"}
} --[[@as AssignInstance]]

b.mode_2.g1 = {
   type = "instance",
   "multigroup",
   update = {{".", ",", "!", "?"}, selector = {4, 1}, method = "listreplace"},
   substitute = {["^g2"] = "^g1", [":s2"] = ":s1", ["|g2"] = "|g1", ["s2"] = "s1"}
} --[[@as AssignInstance]]

b.mode_2.g10 = {"*"}
b.mode_2.g11 = " "
b.mode_2.g12 = {type = "flag", {"caps", true}} -- set a flag for the next letter to be capitalized.



---



b.mode_3.g2 = {
   {
      {type = "keybuffer", "~", condition = ".caps"},
      {"a", "b", "c", type = "cycle", cancel = 1, name = "c2"},
      "~/l",
      500,
      type = "sequence",
      loop = -1,
      play = "hold"
   },
   {{"/r", type = "key"}, {type = "cyclecontrol", "c2", 1}, {type = "flag", {"caps", false}}, direction = "up"},
   name = "multihold"
}
b.mode_3.g3 = {
   {
      {type = "keybuffer", "~", condition = ".caps"},
      {"d", "e", "f", type = "cycle", cancel = 1, name = "c3"},
      "~/l",
      500,
      type = "sequence",
      loop = -1,
      play = "hold"
   },
   {{"/r", type = "key"}, {type = "cyclecontrol", "c3", 1}, {type = "flag", {"caps", false}}, direction = "up"},
}

--or we can use our trusty instance macro:
b.mode_3.g4 = {type = "instance", "multihold", substitute = {c2 = "c4"}, update = {{"g", "h", "i"}, selector = {1, 2, 1}, method = "listreplace"}}
b.mode_3.g5 = {type = "instance", "multihold", substitute = {c2 = "c5"}, update = {{"j", "k", "l"}, selector = {1, 2, 1}, method = "listreplace"}}
b.mode_3.g6 = {type = "instance", "multihold", substitute = {c2 = "c6"}, update = {{"m", "n", "o"}, selector = {1, 2, 1}, method = "listreplace"}}
b.mode_3.g7 = {type = "instance", "multihold", substitute = {c2 = "c7"}, update = {{"p", "q", "r", "s"}, selector = {1, 2, 1}, method = "listreplace"}}
b.mode_3.g8 = {type = "instance", "multihold", substitute = {c2 = "c8"}, update = {{"t", "u", "v"}, selector = {1, 2, 1}, method = "listreplace"}}
b.mode_3.g9 = {type = "instance", "multihold", substitute = {c2 = "c9"}, update = {{"w", "x", "y", "z"}, selector = {1, 2, 1}, method = "listreplace"}}
b.mode_3.g1 = {type = "instance", "multihold", substitute = {c2 = "c1"}, update = {{".", ",", "!", "?"}, selector = {1, 2, 1}, method = "listreplace"}}

b.mode_3.g10 = {"*"}
b.mode_3.g11 = " "
b.mode_3.g12 = {type = "flag", {"caps", true}} -- set a flag for the next letter to be capitalized.



-- ...Numbers are always on G-Shift.
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
b.shift_1.g12 = "#"