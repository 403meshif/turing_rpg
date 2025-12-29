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
    for decreasing y : SCREEN_Y - SPRITE_SIZE .. 0 by SPRITE_SIZE
	for x : 0 .. SCREEN_X - SPRITE_SIZE by SPRITE_SIZE
	    get : mapFile, mapData : 2
	    tile (tempCount).sprite := strint (mapData)
	    tile (tempCount).isExit := false
	    Pic.Draw (sprite (tile (tempCount).sprite), x, y, picCopy)
	    case tile (tempCount).sprite of
		label 19, 20, 21, 22, 23, 24, 25, 26 :
		    tile (tempCount).walkable := false
		label :
		    tile (tempCount).walkable := true
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
    if mapExit (1) then
	tile (01).isExit := true
	tile (02).isExit := true
    end if
    if mapExit (2) then
	tile (04).isExit := true
	tile (05).isExit := true
    end if
    if mapExit (3) then
	tile (07).isExit := true
	tile (08).isExit := true
    end if
    if mapExit (4) then
	tile (10).isExit := true
	tile (20).isExit := true
    end if
    if mapExit (5) then
	tile (19).isExit := true
	tile (29).isExit := true
    end if
    if mapExit (6) then
	tile (40).isExit := true
	tile (50).isExit := true
    end if
    if mapExit (7) then
	tile (49).isExit := true
	tile (59).isExit := true
    end if
    if mapExit (8) then
	tile (70).isExit := true
	tile (80).isExit := true
    end if
    if mapExit (9) then
	tile (79).isExit := true
	tile (89).isExit := true
    end if
    if mapExit (10) then
	tile (91).isExit := true
	tile (92).isExit := true
    end if
    if mapExit (11) then
	tile (94).isExit := true
	tile (95).isExit := true
    end if
    if mapExit (12) then
	tile (97).isExit := true
	tile (98).isExit := true
    end if
    View.Update
    return
end DrawMap

procedure CycleMap (exitPoint : int)
    case exitPoint of
	label 01, 02 :
	    mapEntry := 10
	    player.y -= 9 * STEP_SIZE
	label 04, 05 :
	    mapEntry := 11
	    player.y -= 9 * STEP_SIZE
	label 07, 08 :
	    mapEntry := 12
	    player.y -= 9 * STEP_SIZE
	label 10, 20 :
	    mapEntry := 5
	    player.x += 9 * STEP_SIZE
	label 19, 29 :
	    mapEntry := 4
	    player.x -= 9 * STEP_SIZE
	label 40, 50 :
	    mapEntry := 7
	    player.x += 9 * STEP_SIZE
	label 49, 59 :
	    mapEntry := 6
	    player.x -= 9 * STEP_SIZE
	label 70, 80 :
	    mapEntry := 9
	    player.x += 9 * STEP_SIZE
	label 79, 89 :
	    mapEntry := 8
	    player.x -= 9 * STEP_SIZE
	label 91, 92 :
	    mapEntry := 1
	    player.y += 9 * STEP_SIZE
	label 94, 95 :
	    mapEntry := 2
	    player.y += 9 * STEP_SIZE
	label 97, 98 :
	    mapEntry := 3
	    player.y += 9 * STEP_SIZE
    end case
    loop
	nextMap := Rand.Int (31, 57)
	ScanMap (nextMap)
	exit when mapExit (mapEntry)
    end loop
    previousMap := currentMap
    currentMap := nextMap
    DrawMap (currentMap)
    DrawPlayer ()
    return
end CycleMap
