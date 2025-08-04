extends Camera2D

@onready
var player: CharacterBody2D = get_node("/root/Main/Player")
var speed = 80

func _ready() -> void:
	position = player.position
	zoom = Vector2(5,5)
	var tween = create_tween()
	tween.tween_property(self, "zoom", Vector2(1,1), 0.5)

func distanceFromPlayer() -> float:
	return player.position.distance_to(position)

func _process(delta) -> void:
	position += (player.position - position).normalized()*speed*delta*(distanceFromPlayer()/25)
