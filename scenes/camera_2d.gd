extends Camera2D

@onready var player: CharacterBody2D = $Player
@onready var bottomBarUI: Control = get_node("")
var speed = 80
var scaleTo = Vector2(1.0, 1.0)

func _ready() -> void:
	position = player.position
	scale = Vector2(0.3,0.3)
	var tween = create_tween()
	tween.tween_property(self, "scale", scaleTo, 0.5)

func distanceFromPlayer() -> float:
	return player.position.distance_to(position)

func _process(delta) -> void:
	position += (player.position - position).normalized()*speed*delta*(distanceFromPlayer()/25)
