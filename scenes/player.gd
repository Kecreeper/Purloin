extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var raycast: RayCast2D = get_node("AnimatedSprite2D/RayCast2D")

@onready var bar: HBoxContainer = get_node("/root/Main/CanvasLayer/bottomBarUI/MarginContainer/HBoxContainer")
var keybindScene = preload("res://scenes/KeybindUI.tscn")

@onready var ringRadiusCollision: CollisionShape2D = get_node("Noise/CollisionShape2D")
@onready var ringRadiusImage: AnimatedSprite2D = get_node("Noise/noiseRadius")

var speed = 100.0
var ringSpeed = 5
var barKeys = []

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

func checkForInteractions():
	var collision = raycast.get_collider()
	if collision == null:
		for child in bar.get_children():
			child.queue_free()
		barKeys.clear()
		showing_Interaction = false
		return
	elif collision.name == "Interaction" and showing_Interaction == false:
		showing_Interaction = true
		var newKeybind: HBoxContainer = keybindScene.instantiate()
		newKeybind.get_node("ButtonContainer/Input").text = "E"
		newKeybind.get_node("Action").text = "Interact"
		bar.add_child(newKeybind)
		barKeys.append(newKeybind)
	print(barKeys)

func _physics_process(delta):
	processInput()
	move_and_slide()
	checkForInteractions()
	updateNoise(delta)
