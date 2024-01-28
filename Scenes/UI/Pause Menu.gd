extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().get_root().get_node("/root/Singleton").pause()


func _on_resume_pressed():
	get_tree().get_root().get_node("/root/Singleton").pause()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_main_menu_pressed():
	get_tree().get_root().get_node("/root/Singleton").change_menu("res://Scenes/UI/Main Menu.tscn")
	get_tree().get_root().get_node("/root/Singleton").pause()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_quit_pressed():
	get_tree().quit()
