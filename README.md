# Revenant G600 Example Profiles
This is a collection of Revenant profiles for the Logitech G600 designed to give an overview of what sort of functionality is possible from basic bindings to advanced logic and integration of external tools.

For more information see the main **Revenant** repository: https://github.com/Thertzlor/Revenant

Included here is a folder of *demo* profiles which showcase of Revenant capabilities without focusing on direct usefulness, as well as a *practical* folder which contains Revenant profiles for real games and applications that I have actually used day-to-day.

## How to use
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
## Demos

### Keyboard key detection via Autothotkey
A demonstration of how we can use the capability to dynamically load .lua files to react to events that LGS cannot detect normally.
* This profile requires running a separate .ahk script (not an actual keylogger, don't worry) which logs the currently pressed keys into a lua table.
* The script can then read that table on demand and use it for [macro conditions]().

It might seem stupid that the proposed solution to extend LGS functionality is simply using a tool (AHK) that could already press the keys itself but in my opinion there's value in letting one side only collect generic information and not having application profiles for lots of apps in two places.  
Obviusly the techniques showcased in this profile can be extended to any program that could log useful information to a .lua file.

### Multi-tap thumbpad
Turn the thumbpad of your G600 into an Multi-Tap keyboard as found on old mobile phones, implementing the E.161 standard.   
This profile offers three different implementations of the keypad logic, each one highlighting a different aspect of Revenant's macro system.

* [Multiclick Macros](https://github.com/Thertzlor/Revenant/wiki/Multiclick-Macro) with cyclical behavior and [key buffers](https://github.com/Thertzlor/Revenant/wiki/Key-Buffer-Macro).
* [Sequence Macros](https://github.com/Thertzlor/Revenant/wiki/Sequence-Macro) with nested cycles, [key-release triggers](https://github.com/Thertzlor/Revenant/wiki/Macro-Overview#direction) and timeouts.
* [Manual Cycles](https://github.com/Thertzlor/Revenant/wiki/Cycle-Macro), modifying behavior in response to [previously pressed buttons](https://github.com/Thertzlor/Revenant/wiki/Condition-Syntax#condition-types) and managing state via [flags](https://github.com/Thertzlor/Revenant/wiki/Flag-Macro).

This profile also makes heavy use of templating via [Instance Macros](https://github.com/Thertzlor/Revenant/wiki/Instance-Macro) for bindings with similar functionality.

### Combination lock
A profile that demonstrates [key sequence conditions](https://github.com/Thertzlor/Revenant/wiki/Condition-Syntax#key-series) and [process functions](https://github.com/Thertzlor/Revenant/wiki/Macro-Overview#process) to implement a 4-number "lock" on your mouse.
The macros on the buttons G10 and and G11 will only trigger if you pressed 4 other buttons on the thumbpad in the right order with less than a 2 second pause in between.

There are two locks implemented:
* The lock on G10 is static, you can simply view the combination in the profile file.
* The lock on G11 will generate a random combination each time you activate the profile (You can cheat by viewing the current generated combination in the log)

### Cheese Board
So... mice like cheese, so turn the thumbpad of your G600 mouse into a cheese board, each key writing out the name of a kind of cheese. The kind of cheese on each key will change every 2-4 seconds, cycling between 3 values (please don't put real cheese on your mouse).  

* This profile utilizes a global timer, implemented as a [sequence macro](https://github.com/Thertzlor/Revenant/wiki/Sequence-Macro) that starts looping the moment the profile is loaded using the [start](https://github.com/Thertzlor/Revenant/wiki/Profile-Overview#start-and-exit-bindings) binding.
* The functionality of the key is bound to the currently active subsequence of the main timing sequence, demonstrating how profiles can store and manage state using only macros.

I was mostly using cheese names that I am personally aware of, so apologies that the selection might have ended up a bit eurocentric (in my defence, I was also trying to avoid word with nonstandard letters and accents for the sake of compatibility).


## Practical