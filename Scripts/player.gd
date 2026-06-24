extends CharacterBody2D

@export_category("Stats")
@export var SPEED := 350.0
@export var JUMP_VELOCITY := -600.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ORIGINAL_SCALE = sprite_2d.scale

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# Animations
	if is_on_floor():
		if direction: # walking
			sprite_2d.rotation_degrees = 10 if sin(Time.get_ticks_msec() * 0.014) > 0 else -10
			sprite_2d.scale = Vector2(ORIGINAL_SCALE)
			sprite_2d.position = Vector2.ZERO
			sprite_2d.centered = true
			sprite_2d.offset = Vector2.ZERO
		else: # idle
			sprite_2d.rotation_degrees = 0
			@warning_ignore("integer_division")
			sprite_2d.scale = Vector2(ORIGINAL_SCALE.x, ORIGINAL_SCALE.y + sin(Time.get_ticks_msec()/300)/1000)
			sprite_2d.position = Vector2(0, 30)
			sprite_2d.centered = false
			sprite_2d.offset = Vector2(-1850, -3700)
	else: # air
		sprite_2d.rotation_degrees = 0
		sprite_2d.scale = Vector2(ORIGINAL_SCALE.x,ORIGINAL_SCALE.y * 1.2)
		sprite_2d.position = Vector2.ZERO
		sprite_2d.centered = true
		sprite_2d.offset = Vector2.ZERO

	move_and_slide()
