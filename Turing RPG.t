%  Turing RPG
%  By: meshif
%  v00.00.01 - November 24, 2025 - new project
%  v00.00.02 - December 5, 2025 - added arrow navigation
%  v00.00.03 - December 5, 2025 - added new tiles and flower randomgen
%  v00.00.04 - December 9, 2025 - added starting castle and new castle tiles
%                               - added tile constants
%                               - renumbered town tiles

View.Set ("graphics:640;640,nobuttonbar,offscreenonly")

const UP : int := 200
const DOWN : int := 208
const LEFT : int := 203
const RIGHT : int := 205
const ESC : int := 27
const MAPLEN : int := 226
const CASTLE_TILE : int := 1
const FIRST_TOWN_TILE : int := 31
const LAST_TOWN_TILE : int := 57

var map, sheet, cur, prev, next, n, x, y : int := 0
var mapData : string
var ch : string (1)
var pic : array 0 .. 99 of int
var exits : array 0 .. 11 of int

%  Open tilesheet and load tiles into memory
open : map, "map", get, seek
sheet := Pic.FileNew ("tilesheet.bmp")
Pic.Draw (sheet, 0, 0, picCopy)
for i : 0 .. 9
    y := maxy - i * 64
    for j : 0 .. 9
	x := j * 64
	pic (n) := Pic.New (x, y - 64, x + 63, y)
	n += 1
    end for
end for
Pic.Free (sheet)

%  Draw map pattern mapTile from map tile
procedure drawMap (mapTile : int)
    seek : map, mapTile * MAPLEN
    for i : 0 .. 11
	get : map, mapData : 2
	exits (i) := strint (mapData)
    end for
    for i : 1 .. 10
	y := maxy - i * 64
	for j : 0 .. 9
	    x := j * 64
	    get : map, mapData : 2
	    n := strint (mapData)
	    Pic.Draw (pic (n), x, y, picCopy)
	    case n of
		label 1, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 :
		    if Rand.Int (1, 20) = 1 then
			Pic.Draw (pic (18), x, y, picMerge)
		    end if
		label :
	    end case
	end for
    end for
    %    Pic.Draw(pic(99),320,320,picMerge)
    View.Update
end drawMap

%  Check map exits
procedure scanMap (mapTile : int)
    seek : map, mapTile * MAPLEN
    for i : 0 .. 11
	get : map, mapData : 2
	exits (i) := strint (mapData)
    end for
end scanMap

%  Cycle map on arrow keys
procedure cycleMaps
    prev := cur
    cur := next
    drawMap (cur)
end cycleMaps

%  Draw inital map tile
cur := CASTLE_TILE
scanMap (cur)
drawMap (cur)
locate (1, 1)
put "Arrows to move. H to return to castle. ESC to quit" ..
View.Update

%  Main game loop
loop
    loop
	exit when hasch
    end loop
    getch (ch)
    exit when ord (ch) = ESC
    if ord (ch) = UP and exits (0) = 1 then
	loop
	    next := Rand.Int (FIRST_TOWN_TILE, LAST_TOWN_TILE)
	    scanMap (next)
	    exit when exits (9) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = UP and exits (1) = 1 then
	loop
	    next := Rand.Int (FIRST_TOWN_TILE, LAST_TOWN_TILE)
	    scanMap (next)
	    exit when exits (10) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = UP and exits (2) = 1 then
	loop
	    next := Rand.Int (FIRST_TOWN_TILE, LAST_TOWN_TILE)
	    scanMap (next)
	    exit when exits (11) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = DOWN and exits (9) = 1 then
	loop
	    next := Rand.Int (FIRST_TOWN_TILE, LAST_TOWN_TILE)
	    scanMap (next)
	    exit when exits (0) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = DOWN and exits (10) = 1 then
	loop
	    next := Rand.Int (FIRST_TOWN_TILE, LAST_TOWN_TILE)
	    scanMap (next)
	    exit when exits (1) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = DOWN and exits (11) = 1 then
	loop
	    next := Rand.Int (FIRST_TOWN_TILE, LAST_TOWN_TILE)
	    scanMap (next)
	    exit when exits (2) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = LEFT and exits (3) = 1 then
	loop
	    next := Rand.Int (FIRST_TOWN_TILE, LAST_TOWN_TILE)
	    scanMap (next)
	    exit when exits (4) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = LEFT and exits (5) = 1 then
	loop
	    next := Rand.Int (FIRST_TOWN_TILE, LAST_TOWN_TILE)
	    scanMap (next)
	    exit when exits (6) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = LEFT and exits (7) = 1 then
	loop
	    next := Rand.Int (FIRST_TOWN_TILE, LAST_TOWN_TILE)
	    scanMap (next)
	    exit when exits (8) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = RIGHT and exits (4) = 1 then
	loop
	    next := Rand.Int (FIRST_TOWN_TILE, LAST_TOWN_TILE)
	    scanMap (next)
	    exit when exits (3) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = RIGHT and exits (6) = 1 then
	loop
	    next := Rand.Int (FIRST_TOWN_TILE, LAST_TOWN_TILE)
	    scanMap (next)
	    exit when exits (5) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = RIGHT and exits (8) = 1 then
	loop
	    next := Rand.Int (FIRST_TOWN_TILE, LAST_TOWN_TILE)
	    scanMap (next)
	    exit when exits (7) = 1
	end loop
	cycleMaps ()
    elsif ch = "h" or ch = "H" then
	next := CASTLE_TILE
	scanMap (next)
	cycleMaps ()
    end if
end loop
