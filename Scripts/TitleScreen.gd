extends MarginContainer



func _on_Play_Button_button_up():
	get_parent().initialize_game()

func _on_Quit_Button_button_up():
	get_tree().quit()
