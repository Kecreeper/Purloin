extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var raycast: RayCast2D = get_node("AnimatedSprite2D/PlayerRayCast2D")

@onready var uiBar: HBoxContainer = get_node("/root/Main/CanvasLayer/bottomBarUI/MarginContainer/HBoxContainer")
var keybindScene = preload("res://scenes/KeybindUI.tscn")

@onready var ringRadiusCollision: CollisionShape2D = get_node("Noise/CollisionShape2D")
@onready var ringRadiusImage: AnimatedSprite2D = get_node("Noise/noiseRadius")

var speed = 100.0
var ringSpeed = 5

func updateNoise(delta: float) -> void:
	var currentVelocity = velocity.length()
	
	var distance1 = currentVelocity/2 - ringRadiusCollision.shape.radius
	var distance2 = Vector2(currentVelocity/100, currentVelocity/100) - ringRadiusImage.scale 
	
	ringRadiusCollision.shape.radius += distance1*ringSpeed*delta
	ringRadiusImage.scale += distance2*ringSpeed*delta

func processInput() -> void:
	var modifier = 1.0
	var direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("run"):
		modifier = 1.25
	elif Input.is_action_pressed("slowwalk"):
		modifier = 0.5
	velocity = direction * speed * modifier
	if direction.x > 0:
		sprite.play("right")
	elif direction.x < 0:
		sprite.play("left")
	elif direction.y < 0:
		sprite.play("up")
	elif direction.y > 0:
		sprite.play("down")

var showing_Interaction = false
var interactions = [
	"Hide",
	"Loot"
]
var interactionBinds = {
	"Hide" = "E",
	"Loot" = "E"
}
var currentInteractions = {}

func showInteraction(collision):
	if showing_Interaction != false:
		return
	if collision.name not in interactions:
		return
	var newKey: HBoxContainer = keybindScene.instantiate()
	var newKeyBind    = newKey.get_node("ButtonContainer/Input")
	var newKeyAction  = newKey.get_node("Action")
	newKeyBind.text   = interactionBinds[collision.name]
	newKeyAction.text = collision.name
	uiBar.add_child(newKey)
	currentInteractions.append(newKey)
	showing_Interaction = true

func checkForInteractions():
	var collision = raycast.get_collider()
	if collision == null:
		if showing_Interaction == true:
			for child in uiBar.get_children():
				child.queue_free()
			#currentInteractions.clear()
			showing_Interaction = false
		return
	showInteraction(collision)

func _physics_process(delta):
	processInput()
	move_and_slide()
	checkForInteractions()
	updateNoise(delta)
