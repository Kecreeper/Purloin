extends Camera2D

@onready var player: CharacterBody2D = get_node("/root/Main/Player")
var speed = 80
var zoomTo = Vector2(3, 3)

func _ready() -> void:
	position = player.position
	zoom = Vector2(10, 10)
	var tween = create_tween()
	tween.tween_property(self, "zoom", zoomTo, 0.5)

func distanceFromPlayer() -> float:
	return player.position.distance_to(position)

func _process(delta) -> void:
	position += (player.position - position).normalized()*speed*delta*(distanceFromPlayer()/25)
