extends StaticBody2D

@onready var wall: Sprite2D = get_node("Sprite2D")
@onready var inspectArea: Area2D = get_node("Inspect")
@onready var inspectCollision: CollisionShape2D = get_node("Inspect/CollisionShape2D")
@onready var climbArea: Area2D = get_node("Climb Through")
@onready var climbCollision: CollisionShape2D = get_node("Climb Through/CollisionShape2D")

var speech = "I can climb through this wall..."

var inspectAvailable = true
var climbAvailable = false



func climbThrough():
	GLOBAL.player.position = wall.global_position - Vector2(0, 10)

func clearSpeech():
	get_tree().get_nodes_in_group("SpeechText")[0].text = ""

func playSpeech():
	inspectAvailable = false
	get_tree().get_nodes_in_group("SpeechText")[0].text = speech #:sob:
	var tween = create_tween()
	tween.tween_property($tween, "position", Vector2(0,1.0), 1.0)
	tween.tween_interval(3.0)
	tween.tween_callback(clearSpeech)
func _input(event):
	if !event.is_action_pressed("interact"):
		return
	if self not in GLOBAL.availableInteractions:
		return
	if inspectAvailable == true:
		playSpeech()
