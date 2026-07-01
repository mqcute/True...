extends Sprite2D

const LG_TRUE = preload("res://Assets/LGTrue.png")
const TRUE = preload("res://Assets/true.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.lg_mode.connect(_change_sprite)


func _change_sprite(lg : bool) -> void:
	if lg:
		texture = LG_TRUE
		scale = Vector2(1.85, 0.617)
	else:
		texture = TRUE
		scale = Vector2(0.048, 0.016)
