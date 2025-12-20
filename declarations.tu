type tileType :
    record
	sprite : int
	collectible : int
	monster : int
	walkable : boolean
    end record

type playerType :
    record
	x : int
	y : int
	tile : int
	flowers : int
	health : int
    end record

type mouseType :
    record
	x : int
	y : int
	button : int
	color : int
    end record

const DEBUG : boolean := true
const SCREEN_X : int := 640
const SCREEN_Y : int := 640
const SPRITE_SIZE : int := 64
const MAX_SPRITE : int := 99
const MAP_LEN : int := 228
const MAP_EXITS : int := 12
const MAP_HEADER_LEN : int := 2 + MAP_EXITS * 2
const SPRITESHEET_SIZE : int := 640
const STEP_SIZE : int := 64
const FLOWER_SPRITE : int := 18
const PLAYER_SPRITE : int := 99

var spriteFile : int
var tempCount : int
var mapFile : int
var previousMap : int
var currentMap : int
var nextMap : int
var inputKey : string (1)
var mapData : string (2)
var mapType : int

var player : playerType
var mouse : mouseType

var sprite : array 0 .. MAX_SPRITE of int
var mapExit : array 1 .. 12 of boolean
var tile : array 0 .. 99 of tileType

tempCount := 0
currentMap := 1
player.x := 4 * STEP_SIZE
player.y := 5 * STEP_SIZE
player.flowers := 0
