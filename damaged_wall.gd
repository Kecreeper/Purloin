extends StaticBody2D

@onready var wall: Sprite2D = get_node("Sprite2D")
@onready var inspectArea: Area2D = get_node("Inspect")
@onready var inspectCollision: CollisionShape2D = get_node("Inspect/CollisionShape2D")
@onready var climbArea: Area2D = get_node("Climb Through")
@onready var climbCollision: CollisionShape2D = get_node("Climb Through/CollisionShape2D")

var speech = "I can climb through this wall..."

var inspectAvailable = true
var climbAvailable = false

func makeWallClear():
	wall.modulate = "ffffff68"

func climbThrough():
	GLOBAL.player.position = wall.global_position - Vector2(0, 10)
	makeWallClear()

func clearSpeech():
	get_tree().get_nodes_in_group("SpeechText")[0].text = ""

func playSpeech():
	inspectAvailable = false
	inspectCollision.disabled = true
	get_tree().get_nodes_in_group("SpeechText")[0].text = speech #:sob:
	wait.wait(3.0, clearSpeech)
	climbCollision.disabled = false
	climbAvailable = true
func _input(event):
	if !event.is_action_pressed("interact"):
		return
	if self not in GLOBAL.availableInteractions:
		return
	if inspectAvailable == true:
		playSpeech()
	elif climbAvailable == true:
		climbThrough()
