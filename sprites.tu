procedure LoadSprites ()
    spriteFile := Pic.FileNew ("spritesheet.bmp")
    Pic.Draw (spriteFile, 0, 0, picCopy)
    View.Update
    for decreasing y : SPRITESHEET_SIZE - SPRITE_SIZE .. 0 by SPRITE_SIZE
	for x : 0 .. SPRITESHEET_SIZE - SPRITE_SIZE by SPRITE_SIZE
	    sprite (tempCount) := Pic.New (x, y, x + SPRITE_SIZE - 1, y + SPRITE_SIZE - 1)
	    tempCount += 1
	end for
    end for
    Pic.Free (spriteFile)
    tempCount := 0
    return
end LoadSprites
