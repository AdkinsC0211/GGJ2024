extends RigidBody3D

const BULLET = preload("res://Scenes/Interactables/Bullet.tscn")
var can_fire = true
var fire_rate = 0
var can_talk = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fire_rate = clamp(fire_rate - (delta*2/($"../Body".velocity.length()+0.5)), 0, 10)
	if fire_rate > 2 and can_talk:
		if fire_rate > 7:
			var temp = load("res://Assets/Sounds/MonkeExcited"+str(randi_range(1,5))+".wav")
			$"../Body/LeMonkASMR".stream = temp
			$"../Body/LeMonkASMR".play()
		else:
			var temp = load("res://Assets/Sounds/MonkeHappy"+str(randi_range(1,5))+".wav")
			$"../Body/LeMonkASMR".stream = temp
			$"../Body/LeMonkASMR".play()
		can_talk=false

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT and can_fire):
			apply_impulse(Vector3.UP*30, $Marker3D.transform.origin)
			var temp = BULLET.instantiate()
			get_tree().get_root().get_node("Main").get_node("WorldRoot").add_child(temp)
			temp.global_transform = $Gun.global_transform
			for i in range(15):
				temp = BULLET.instantiate()
				get_tree().get_root().get_node("Main").get_node("WorldRoot").add_child(temp)
				temp.global_transform = $Gun.global_transform
				temp.global_rotation_degrees.x += randf_range(-20, 20)
				temp.global_rotation_degrees.z += randf_range(-20, 20)
				temp.global_rotation_degrees.y += randf_range(-20, 20)
			$FireTimer.start()
			fire_rate+=1
			can_fire = false
			$Gun/Blast.play()


func _on_timer_timeout():
	can_fire = true
	$ReloadTimer.wait_time = 1.25
	$ReloadTimer.start()


func _on_reload_timer_timeout():
	$Gun/Reload.play()


func _on_speech_cooldown_timeout():
	can_talk = true


func _on_le_monk_asmr_finished():
	$SpeechCooldown.start()

func _on_area_3d_body_entered(body):
	if not body.is_in_group("player") and not body.is_in_group("enemies"):
		$clack.play()
