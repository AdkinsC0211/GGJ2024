extends CharacterBody3D


@onready var nav_agent = $NavigationAgent3D
@onready 
var SPEED = 6.0
var can_hit=true


func _physics_process(delta):
	var current_location = global_transform.origin #current enemy location
	var next_location = nav_agent.get_next_path_position() #next location the nav agent is directing towards
	var new_velocity = (next_location - current_location).normalized() * SPEED #calculate velocity between current and next location
	
	
	nav_agent.set_velocity(new_velocity)
	
func update_target_location(target_position):
	nav_agent.set_target_position(target_position)




func _on_navigation_agent_3d_target_reached():
	if can_hit:
		print("ouchouch")
		can_hit=false


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, .25)
	move_and_slide()


func _on_timer_timeout():
	can_hit = true

func _exit_tree():
	get_tree().get_root().get_node("/root/Singleton").play_effect("res://Scenes/Particles/banan.tscn", global_transform.origin)
