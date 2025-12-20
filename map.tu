procedure ScanMap (map : int)
    seek : mapFile, MAP_LEN * map
    get : mapFile, mapData : 2
    mapType := strint (mapData)
    for i : 1 .. MAP_EXITS
	get : mapFile, mapData : 2
	if mapData = "01" then
	    mapExit (i) := true
	else
	    mapExit (i) := false
	end if
    end for
    return
end ScanMap

procedure DrawMap (map : int)
    ScanMap (map)
    for decreasing y : SCREEN_Y - SPRITE_SIZE .. 0 by SPRITE_SIZE
	for x : 0 .. SCREEN_X - SPRITE_SIZE by SPRITE_SIZE
	    get : mapFile, mapData : 2
	    tile (tempCount).sprite := strint (mapData)
	    Pic.Draw (sprite (tile (tempCount).sprite), x, y, picCopy)
	    case tile(tempCount).sprite of
		label 19, 20, 21, 22, 23, 24, 25, 26 :
		    tile(tempCount).walkable := false
		label:
		    tile(tempCount).walkable := true
	    end case
	    if tile (tempCount).sprite = 1 and Rand.Int (1, 100) = 1 then
		tile (tempCount).collectible := FLOWER_SPRITE
		Pic.Draw (sprite (FLOWER_SPRITE), x, y, picMerge)
	    else
		tile (tempCount).collectible := 0
	    end if
	    tempCount += 1
	end for
    end for
    tempCount := 0
    View.Update
    return
end DrawMap

procedure CycleMap ()
    return
end CycleMap
