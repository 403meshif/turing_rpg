% Turing RPG
% By: meshif
% v00.00.01 - November 24, 2025 - new project
% v00.00.02 - December 05, 2025 - added arrow navigation
% v00.00.03 - December 05, 2025 - added new tiles and flower randomgen
% v00.00.04 - December 09, 2025 - added starting castle and new castle tiles
%                               - added tile constants
%                               - renumbered town tiles
%                               - broke github and had to recreate the repo
% v00.00.05 - December 14, 2025 - cleaned up entire codebase
%                               - added devmode toggle to show more info
%                               - added map type flag in map file
%                               - redrew tilesheet.bmp to fix transparency and
%                                 renamed to spritesheet.bmp
%                               - got movement and redrawing working but need
%                                 to clean up that bit
% v00.00.06 - December 15, 2025 - made flowers collectable
%                               - reorganized things in movement/mapgen
% v00.00.10 - December 19, 2025 - cleaned up code more
%                               - split code into files depending on function
%                               - added mouse support
%                               - added non-walkable tiles

include "declarations.tu"
include "sprites.tu"
include "map.tu"
include "player.tu"

if DEBUG then
    View.Set ("graphics:640;640,position:center;truemiddle")
else
    View.Set ("graphics:640;640,position:center;truemiddle,nobuttonbar,offscreenonly")
end if

LoadSprites ()

open : mapFile, "map", get, seek

DrawMap (currentMap)
DrawPlayer ()

loop
    if hasch then
	getch (inputKey)
	exit when inputKey = KEY_ESC
	case inputKey of
	    label KEY_RIGHT_ARROW :
		MovePlayer (1, 0)
	    label KEY_LEFT_ARROW :
		MovePlayer (-1, 0)
	    label KEY_UP_ARROW :
		MovePlayer (0, 1)
	    label KEY_DOWN_ARROW :
		MovePlayer (0, -1)
	    label :
	end case
    end if
    mousewhere (mouse.x, mouse.y, mouse.button)
    mouse.color := View.WhatDotColor (mouse.x, mouse.y)
    if DEBUG then
	locate (1, maxcol - 11)
	put intstr (mouse.x) + "," + intstr (mouse.y) + "," + intstr (mouse.button)
	locate (2, maxcol - 11)
	color (mouse.color)
	put mouse.color
	color (black)
    end if
end loop
