extends Area2D

var multi = 1

func _process(delta):
	position.x += multi*300*delta

func _on_Car_body_entered(body):
	if body is TileMap:
		multi *= -1
		get_node("CarSprite").flip_h = !get_node("CarSprite").flip_h
	if body is KinematicBody2D:
		body.damage()
	pass # Replace with function body.

func _ready():
	randomize()
	get_node("CarSprite").modulate = Color(randf(), randf(), randf())
