extends CanvasLayer

onready var player_node = get_parent().get_parent()

func _on_CloseButton_button_up():
	self.queue_free()

func _on_JumpUpgradeButton_button_up():
	player_node.jump_ratio += .1

func _on_CoinUpgradeButton_button_up():
	player_node.coin_multiplier += 1

func _on_SpeedUpgradeButton_button_up():
	player_node.speed_ratio += .1

func _on_TimerUpgradeButton_button_up():
	player_node.timer_upgrade_ratio += 0.5
