extends RayCast2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	target_position = get_viewport().get_mouse_position()
