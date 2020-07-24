# BubNext
Port of Bubble Bobble for the Spectrum Next

Bubble Bobble for the Spectrum Next is a virtually arcade perfect port of the original arcade game with additional high score saving.

In order to run it requires the original arcade roms which are not supplied with this package - please don't ask me for these you must obtain them yourself.

The game requires patching to run. To do this you must take the following steps.

Place the unzipped ROM files in the same directory as the BUBNEXT.nex and BBNextPatch.exe

Run BBNextPatch by entering bbnextpatch <filename to patch> at the command line.  eg, to patch the default .nex in this archive type 'bbnextpatch bubnext.nex'

The process should take place automatically and produce an output .nex file prefixed with 'p_'.  This is now a standalone .nex file that can be copied to the Next (and renamed if wished).


Game Keys
-------------------
The default controls are keyboard these are:

			P1			P2
	Left		Z			N
	Right		X			M
	Fire		A			L
	Jump		Q			P

Other keys are
4 - Coin 1
5 - Coin 2
1 - 1 Player Start
2 - 2 Player Start

The controls user definable, to access the controls menu press 8 while in attract mode and follow the on screen instructions to select input method or redefine keys.  Press 0 to exit the menu.

There is a further options menu available by pressing 9 while in attract mode.  This contains the following options.
Difficulty		Normal, Easy, Hard, Very Hard
Bonus			'30K 100K 400K', '20K 80K 300K','40K 200K 500K','50K 250K 500K'
Number of Lives		3, 5, 1, 2
Refresh Rate		50hz (Spectrum Default), 60hz (Arcade Default)
Scanlines		None, 25%, 50%, 75%

Press 0 to exit the options screen.

Note:
After each hame the options re-enable and high score save take place when the Flashing Logo screen appears.  Sometimes the game will go straight into a demo level after the Game Over sequence so to ensure the high score saves correctly wait until the flashing logo appears again before resetting or powering off the Next.

The project includes joaoljr's PS4 Z80 implementation - see here https://forum.arcadeotaku.com/viewtopic.php?f=26&t=5154  
I did try to find his contact details to check if this is ok but I couldn't find any. Am hoping that as this is free software he won't mind.

The music and SFX are made using Arkos Tracker II which is an excellent piece of software and allowed a non-musician such as me to make some usable tunes (expecially appreciated the import MIDI option!).  The music and SFX could be improved and if anyone wishes to do so they are welcome.

Thanks to everyone on the SpectrumNext Discord channel for their help



BUILDING FROM SOURCE
-------------------
The source is designed to built using Visual Studio Code and SJASMPLUS.  It should build as is.
Optional Defines are:
DEVBUILD  -  This should be left commented out (or set to 0) as it won't compile without certain binaries which are not included
DEFINE NEED_CODE_FOR_SUPER_BB - Set to 1 to disable Super Bubble Bobble until the appropriate code is entered on the Title Screen


CHANGELOG
----------

v1.2
=========
Highscore at top of screen now updates to reflect loaded high score

v1.1
=========
Code input on title screen added (Super BB, POWER UP!!! and Original Game...)

V1.0 - Initial release
======================
Added Highscore saving

Fixed bug where water flow routine could overwrite game memory

Beta 6
==========
Added secret rooms

Added joaoljr's PS4 Z80 implementation - see here https://forum.arcadeotaku.com/viewtopic.php?f=26&t=5154 . I did try to find his contact details to check if this is ok but I couldn't find any. Am hoping that as this is free software he won't mind.

Added all music tracks (at least my passable versions)

Added most SFX as placeholders. There are 3 SFX in the arcade ROM that I haven't worked out what they are for but they must be infrequent events.

Move interrupt from Vblank to Scanline to increase available screen drawing time

Fix various memory leaks

Beta 5
===============
Reworked the EXTEND screen to use new Layer 2 resolutions. This means the static background is now layer 2 and the large bubbles are tilemap which eliminates the slowdown.

Optimised the sprite routines - they are now DMA based so there shouldn't be any more slowdowns.

Added all the end sequences - not that anyone is likely to see them. I am considering putting a level select option in, but will that ruin the replay factor if you don't have to work to see a new level?

Changed to to Arkos Tracker 2 for music and sound using the AKG format. The sound framework is complete and I have put in some placeholder music and sound for testing but I need better ones/a complete set.

Added a scanlines option in the menu

Beta 4
=================
Removed force 60hz mode - it will just use whatever the Next is currently set to

Controls Options Screen changed to key 8 to stop accidentally going back into when using 0 to exit
Other Options Screen added - press 9 to enter - Can change the refresh rate from here too.

Note - after playing the options only get reactivated when the main title screen is displayed, ie with the Bubble Bobble main logo, not as soon as game is over.

Fixed a bug where the end of the Vs screen in one player mode would show random sprites instead of just leaving their score blank

Fixed large enemies that come down holding hostages the were corrupted

NMI disabled - Thanks Ped7g


Beta 3
====================
Input selection screen added - Press 0 while in Attract Mode.
Supported modes are:
Redefinable Keybaord
Joystick Port A - 1 Button (up is jump)
Joystick Port A - 2 Button
Joystick Port B - 1 Button (up is jump)
Joystick Port B - 2 Button
MD Pad Port A
MD Pad Port B

Changing to either joystick or MD pad will automatically change the setting under Peripheral #06 to match.

Added music

Fixez
VS screen now works
Water flood now works
Scroll between levels is improved
and loads of other little fixes

Changed file format from .TAP to .NEX


Beta 2
=====================
Added enemy firing routines

Added EXTEND routines (this runs a bit slow as there are lots of Layer 2 writes - will look to optimise once everything else is done)
Reduced memory footprint so now runs on a 1Mb Next

plus lots of little fixes

Known issues so far
Flood routine not implemented - happens when you collect a blue cross
Eventual crash if left running through attract mode for long enough - there will be a memory write that hasn't been remapped yet - hard to find until I am able to run under emulation.

Beta 1
=====================
First public beta