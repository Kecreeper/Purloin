extends Node

func wait(interval: float, function: Callable) -> void:
	var node = Node.new()
	var tween = create_tween()
	tween.tween_property($Node, "position", Vector2(0,1.0), 1.0)
	tween.tween_interval(interval)
	tween.tween_callback(function)
