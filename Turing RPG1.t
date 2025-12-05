View.Set ("graphics:640;640,nobuttonbar,offscreenonly")

const UP : int := 200
const DOWN : int := 208
const LEFT : int := 203
const RIGHT : int := 205
const ESC : int := 27
const MAPLEN : int := 226

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
	end for
    end for
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
cur := Rand.Int (1, 27)
drawMap (cur)
locate (1, 1)
put "Arrows to move. ESC to quit" ..
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
	    next := Rand.Int (1, 27)
	    scanMap (next)
	    exit when exits (9) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = UP and exits (1) = 1 then
	loop
	    next := Rand.Int (1, 27)
	    scanMap (next)
	    exit when exits (10) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = UP and exits (2) = 1 then
	loop
	    next := Rand.Int (1, 27)
	    scanMap (next)
	    exit when exits (11) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = DOWN and exits (9) = 1 then
	loop
	    next := Rand.Int (1, 27)
	    scanMap (next)
	    exit when exits (0) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = DOWN and exits (10) = 1 then
	loop
	    next := Rand.Int (1, 27)
	    scanMap (next)
	    exit when exits (1) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = DOWN and exits (11) = 1 then
	loop
	    next := Rand.Int (1, 27)
	    scanMap (next)
	    exit when exits (2) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = LEFT and exits (3) = 1 then
	loop
	    next := Rand.Int (1, 27)
	    scanMap (next)
	    exit when exits (4) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = LEFT and exits (5) = 1 then
	loop
	    next := Rand.Int (1, 27)
	    scanMap (next)
	    exit when exits (6) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = LEFT and exits (7) = 1 then
	loop
	    next := Rand.Int (1, 27)
	    scanMap (next)
	    exit when exits (8) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = RIGHT and exits (4) = 1 then
	loop
	    next := Rand.Int (1, 27)
	    scanMap (next)
	    exit when exits (3) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = RIGHT and exits (6) = 1 then
	loop
	    next := Rand.Int (1, 27)
	    scanMap (next)
	    exit when exits (5) = 1
	end loop
	cycleMaps ()
    elsif ord (ch) = RIGHT and exits (8) = 1 then
	loop
	    next := Rand.Int (1, 27)
	    scanMap (next)
	    exit when exits (7) = 1
	end loop
	cycleMaps ()
    end if
end loop
