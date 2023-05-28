extends CharacterBody2D

var SPEED = 600.0
var JUMP_FORCE = -620.0
var GRAVITY = 30

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

var original_scale = Vector2(1, 1)  # Store the original scale of the sprite

func _ready():
	original_scale = sprite.scale

func _physics_process(delta):
	var horizontal_direction = sign(velocity.x)

	if !is_on_floor():
		velocity.y += GRAVITY
		if velocity.y > 1000:
			velocity.y = 1000

	if Input.is_action_just_pressed("ui_select"):
		if is_on_floor():
			velocity.y = JUMP_FORCE

			# Fixate the sprite's scale to the original size during jumping animation
			sprite.scale = original_scale

			ap.play("jumping")  # Play the jumping animation when character jumps
	else:
		if is_on_floor():
			if horizontal_direction == 0:
				ap.play("idle")  # Play the idle animation when on the ground
			else:
				ap.play("running")  # Play the running animation when on the ground and moving

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if horizontal_direction != 0:
		sprite.flip_h = (horizontal_direction == -1)

	move_and_slide()

	update_animations(horizontal_direction)

func update_animations(horizontal_direction):
	if !is_on_floor():
		ap.play("jumping")  # Play the jumping animation while character is in the air
