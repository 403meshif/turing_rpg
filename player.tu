body procedure DrawPlayer
    player.tile := (player.x + 10 * (SCREEN_Y - player.y)) div SPRITE_SIZE - 10
    if tile (player.tile).collectible > 0 then
	tile (player.tile).collectible := 0
	Pic.Draw (sprite (tile (player.tile).sprite), player.x, player.y, picCopy)
	player.flowers += 1
    end if
    Pic.Draw (sprite (PLAYER_SPRITE), player.x, player.y, picMerge)
    if DEBUG then
	locate (1, 1)
	put intstr (player.x) + "," + intstr (player.y) : 7 ..
	locate (2, 1)
	put intstr (player.tile) : 7 ..
	locate (3, 1)
	put intstr (tile (player.tile).sprite) : 7 ..
	locate (4, 1)
	put intstr (tile (player.tile).collectible) : 7 ..
	locate (5, 1)
	put intstr ((maxx - SPRITE_SIZE) - player.x) + "," + intstr ((maxy - SPRITE_SIZE) - player.y) : 7 ..
	locate (6, 1)
	put intstr (maxy - SPRITE_SIZE) : 7 ..
	locate (7, 1)
	put tile (player.tile).isExit : 7 ..
    end if
    locate (maxrow, 1)
    put "Flowers: " + intstr (player.flowers) : 9 ..
    View.Update
    return
end DrawPlayer

body procedure MovePlayer
    Pic.Draw (sprite (tile (player.tile).sprite), player.x, player.y, picCopy)
    if xDir = 1 and player.x < maxx - SPRITE_SIZE and tile (player.tile + 1).walkable then
	player.x += STEP_SIZE
    elsif xDir = 1 and player.x = maxx - SPRITE_SIZE + 1 and tile (player.tile).isExit then
	CycleMap (player.tile)
    elsif xDir = -1 and player.x > 0 and tile (player.tile - 1).walkable then
	player.x -= STEP_SIZE
    elsif xDir = -1 and player.x = 0 and tile (player.tile).isExit then
	CycleMap (player.tile)
    elsif yDir = 1 and player.y < maxy - SPRITE_SIZE and tile (player.tile - 10).walkable then
	player.y += STEP_SIZE
    elsif yDir = 1 and player.y = maxy - SPRITE_SIZE + 1 and tile (player.tile).isExit then
	CycleMap (player.tile)
    elsif yDir = -1 and player.y > 0 and tile (player.tile + 10).walkable then
	player.y -= STEP_SIZE
    elsif yDir = -1 and player.y = 0 and tile (player.tile).isExit then
	CycleMap (player.tile)
    end if
    DrawPlayer ()
    View.Update
    return
end MovePlayer
