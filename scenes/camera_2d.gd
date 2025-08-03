extends Camera2D

@onready var player: CharacterBody2D = get_node("/root/Main/Player")

var speed = 100

func _ready() -> void:
	position = player.position
	zoom = Vector2(5,5)
	var tween = create_tween()
	tween.tween_property(self, "zoom", Vector2(1,1), 0.5)

func distanceFromPlayer() -> float:
	return player.position.distance_to(position)

func _physics_process(_delta) -> void:
	position = position + Vector2.from_angle(position.angle_to_point(player.position)) * speed
