# Revenant G600 Example Profiles
This is a collection of Revenant profiles for the Logitech G600 designed to give an overview of what sort of functionality is possible from basic bindings to advanced logic and integration of external tools.

For more information see the main **Revenant** repository: https://github.com/Thertzlor/Revenant

Included here is a folder of *demo* profiles which showcase of Revenant capabilities without focusing on direct usefulness, as well as a *practical* folder which contains Revenant profiles for real games and applications that I have actually used day-to-day.

# How to use
After following the [setup guide](https://github.com/Thertzlor/Revenant#setup) for Revenant and setting the script to use external profiles, simply copy the contents of this repository into your profile folder, then simply load it via the path settings (the following example loads the Multi-tap Thumbpad profile):

```lua
rv.profileName = "multitap"
rv.profilePath = "@rv/profiles/examples/demos"
rv.externalProfile = true 
```
> [!Important]
These profiles rely on a basic [configuration](https://github.com/Thertzlor/Revenant/wiki/Profile-Overview#configuration) file, in the `/config` directory which they will automatically load. This configuration includes renaming scheme that renames the buttons **m9-m20** to **g1-g12** and switches the names for **m4**  and **m8** and **m5** and **m7**.  
In my experience the G600 thumbpad is far more intuitively usable if you don't have to start counting from 9 (same for and having m4 and m5 at the top buttons instead of the awkward sideways wheel click).  
Keep that in mind if the key names don't line up with what you are expecting and feel free to rename them if it *really* bothers you I guess.

The repo contains the following profiles:
# Demos

## Multi-tap thumbpad
Turn the thumbpad of your G600 into an Multi-Tap keyboard as found on old mobile phones, implementing the E.161 standard.   
This profile offers three different implementations of the keypad logic, each one highlighting a different aspect of Revenant's macro system.

* [Multiclick Macros](https://github.com/Thertzlor/Revenant/wiki/Multiclick-Macro) with cyclical behavior and [key buffers](https://github.com/Thertzlor/Revenant/wiki/Key-Buffer-Macro).
* [Sequence Macros](https://github.com/Thertzlor/Revenant/wiki/Sequence-Macro) with nested cycles, [key-release triggers](https://github.com/Thertzlor/Revenant/wiki/Macro-Overview#direction) and timeouts.
* [Manual Cycles](https://github.com/Thertzlor/Revenant/wiki/Cycle-Macro), modifying behavior in response to [previously pressed buttons](https://github.com/Thertzlor/Revenant/wiki/Condition-Syntax#condition-types) and managing state via [flags](https://github.com/Thertzlor/Revenant/wiki/Flag-Macro).

This profile also makes heavy use of templating via [Instance Macros](https://github.com/Thertzlor/Revenant/wiki/Instance-Macro) for bindings with similar functionality.

## Combination lock
A profile that demonstrates [key sequence conditions](https://github.com/Thertzlor/Revenant/wiki/Condition-Syntax#key-series) and [process functions](https://github.com/Thertzlor/Revenant/wiki/Macro-Overview#process) to implement a 4-number "lock" on your mouse.
The macros on the buttons G10 and and G11 will only trigger if you pressed 4 other buttons on the thumbpad in the right order with less than a 2 second pause in between.

There are two locks implemented:
* The lock on G10 is static, you can simply view the combination in the profile file.
* The lock on G11 will generate a random combination each time you activate the profile (You can cheat by viewing the current generated combination in the log)

## Keyboard key detection via Autothotkey
A demonstration of how we can use the capability to dynamically load .lua files to react to events that LGS cannot detect normally.
* This profile requires running a separate .ahk script (not an actual keylogger, don't worry) which logs the currently pressed keys into a lua table.
  * Simply run `keysdown.ahk` in the .ahk subfolder before starting the profile.  
  (for real world applications this can be automated using an External Macro in the start binding pointing a shortcut command in LGS)
* The script can then read that table on demand and use it for [macro conditions]().

It might seem stupid that the proposed solution to extend LGS functionality is simply using a tool (AHK) that could already press the keys itself but in my opinion there's value in letting one side only collect generic information and not having application profiles for lots of apps in two places.  
Obviusly the techniques showcased in this profile can be extended to any program that could log useful information to a .lua file.

## Cheese Board
So... mice like cheese, so turn the thumbpad of your G600 mouse into a cheese board, each key writing out the name of a kind of cheese. The kind of cheese on each key will change every 2-4 seconds, cycling between 3 values (please don't put real cheese on your mouse).  

* This profile utilizes a global timer, implemented as a [sequence macro](https://github.com/Thertzlor/Revenant/wiki/Sequence-Macro) that starts looping the moment the profile is loaded using the [start](https://github.com/Thertzlor/Revenant/wiki/Profile-Overview#start-and-exit-bindings) binding.
* The functionality of the key is bound to the currently active subsequence of the main timing sequence, demonstrating how profiles can store and manage state using only macros.

I was mostly using cheese names that I am personally aware of, so apologies that the selection might have ended up a bit eurocentric (in my defence, I was also trying to avoid word with nonstandard letters and accents for the sake of compatibility).


# Practical
A lot of this is just personal preference

## Games

### Default Gaming Profile
This is a base profile that aims to cover most key conventions of modern-ish video games, such as `e` for interact, `i` for inventory `r` for reload, `m` for map, and so on. 

As such, many profiles for specific games can be [extended](https://github.com/Thertzlor/Revenant/wiki/Profile-Overview#inheritance-and-extension) from it with few alterations.

True, LGS already allows you to use a copy of an existing profile as a base for a new one but that copy is *static*.  
As Revenant imports the parent profile dynamically, it's also easy to propagate changes; I can change how a button works in the base profile and all child profiles inherit the change the next time they are loaded.  
Most of the below profiles inherit bindings from the default game profile.

### Far Cry 3
This is a minimal profile with only 5 lines of actual assignments, the rest is inherited from the default profile.  
There's nothing here that can't already be done in base LGS, it just shows how fast you can whip up a fully functional profile with Revenant's profile extension if the game doesn't deviate from the norm.

### *Doom (2016)* and *Dark Souls*
These are two examples of profiles that change up the default game profile for 

I'm not good at either of these games, but I've never understood why people were complaining about the PC controls for Dark Souls before I remembered those people probably aren't playing with a 20 button mouse.

But since in LGS mouse actions don't count as simple keystrokes you would already have to bust out the macro recorder for the "kick/alt attack" macro in the Dark Souls profile.

### Just Cause 2
With this profile we get into some of the more advanced techniques that let you set
#### Highlights and stuff you couldn't do with the GUI:
* [Key cycling](https://github.com/Thertzlor/Revenant/wiki/Cycle-Macro) in general, e.g. the dual wield on *g-shift + g1*.
* *g2* and *g4* both implement a simple double-tap toggle logic (for sprint and crouch respectively) using timed cycle buttons, that works like this (using the sprinting with *shift* as an example):  
`{type = "cycle", "/s", {"/s", type = "keydown"}, cancel = -200}`
  * A single normal button press works just like the regular key. Hold down to keep sprinting just like normal.
  * Double tapping the button within 200ms will send an additional keydown event for the shift key without releasing, acting as a sprint toggle.
    * Simply pressing the button again untoggles shift, as it's just the normal key which it includes key-up.
    * *Technically* this method sends a superflous event (shift-down, shift-up, then again shift down) but this particular game doesn't care about that.


### Shadow of Mordor

#### Highlights and stuff you couldn't do with the GUI:
* middle click is set to a lot of context sensitive functions.
  * Normally, it just triggers the regular mouse 3 event `/3`.
  * If the left mouse button is pressed, which draws the bow, middle click becomes `z` (shadow strike).
  * While `g1` is pressed, middle click becomes the spacebar. Why? Branding. Grab is on `g1` and space is `g2` which you can only press by releasing `g1`... but that would release the orc, so space "migrates" to `m3` which can be pressed at the same time.
* `g4` is a stealth toggle based on [hold time](https://github.com/Thertzlor/Revenant/wiki/Hold-Key-Macro).
  * Simply tapping the button toggles shift on and off.
  * Hold the button down (for more than 350ms) and shift will release when you release the button.
  * The mouse also [switches to mode 2](https://github.com/Thertzlor/Revenant/wiki/Mode-Change-Macro) when stealth is toggles. This is partially just because it felt neat to have a visual indicator of being in stealth on the mouse but it also changes some interactions below...
* `g5` is a run-up stealth kill/brutalize button. This works because stealth is very silly in this game. You can jump out in front of an orc without being in stealth at all and while he's still surprised to see you, you can still get a stealth kill on him by pressing shift for less than half a second plus left click.
  * Normally the timing window for this is a bit tricky but naturally a [sequence macro](https://github.com/Thertzlor/Revenant/wiki/Sequence-Macro) makes it 100% consistent.
  * The hold time decides the type of attack:
    * Tap `g5` for a stealth kill
    * Hold `g5` for a brutalize kill.
  * Now how does this interact with the `g4` stealth toggle? Well, if we're in mode 2 the shift key parts of the sequence are simply skipped, so stealth doesn't get toggled off.
* The sprint macro on `g2` also has a toggle functionality, but implemented very differently than in Just Cause 2. We can't use double tap because that results in a roll. The game makes enough use of space presses that setting space to a toggle by default is a bad idea. So once again we use the middle click.
  * While `g2` is held, `m3` will set a [flag](https://github.com/Thertzlor/Revenant/wiki/Flag-Macro) called `runner` for one second.
  * The key-up command on for space on `g2` is actually a separate macro that only runs when the `runner` flag is *not* set so `g2`+`m3` will result in space remaining pressed.
  * `g2` also sets the `runner` flag to false on key-up, which guarantees that the next press will deactivate the sprint toggle again.
  * And you can still use the *actual* space bar on your keyboard to trigger the parkour prompts without disabling the sprint toggle.

### Dwarf Fortress (Steam)
Even after the Steam release regrettably ditched the completely keyboard driven interface of the earlier versions (mouse control is great, but it should have been an addition not a partial replacement), Dwarf Fortress has an intense amount of keyboard shortcuts making this one of my most complex profiles so far, over 300 lines, complex key sequences, numerous multi-functional buttons.

#### Highlights and stuff you couldn't do with the GUI:
* Most of it, honestly.
* The `g4` button covers the entirety of the deeply nested buildings menu.  
After pressing it, the thumbpad button select menu items by position, and this process repeats for submenus.
  * For example `Workshops` is the first entry of the buildings menu and the Carpenter's Workshop is the sixth entry in the workshop menu, so we can select it with the [button sequence](https://github.com/Thertzlor/Revenant/wiki/Condition-Syntax#key-series) `g4-g1-g6` just like we would use the sequence `b-o-p` with the keyboard.
  * Additionally, if we're inside a submenu, the `g12` button, which usually escape, doesn't just close the menu, but goes back to the last one, like back to the workshop from the farming page, or back to the main building menu from the workshop page.
  * This also involves a lot of [button history manipulation](https://github.com/Thertzlor/Revenant/wiki/Alter-History-Macro)
* The Location recenter and DFHack bindings are also implemented with subselections.
* The `m3` and `m5` buttons inject an [Alter History Macro](https://github.com/Thertzlor/Revenant/wiki/Alter-History-Macro) that prevents these particular button from affecting key sequences and cycles (since they are often used in conjunction with other actions that we don't want to interrupt)
* This profile uses cycles that you can iterate through in both directions using G-shift.
* Some buttons open a menu with one press, then switch to switching through menu tabs on subsequent presses.
* The `g1` and `g9` bindings for giving and cancelling digging orders each check if the other was the last pressed button, and add or omit right clicks accordingly, to switch fluently between them.

## Other Apps

### Browser Profile
A profile covering pretty much all the usual navigation and tab management functions you find in a browser.
I use this as my daily driver for Vivaldi and it should work with just about any chromium based browser as well.
Overall, it doesn't have many super wild features.

#### Highlights and stuff you couldn't do with the GUI:
* Quick bookmark mode:
  * While `m3` is pressed each button on the thumbpad navigates to a user defined url.
  * Normally the sites open in a new tab, but pressing G-shift will open them in the current tab.

### Visual Studio Code
VSCode is a bit more complex than a browser, so the corresponding profile is more complex as well.  
The bindings are fairly agnostic, there's definitely extensions and programming styles that could fill another 20 buttons but I didn't want to include too much that is purely personal preference.

Revenant itself and everything in this repo was coded with the help of this very profile.
#### Highlights and stuff you couldn't do with the GUI:
* Context sensitivity: Several buttons (`m3`-`m5`) change functionality when the search button (`g4`) is held down, for quick switching between different search modes.
* Advanced refactoring selection on the `g3` button:
  * The first press opens the refactor menu with `ctrl+shift+r`.
  * subsequent presses cycle between refactor options.
  * a long press will execute the currently selected option.
* G-shift binding on `g1` which opens the command input on short press and the file picker on long press.
* ...And various multi key cycles.
