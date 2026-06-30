extends CharacterBody2D

@export_category("Stats")
@export var SPEED := 350.0
@export var JUMP_VELOCITY := -600.0

const TRUE = preload("res://Assets/true.png")
const LG_TRUE = preload("res://Assets/LGTrue.png")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ORIGINAL_SCALE = sprite_2d.scale

var is_lg := false

func _ready() -> void:
	SignalBus.lg_mode.connect(_change_sprite)

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
	
	move_and_slide()


func _process(_delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
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
			if not is_lg:
				@warning_ignore("integer_division")
				sprite_2d.scale = Vector2(ORIGINAL_SCALE.x, ORIGINAL_SCALE.y + sin(Time.get_ticks_msec()/300)/1000)
			else:
				@warning_ignore("integer_division")
				sprite_2d.scale = Vector2(ORIGINAL_SCALE.x, ORIGINAL_SCALE.y + sin(Time.get_ticks_msec()/300)/30)
			sprite_2d.position = Vector2(0, 30)
			sprite_2d.centered = false
			if not is_lg:
				sprite_2d.offset = Vector2(-1850, -3700)
			else:
				sprite_2d.offset = Vector2(-48, -96)
	else: # air
		sprite_2d.rotation_degrees = 0
		sprite_2d.scale = Vector2(ORIGINAL_SCALE.x,ORIGINAL_SCALE.y * 1.2)
		sprite_2d.position = Vector2(0, 30)
		sprite_2d.centered = false
		if not is_lg:
			sprite_2d.offset = Vector2(-1850, -3700)
		else:
			sprite_2d.offset = Vector2(-48, -96)


func _change_sprite(LG : bool) -> void:
	is_lg = LG
	if LG:
		sprite_2d.texture = LG_TRUE
		ORIGINAL_SCALE = Vector2.ONE * 0.617
	else:
		sprite_2d.texture = TRUE
		ORIGINAL_SCALE = Vector2.ONE * 0.016
