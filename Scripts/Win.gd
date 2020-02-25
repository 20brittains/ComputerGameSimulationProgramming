extends Node


func _on_Timer_timeout():
	randomize()
	get_node("Particles2D").set_modulate(Color(randf(),randf(),randf()))
	randomize()
	get_node("Particles2D2").set_modulate(Color(randf(),randf(),randf()))
	get_parent().get_node("Player/CanvasLayer/Timer/Timer").stop()
