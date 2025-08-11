extends StaticBody2D

@onready var interactionArea: Area2D = get_node("Hide")
@onready var cabinet: Sprite2D = get_node("CabinetSprite")
@onready var doors: AnimatedSprite2D = get_node("AnimatedSprite2D")

var playerHidden = false
var cooldown = false


#func turnOffCooldown():
#	cooldown = false
	#doors.animation_finished.disconnect(turnOffCooldown())

func intoCabinet():
	GLOBAL.player.position = doors.global_position + Vector2(0,20.0)
	playerHidden = true
	doors.animation_finished.disconnect(intoCabinet)
	doors.play("close")
	#doors.animation_finished.connect(turnOffCooldown())

func enterCabinet():
	GLOBAL.pausePhysics = true
	cooldown = true
	doors.play("open")
	doors.animation_finished.connect(intoCabinet)

func outCabinet():
	GLOBAL.player.position = doors.global_position + Vector2(0, 30.0)
	playerHidden = false
	doors.animation_finished.disconnect(outCabinet)
	doors.play("close")
	GLOBAL.pausePhysics = false
	#doors.animation_finished.connect(turnOffCooldown())
func exitCabinet():
	cooldown = true
	doors.play("open")
	doors.animation_finished.connect(outCabinet)

# if if if if if if if if if
func _input(event):
	if !event.is_action_pressed("interact"):
		return
	if self not in GLOBAL.availableInteractions:
		return
	#if cooldown == true:
	#	return
	if playerHidden == false:
		enterCabinet()
	elif playerHidden == true:
		exitCabinet()


func _on_animated_sprite_2d_animation_finished() -> void:
	pass # Replace with function body.
