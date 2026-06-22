extends Node2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export_range(-120, 120) var speed : float
var direction = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		direction *= -1
		ray_cast_2d.rotation_degrees += 180
	
	sprite_2d.rotation_degrees = 10 if sin(Time.get_ticks_msec() * 2 * delta)/3 > 0 else -10
	position.x += direction * speed * delta
