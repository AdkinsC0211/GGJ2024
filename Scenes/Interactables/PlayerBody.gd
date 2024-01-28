extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

const MAX_HEALTH = 100
var health = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	if velocity.length() > 0 and is_on_floor():
		$MonkeyFeet.pitch_scale = velocity.length()/5
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if is_on_floor():
			if not $MonkeyFeet.playing:
				$MonkeyFeet.play()
		else:
			$MonkeyFeet.stop()
	else:
		if $MonkeyFeet.playing:
			$MonkeyFeet.stop()
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func damage(amount):
	health -= amount
	if health <= 0:
		kill()

func kill():
	$Camera3D.reparent(get_tree().get_root().get_node("Main").get_node("WorldRoot"), true)
	get_tree().get_root().get_node("/root/Singleton").play_global("res://Assets/Sounds/MonkeDie.wav")
	get_tree().get_root().get_node("/root/Singleton").play_effect("res://Scenes/Particles/fire_particles.tscn", global_transform.origin)
	get_parent().queue_free()
