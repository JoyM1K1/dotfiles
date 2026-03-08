import sys
import os
import datetime

import pyauto
from keyhac import *


def configure(keymap):
    keymap.editor = "C:\\Users\\kohch\\scoop\\apps\\vscode\\current\\Code.exe"

    keymap.replaceKey("LWin","LCtrl")
    keymap.replaceKey("RWin","RCtrl")
    keymap.replaceKey("LCtrl","LWin")
    # keymap.replaceKey("LAlt","RCtrl")
    # keymap.replaceKey("RAlt","RCtrl")
    # keymap.replaceKey("LCtrl","LAlt")
    # keymap.replaceKey("RCtrl","RAlt")
    # keymap.replaceKey("CapsLock", 136)

    # keymap.defineModifier(136, "User0")

    global_keymap = keymap.defineWindowKeymap()

    def ime_off():
        if keymap.getWindow() is None:
            return
        keymap.getWindow().setImeStatus(0)

    def ime_on():
        if keymap.getWindow() is None:
            return
        keymap.getWindow().setImeStatus(1)

    global_keymap["A-C"] = 'C-C'
    global_keymap["A-V"] = 'C-V'

    global_keymap["O-LCtrl"] = lambda: ime_off()
    global_keymap["O-RCtrl"] = lambda: ime_on()

    # global_keymap["U0-H"] = "Left"
    # global_keymap["U0-J"] = "Down"
    # global_keymap["U0-K"] = "Up"
    # global_keymap["U0-L"] = "Right"
    