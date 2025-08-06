extends CharacterBody2D

@onready
var sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")

var speed = 2

func move():
	var direction = Input.get_vector("left", "right", "up", "down")
	position += direction * speed
	if direction.x > 0:
		sprite.play("right")
	elif direction.x < 0:
		sprite.play("left")
	elif direction.y < 0:
		sprite.play("up")
	elif direction.y > 0:
		sprite.play("down")

func _physics_process(_delta):
	move()
