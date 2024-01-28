extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_play_pressed():
	get_tree().get_root().get_node("/root/Singleton").change_level("res://Scenes/Levels/Level_1.tscn")


func _on_quit_pressed():
	get_tree().quit()



func _on_controls_pressed():
	get_tree().get_root().get_node("/root/Singleton").change_menu("res://Scenes/UI/Controls.tscn")


func _on_credits_pressed():
	get_tree().get_root().get_node("/root/Singleton").change_menu("res://Scenes/UI/Credits.tscn")
