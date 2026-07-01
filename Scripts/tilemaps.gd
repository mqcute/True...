extends Node

@onready var background: TileMapLayer = $Background
@onready var midground: TileMapLayer = $Midground

@export var tileset : TileSet
@export var lgtileset : TileSet

func _ready() -> void:
	SignalBus.lg_mode.connect(_change_tileset)


func _change_tileset(lg : bool) -> void:
	if lg:
		background.tile_set = lgtileset
		midground.tile_set = lgtileset
	else:
		background.tile_set = tileset
		midground.tile_set = tileset
