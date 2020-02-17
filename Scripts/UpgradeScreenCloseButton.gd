extends MarginContainer


func _on_CloseButton_button_up():
	self.queue_free()

func _on_JumpUpgradeButton_button_up():
	get_parent().get_parent().jump_ratio += .1
