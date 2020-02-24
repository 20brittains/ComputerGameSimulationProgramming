extends MarginContainer



func _on_Play_Button_button_up():
	get_parent().initialize_game()

func _on_Quit_Button_button_up():
	get_tree().quit()

func _on_HelpButton_button_up():
	pass # Replace with function body.
