extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var raycast: RayCast2D = get_node("AnimatedSprite2D/RayCast2D")

var speed = 125.0

func playerInput():
	var modifier = 1.0
	var direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("run"):
		modifier = 1.25
	velocity = direction * speed * modifier
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

func _physics_process(_delta):
	playerInput()
	checkForInteractions()
	move_and_slide()
	print(speed)
