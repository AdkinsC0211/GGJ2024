extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func play_here(audioPath, location=Vector3(0,0,0)):
	var temp = load(audioPath)
	var audioPlayer = AudioStreamPlayer3D.new()
	get_tree().get_root().get_node("Main").get_node("WorldRoot").add_child(audioPlayer)
	audioPlayer.position = location
	audioPlayer.stream = temp
	audioPlayer.playing=true
	while audioPlayer.playing:
		pass
	audioPlayer.queue_free()

func play_global(audioPath):
	var temp = load(audioPath)
	var audioPlayer = AudioStreamPlayer.new()
	get_tree().get_root().get_node("Main").add_child(audioPlayer)
	audioPlayer.stream = temp
	audioPlayer.playing=true
	await audioPlayer.finished
	audioPlayer.queue_free()

func play_effect(vfxPath, location=Vector3(0,0,0)):
	var temp = load(vfxPath)
	temp = temp.instantiate()
	get_tree().get_root().get_node("Main").get_node("WorldRoot").add_child(temp)
	temp.position = location
	temp.emitting = true
	await temp.finished
	temp.queue_free()

func change_level(scenePath):
	var temp = load(scenePath)
	var temper = get_tree().get_root().get_node("Main").get_node("WorldRoot").get_node("Level").get_child_count()
	if temper!=0:
		get_tree().get_root().get_node("Main").get_node("WorldRoot").get_node("Level").get_child(0).queue_free()
	var level = temp.instantiate()
	get_tree().get_root().get_node("Main").get_node("WorldRoot").get_node("Level").add_child(level)
	temper = get_tree().get_root().get_node("Main").get_node("UI").get_node("Menu").get_child_count()
	if temper!=0:
		get_tree().get_root().get_node("Main").get_node("UI").get_node("Menu").get_child(0).queue_free()

func change_menu(scenePath):
	var temp = load(scenePath)
	var temper = get_tree().get_root().get_node("Main").get_node("UI").get_node("Menu").get_child_count()
	if temper!=0:
		get_tree().get_root().get_node("Main").get_node("UI").get_node("Menu").get_child(0).queue_free()
	var menu = temp.instantiate()
	get_tree().get_root().get_node("Main").get_node("UI").get_node("Menu").add_child(menu)
	temper = get_tree().get_root().get_node("Main").get_node("WorldRoot").get_node("Level").get_child_count()
	if temper!=0:
		get_tree().get_root().get_node("Main").get_node("WorldRoot").get_node("Level").get_child(0).queue_free()

func change_music(audioPath):
	var temp = load(audioPath)
	if temp != get_tree().get_root().get_node("Main").get_node("Music").stream:
		get_tree().get_root().get_node("Main").get_node("Music").stream = temp
		get_tree().get_root().get_node("Main").get_node("Music").play()

func pause():
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		get_tree().get_root().get_node("Main").get_node("UI").get_node("Pause").get_node("PauseMenu").show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		get_tree().get_root().get_node("Main").get_node("UI").get_node("Pause").get_node("PauseMenu").hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
