View.Set ("graphics:640;640,nobuttonbar,offscreenonly")

var map, sheet, n, x, y : int := 0
var pic : array 0 .. 99 of int
var mapData : string

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

procedure drawMap (mapTile : int)
    seek : map, mapTile * 202
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

for i : 0 .. 27
    drawMap (i)
    delay (1500)
end for
