---@type ProfileTemplate, Revenant
local a = ...
local b = a.key

a.config = {
   externalConfigs = '../config/defaultConfig',
   description = "several implementations of multi-tap.",
   multiClickTime = 250,
   showCompiled = false,
   defaultMode = 0,
   actionDelay = 1,
   mouseModeCount = 3,
   globalModes = {"multi click", "hold cycle", "manual cycle"}
}

--[[=============================================================

   This is a demonstration profile for Revenant containing three different implementations fo


--=============================================================]] --

b.m3 = {type = "mode", 0} --- the middle mouse button cycles through the trhee modes of multi-tap.

-- The compact and naive approach: cycling multiclick keys.
-- Good for apps that don't delete with backspace, but without a way to "preview" keys.
b.mode_1.g2 = {type = "multiclick", "a", "b", "c", cyclical = true}
b.mode_1.g3 = {type = "multiclick", "d", "e", "f", cyclical = true}
b.mode_1.g4 = {type = "multiclick", "g", "h", "i", cyclical = true}
b.mode_1.g5 = {type = "multiclick", "j", "k", "l", cyclical = true}
b.mode_1.g6 = {type = "multiclick", "m", "n", "o", cyclical = true}
b.mode_1.g7 = {type = "multiclick", "p", "q", "r", "s", cyclical = true}
b.mode_1.g8 = {type = "multiclick", "t", "u", "v", cyclical = true}
b.mode_1.g9 = {type = "multiclick", "w", "x", "y", "z", cyclical = true}
b.mode_1.g1 = {type = "multiclick", ".", ",", "!", "?", cyclical = true}
b.mode_1.g10 = {"*"}
b.mode_1.g11 = " "
b.mode_1.g12 = {type = "keybuffer", "~"} -- Capitalization simply buffers a shift modifier.


--- our second approach involves cycling through the letters while we hold down the key and "finalizing" our input when we release it.
b.mode_2.g2 = {
   {
      {type = "keybuffer", "~", condition = ".caps"}, -- we buffer shift for capitalization if the "caps" flag is set.
      {"a", "b", "c", type = "cycle", cancel = 1, name = "c2"}, --The actual cycling logic, note that we reset the cycle when any other key is pressed.
      "~/l", 500, -- shift + left means the next loop will override the letter we just type. We then wait 500ms, so we have enough time between loops.
      type = "sequence", loop = -1, play = "hold" -- the sequence plays as long as the button is held, looping indefinitely.
   },
   -- Several things happen when we release the key: 
   -- we press "right", so the next letter is inserted in the next position.
   -- we reset our letter cycle to the first position and set the "caps" flag to false, since the input is complete.
   {"right", {type = "cyclecontrol", "c2", 1}, {type = "flag", {"caps", false}}, direction = "up"},
   name = "multihold"
}

-- For the rest of the buttons we either simply copy and paste the assignment with slight alterations...
b.mode_2.g3 = {
   {{type = "keybuffer", "~", condition = ".caps"},
   {"d", "e", "f", type = "cycle", cancel = 1, name = "c3"},"~/l",500,
   type = "sequence",loop = -1,play = "hold"},
   {{"/r", type = "key"}, {type = "cyclecontrol", "c3", 1}, {type = "flag", {"caps", false}}, direction = "up"},
}

-- Or, for a more advanced approach, use modified macro instances for less repetition.
-- Obviously we could use pure lua functions with loops too, I'm just keeping it within the templating language.
b.mode_2.g4 = {type = "instance", "multihold", substitute = {c2 = "c4"}, update = {{"g", "h", "i"}, selector = {1, 2, 1}, method = "listreplace"}}
b.mode_2.g5 = {type = "instance", "multihold", substitute = {c2 = "c5"}, update = {{"j", "k", "l"}, selector = {1, 2, 1}, method = "listreplace"}}
b.mode_2.g6 = {type = "instance", "multihold", substitute = {c2 = "c6"}, update = {{"m", "n", "o"}, selector = {1, 2, 1}, method = "listreplace"}}
b.mode_2.g7 = {type = "instance", "multihold", substitute = {c2 = "c7"}, update = {{"p", "q", "r", "s"}, selector = {1, 2, 1}, method = "listreplace"}}
b.mode_2.g8 = {type = "instance", "multihold", substitute = {c2 = "c8"}, update = {{"t", "u", "v"}, selector = {1, 2, 1}, method = "listreplace"}}
b.mode_2.g9 = {type = "instance", "multihold", substitute = {c2 = "c9"}, update = {{"w", "x", "y", "z"}, selector = {1, 2, 1}, method = "listreplace"}}
b.mode_2.g1 = {type = "instance", "multihold", substitute = {c2 = "c1"}, update = {{".", ",", "!", "?"}, selector = {1, 2, 1}, method = "listreplace"}}

