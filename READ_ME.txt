Team: The Boomers & The Zoomer
Project Title: Down Under
Developers: Kristopher Randle & Abdul-Roqeeb Oloruntele

Version: 0.1.2
Date: 03-03-2021

// --------------- VERSION NOTES --------------- //

Player spawns in a basic room with collidable objects. A worm enemy has been added that bounces off walls indefinitely. It's animation changes
based on the direction it is heading. Numerous textures have been added in this version for modelling the tilemap (mainly for the cave).

The scale of the tile grid was set to 16x16, and all textures have been resampled to fit into pixel counts that are multiples of 16. (16x16, 32x32, 32x48 etc)

The player now has a camera2D that zooms in on their location and follows them.

The players jump can now also be interrupted by releasing the jump key early. Enemys have been optimised by preventing their scripts from running
if they are out of the players camera view.

// --------------- NEW SCENES --------------- //

Worm.tcsn

// --------------- EDITED SCENES--------------- //

LevelOne.tcsn
Player.tcsn

// --------------- NEW SCRIPTS --------------- //

Worm.tcsn

// --------------- EDITED SCRIPTS --------------- //

Actor.gd
Player.gd