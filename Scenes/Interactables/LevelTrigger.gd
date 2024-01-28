extends Node

@export var folderPath = "path here"
@export var levelPath = "path here"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	var completePath = "res://Scenes/Levels/" + levelPath + ".tscn"
	
	get_tree().get_root().get_node("/root/Singleton").change_level(completePath)
