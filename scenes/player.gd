extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var raycast: RayCast2D = get_node("AnimatedSprite2D/RayCast2D")

var speed = 75

func playerInput():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	if direction.x > 0:
		sprite.play("right")
	elif direction.x < 0:
		sprite.play("left")
	elif direction.y < 0:
		sprite.play("up")
	elif direction.y > 0:
		sprite.play("down")
		
func checkForInteractions():
	print(raycast.get_collider())
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("run"):
		speed = 100
	else:
		speed = 75

func _physics_process(_delta):
	playerInput()
	checkForInteractions()
	move_and_slide()
	print(speed)
