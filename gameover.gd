extends Control

@onready var moneky = $Monkey

func _on_button_pressed():
	pass # Replace with function body.
	# go back to the first level
	# start over button
	



func _on_button_2_pressed():
	get_tree().quit()


func _on_button_3_pressed():
	moneky.play()
