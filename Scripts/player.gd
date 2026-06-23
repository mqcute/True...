extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -600.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ORIGINAL_SCALE = sprite_2d.scale

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

#animations
func _process(delta: float) -> void:
	if Input.get_axis("ui_left", "ui_right") and is_on_floor(): # walking
		sprite_2d.rotation_degrees = 10 if sin(Time.get_ticks_msec() * 2 * delta)/3 > 0 else -10
		sprite_2d.scale = Vector2(ORIGINAL_SCALE)
	elif !is_on_floor(): # air
		sprite_2d.rotation = 0
		sprite_2d.scale = Vector2(ORIGINAL_SCALE.x,ORIGINAL_SCALE.y * 1.2)
	else: # idle
		sprite_2d.rotation = 0
		@warning_ignore("integer_division")
		sprite_2d.scale = Vector2(ORIGINAL_SCALE.x, ORIGINAL_SCALE.y  + sin(Time.get_ticks_msec()/300)/1000)
		#sprite_2d.scale = Vector2(ORIGINAL_SCALE)
