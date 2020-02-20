extends Area2D


func _on_Spike_body_entered(body):
	if body.name == "Player":
		body.get_node("CanvasLayer/Timer/Timer").start(0.01)
