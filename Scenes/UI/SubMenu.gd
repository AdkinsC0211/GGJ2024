extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_menu_pressed():
	get_tree().get_root().get_node("/root/Singleton").change_menu("res://Scenes/UI/Main Menu.tscn")
