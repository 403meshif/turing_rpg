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

const DEVMODE : boolean := true
const SCREEN_X : int := 640
const SCREEN_Y : int := 640
const SPRITESHEET_SIZE : int := 640
const SPRITE_SIZE : int := 64
const STEP_SIZE : int := 64
const MAP_LEN : int := 228
const MAP_EXITS : int := 12
const MAP_HEADER_LEN := 2 + MAP_EXITS * 2
const CASTLE_MAP : int := 1
const FIRST_TOWN_MAP : int := 31
const LAST_TOWN_MAP : int := 57
const FLOWER_SPRITE_1 : int := 18
const PLAYER_SPRITE : int := 99

var tmpCount : int := 0
var spriteFile : int
var mapFile : int
var mapType : int
var previousMap, currentMap : int
var playerX, playerY : int := 320
var playerTile : int
var inputKey : string (1)
var mapData : string
var sprite : array 0 .. 99 of int
var mapExit : array 1 .. MAP_EXITS of int
var mouseX, mouseY, mouseBtn, mouseColor : int
var playerFlowers : int := 0

% Open required files
spriteFile := Pic.FileNew ("spritesheet.bmp")
open : mapFile, "map", get, seek

% Set up screen for graphics and dev options
if DEVMODE then
    View.Set ("graphics:640;640,position:center;truemiddle")
else
    View.Set ("graphics:640;640,position:center;truemiddle,nobuttonbar,offscreenonly")
end if

% Slice spritesheet and load sprites into memory
Pic.Draw (spriteFile, 0, 0, picCopy)
for decreasing y : SPRITESHEET_SIZE - SPRITE_SIZE .. 0 by SPRITE_SIZE
    for x : 0 .. SPRITESHEET_SIZE - SPRITE_SIZE by SPRITE_SIZE
	sprite (tmpCount) := Pic.New (x, y, x + SPRITE_SIZE - 1, y + SPRITE_SIZE - 1)
	tmpCount += 1
    end for
end for
Pic.Free (spriteFile)
tmpCount := 0

% Scan map exits and draw map from file
procedure DrawMap (mapIndex : int)
    seek : mapFile, MAP_LEN * mapIndex
    get : mapFile, mapData : 2
    mapType := strint (mapData)
    for i : 1 .. MAP_EXITS
	get : mapFile, mapData : 2
	mapExit (i) := strint (mapData)
    end for
    for decreasing y : SCREEN_Y - SPRITE_SIZE .. 0 by SPRITE_SIZE
	for x : 0 .. SCREEN_X - SPRITE_SIZE by SPRITE_SIZE
	    get : mapFile, mapData : 2
	    Pic.Draw (sprite (strint (mapData)), x, y, picCopy)
	    if strint (mapData) = 1 and Rand.Int (1, 100) = 1 then
		Pic.Draw (sprite (FLOWER_SPRITE_1), x, y, picMerge)
	    end if
	end for
    end for
    View.Update
end DrawMap

% Redraw map where player was then draw player in new location
procedure MovePlayer (x, y : int)
    if View.WhatDotColor (playerX + 22, playerY + 20) = 43 then
	playerFlowers += 1
    end if
    playerTile := round (playerX / SPRITE_SIZE * 2 + (SCREEN_Y - playerY - SPRITE_SIZE) / SPRITE_SIZE * 10 * 2)
    seek : mapFile, MAP_LEN * currentMap + MAP_HEADER_LEN + playerTile
    get : mapFile, mapData : 2
    Pic.Draw (sprite (strint (mapData)), playerX, playerY, picCopy)
    if x = 1 and playerX + SPRITE_SIZE < maxx then
	playerX += STEP_SIZE
    elsif x = -1 and playerX > 0 then
	playerX -= STEP_SIZE
    elsif y = 1 and playerY + SPRITE_SIZE < maxy then
	playerY += STEP_SIZE
    elsif y = -1 and playerY > 0 then
	playerY -= STEP_SIZE
    end if
    Pic.Draw (sprite (PLAYER_SPRITE), playerX, playerY, picMerge)
end MovePlayer

% Draw inital map and player
currentMap := CASTLE_MAP
DrawMap (currentMap)
MovePlayer (0, 0)

% Main game loop
loop
    if hasch then
	getch (inputKey)
	exit when inputKey = KEY_ESC
	case inputKey of
	    label KEY_LEFT_ARROW :
		MovePlayer (-1, 0)
	    label KEY_RIGHT_ARROW :
		MovePlayer (1, 0)
	    label KEY_UP_ARROW :
		MovePlayer (0, 1)
	    label KEY_DOWN_ARROW :
		MovePlayer (0, -1)
	    label :
	end case
    end if
    if DEVMODE then
	mousewhere (mouseX, mouseY, mouseBtn)
	mouseColor := View.WhatDotColor (mouseX, mouseY)
	locate (1, maxcol - 11)
	color (mouseColor)
	put intstr (mouseX) + "," + intstr (mouseY) + "," + intstr (mouseColor) : 11 ..
	color (black)
	locate (1, 1)
	put intstr (playerX) + "," + intstr (playerY) : 7 ..
	locate (2, 1)
	put realstr (playerX / SPRITE_SIZE, 0) + "," + realstr ((SCREEN_Y - playerY - 64) / SPRITE_SIZE, 0) : 7 ..
	locate (3, 1)
	playerTile := round (playerX / SPRITE_SIZE * 2 + (SCREEN_Y - playerY - 64) / SPRITE_SIZE * 10 * 2)
	put intstr (playerTile) : 7 ..
	locate (4, 1)
	put intstr (MAP_LEN * currentMap + MAP_HEADER_LEN + playerTile) : 7 ..
	seek : mapFile, MAP_LEN * currentMap + MAP_HEADER_LEN + playerTile
	get : mapFile, mapData : 2
	Pic.Draw (sprite (strint (mapData)), 0, 0, picCopy)
	Draw.Line (0, 64, 64, 64, black)
	Draw.Line (64, 0, 64, 64, black)
	locate (5, 1)
	put intstr (playerFlowers) : 2 ..
    end if
    View.Update
end loop
