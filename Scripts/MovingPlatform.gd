extends Node2D

export (int) var speed = 250
onready var path_follow = $Path2D/PathFollow2D
var mod = 1

func _ready():
	path_follow.unit_offset = randf()

func _process(delta):
	$MovingPlatform.global_position = $Path2D/PathFollow2D.global_position
	if path_follow.unit_offset == 0:
		mod = 1
	if path_follow.unit_offset == 1:
		mod = -1
	path_follow.offset += mod*speed*delta
