extends Button

func _process(delta):
	if Input.is_action_just_pressed("menu"):
			self.visible = !self.visible
			get_tree().paused = !get_tree().paused


func _on_QuitButton_button_up():
	get_tree().quit() 
