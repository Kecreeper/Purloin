extends Node

@onready var player: CharacterBody2D = get_node("/root/Main/Player")

var pausePhysics = false
var pauseCamera = false
var cameraTarget: Vector2 = Vector2(0,0)
var availableInteractions = []
