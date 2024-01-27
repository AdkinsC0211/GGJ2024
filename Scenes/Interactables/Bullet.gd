extends Area3D

var lifespan = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate_object_local(Vector3.UP*delta*25)
	lifespan -= delta
	if lifespan<0:
		queue_free()


func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.queue_free()
	if not body.is_in_group("player"):
		queue_free()
