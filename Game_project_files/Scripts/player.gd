extends CharacterBody2D

const SPEED = 180.0
const JUMP_VELOCITY = -550.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

# Add a boolean flag 'can_move' and initialize it to true
var can_move = true

func _ready():
	Global.area_entered = 1

func _physics_process(delta):
	# Only process movement if can_move is true
	if can_move:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction = Input.get_axis("move_left", "move_right")
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true

		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walk")

		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	# Always call move_and_slide() to apply physics calculations
	move_and_slide()
	if Input.is_action_pressed("message"):
		disable_movement()
	if Input.is_action_just_pressed("ui_text_completion_accept"):
		enable_movement()

# Example functions to toggle can_move
func disable_movement():
	can_move = false

func enable_movement():
	can_move = true


func _on_area_2d_body_entered(body):
	Global.area_entered = 3
	pass


func _on_area_2d_3_body_entered(body):
	Global.area_entered = 6
	pass # Replace with function body.


func _on_area_2d_4_body_entered(body):
	Global.area_entered = 9
	pass # Replace with function body.


func _on_area_2d_5_body_entered(body):
	Global.area_entered = 12
	pass # Replace with function body.


func _on_area_2d_6_body_entered(body):
	Global.area_entered = 2
	pass # Replace with function body.


func _on_area_2d_7_body_entered(body):
	Global.area_entered = 5
	pass # Replace with function body.


func _on_area_2d_8_body_entered(body):
	Global.area_entered = 8
	pass # Replace with function body.


func _on_area_2d_9_body_entered(body):
	Global.area_entered = 11
	pass # Replace with function body.


func _on_area_2d_10_body_entered(body):
	Global.area_entered = 1
	pass # Replace with function body.


func _on_area_2d_11_body_entered(body):
	Global.area_entered = 4
	pass # Replace with function body.


func _on_area_2d_12_body_entered(body):
	Global.area_entered = 7
	pass # Replace with function body.


func _on_area_2d_13_body_entered(body):
	Global.area_entered = 10
	pass # Replace with function body.
