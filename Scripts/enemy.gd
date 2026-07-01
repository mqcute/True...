extends Node2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var sprite_2d: Sprite2D = $Sprite2D

const TRUE = preload("res://Assets/true.png")
const LG_TRUE = preload("res://Assets/LGTrue.png")

@export_range(-120, 120) var Speed : float
var direction = 1
var is_lg := false

func _ready() -> void:
	SignalBus.lg_mode.connect(_change_sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		direction *= -1
		ray_cast_2d.rotation_degrees += 180
	
	sprite_2d.rotation_degrees = 10 if sin(Time.get_ticks_msec() * 0.014) > 0 else -10
	position.x += direction * Speed * delta

func _change_sprite(LG : bool):
	is_lg = LG
	if LG:
		sprite_2d.texture = LG_TRUE
		sprite_2d.scale = Vector2.ONE * 0.617
	else:
		sprite_2d.texture = TRUE
		sprite_2d.scale = Vector2.ONE * 0.016
