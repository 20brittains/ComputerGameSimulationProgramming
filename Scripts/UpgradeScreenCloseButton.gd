extends MarginContainer

onready var player_node = get_parent().get_parent()

func _on_CloseButton_button_up():
	self.queue_free()

func _on_JumpUpgradeButton_button_up():
	player_node.jump_ratio += .1

func _on_CoinUpgradeButton_button_up():
	player_node.speed_ratio += .1