b.mode_2.g10 = {"*"}
b.mode_2.g11 = " "
b.mode_2.g12 = {type = "flag", {"caps", true}} -- set a flag for the next letter to be capitalized.



-- The final implementation utilizes cycle macros directly and involves a lot more state logic:
b.mode_3.g2 = {
   -- We press backspace when the last button pressed was this button and when the sequence s2 is running.
   -- We will later start this sequence ourselves, it acts as the timing window in which we can correct our input.
   {type = "key", "backspace", condition = {"^g2", ":s2", l = "and"}, priority = 4},
   -- We remove the caps flag when the previous button was not this one or the g12. This ensures that only one letter will be capitalized.
   {type = "flag", {"caps", false}, condition = {"|g2", "|g12", l = "and"}, priority = 3},
   -- If the caps flag is still set, we now buffer the shift key.
   {type = "keybuffer", "~", condition = ".caps", priority = 2},
   -- This cycle presses the actual key. It resets after 250ms or when another button is pressed.
   {type = "cycle", "a", "b", "c", cancel = -250} --[[@as AssignCycle]],
   -- This sequence acts as a timer. After a 250ms delay it sets the caps flag to false since the capitalized letter has been typed.
   -- Since the "stack" property is set to 0, the sequence will abort and restart if the button is pressed again within those 250ms.
   {250, {type = "flag", {"caps", false}}, type = "sequence", name = "s2", stack = 0} --[[@as AssignSequence]],
   type = "group",
   name = "multigroup"
}
-- The rest is instances:
b.mode_3.g4 = {
   type = "instance", "multigroup",
   update = {{"d", "e", "f"}, selector = {4, 1}, method = "listreplace"},
   substitute = {["^g2"] = "^g3", [":s2"] = ":s3", ["|g2"] = "|g3", ["s2"] = "s3"}
}
b.mode_3.g4 = {
   type = "instance", "multigroup",
   update = {{"g", "h", "i"}, selector = {4, 1}, method = "listreplace"},
   substitute = {["^g2"] = "^g4", [":s2"] = ":s4", ["|g2"] = "|g4", ["s2"] = "s4"}
}
b.mode_3.g5 = {
   type = "instance", "multigroup",
   update = {{"j", "k", "l"}, selector = {4, 1}, method = "listreplace"},
   substitute = {["^g2"] = "^g5", [":s2"] = ":s5", ["|g2"] = "|g5", ["s2"] = "s5"}
}
b.mode_3.g6 = {
   type = "instance", "multigroup",
   update = {{"m", "n", "o"}, selector = {4, 1}, method = "listreplace"},
   substitute = {["^g2"] = "^g6", [":s2"] = ":s6", ["|g2"] = "|g6", ["s2"] = "s6"}
}
b.mode_3.g7 = {
   type = "instance", "multigroup",
   update = {{"p", "q", "r", "s"}, selector = {4, 1}, method = "listreplace"},
   substitute = {["^g2"] = "^g7", [":s2"] = ":s7", ["|g2"] = "|g7", ["s2"] = "s7"}
}
b.mode_3.g8 = {
   type = "instance", "multigroup",
   update = {{"t", "u", "v",}, selector = {4, 1}, method = "listreplace"},
   substitute = {["^g2"] = "^g8", [":s2"] = ":s8", ["|g2"] = "|g8", ["s2"] = "s8"}
}
b.mode_3.g9 = {
   type = "instance", "multigroup",
   update = {{"w", "x", "y", "z"}, selector = {4, 1}, method = "listreplace"},
   substitute = {["^g2"] = "^g9", [":s2"] = ":s9", ["|g2"] = "|g9", ["s2"] = "s9"}
}
b.mode_3.g1 = {
   type = "instance", "multigroup",
   update = {{".", ",", "!", "?"}, selector = {4, 1}, method = "listreplace"},
   substitute = {["^g2"] = "^g1", [":s2"] = ":s1", ["|g2"] = "|g1", ["s2"] = "s1"}
}

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