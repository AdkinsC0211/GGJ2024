extends RigidBody3D

const BULLET = preload("res://Scenes/Interactables/Bullet.tscn")
var can_fire = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

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
			can_fire = false
			$Gun/Blast.play()


func _on_timer_timeout():
	can_fire = true
	$ReloadTimer.wait_time = 2
	$ReloadTimer.start()


func _on_reload_timer_timeout():
	$Gun/Reload.play()
