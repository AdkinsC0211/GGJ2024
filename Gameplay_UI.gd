extends Control

@onready var textRect: TextureRect = $TextureRect
@onready var images = []

@onready var myPrecious = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	var texture
	for i in range(1, 13):
		texture = load("res://Teeth/Tooth_" + str(i) + ".png")
		images.append(texture)
	health_changed(100, 100)
	
func health_changed(currentHealth: float, maxHealth: float):
	var healthRatio = (currentHealth/maxHealth * 12) - 1
	healthRatio = clamp(healthRatio, 0, 11)
	textRect.set_texture(images[healthRatio])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
