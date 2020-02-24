extends Button

func _process(_delta):
	if Input.is_action_just_pressed("menu"):
			self.visible = !self.visible
			#get_tree().paused = !get_tree().paused
			get_parent().get_parent().visible = true


func _on_QuitButton_button_up():
	get_tree().quit() 
