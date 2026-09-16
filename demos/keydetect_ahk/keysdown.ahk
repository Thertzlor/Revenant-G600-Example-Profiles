#Requires AutoHotkey 2
lastDown := -1

saveFile(content) {
    file := FileOpen("./keysdown.lua", "w")
    file.Write(content)
    file.Close()
}

getPressedKeys() {
    pressed := ''
    loop 0xFF
        if GetKeyState(key := Format('VK{:02X}', A_Index)) {
            pressed .= '["' GetKeyName(key) '"] = 1,'
        }
    pressed := "return {" SubStr(pressed, 1, StrLen(pressed) - 1) "}"
    try saveFile(pressed)
}

KU(_, __, ___) {
    global lastDown
    lastDown := -1
    Sleep(1)
    getPressedKeys()
}

KD(_, __, SC) {
    global lastDown
    if (lastDown != SC) {
        getPressedKeys()
    }
    lastDown := SC
}

saveFile("return {}")
Hook := InputHook("VL0")
Hook.KeyOpt("{All}", "+N")
Hook.OnKeyUp := KU
Hook.OnKeyDown := KD
Hook.Start()