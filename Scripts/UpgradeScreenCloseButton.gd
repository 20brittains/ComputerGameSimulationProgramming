extends CanvasLayer

onready var player_node = get_parent().get_node("Player")


func _on_JumpUpgradeButton_button_up():
	if player_node.jump_upgrade_number < 20 and player_node.coins >= 3 + int(pow(player_node.jump_upgrade_number+1, 3)):
		player_node.coins -= 3 + int(pow(player_node.jump_upgrade_number+1, 3))
		player_node.jump_ratio += .2
		player_node.jump_upgrade_number += 1

func _on_CoinUpgradeButton_button_up():
	if player_node.coin_upgrade_number < 20 and player_node.coins >= 3 + int(pow(player_node.coin_upgrade_number+1, 3)):
		player_node.coins -= 3 + int(pow(player_node.coin_upgrade_number+1, 3))
		player_node.coin_multiplier += .5
		player_node.coin_upgrade_number += 1

func _on_SpeedUpgradeButton_button_up():
	if player_node.speed_upgrade_number < 20 and player_node.coins >= 3 + int(pow(player_node.speed_upgrade_number+1, 3)):
		player_node.coins -= 3 + int(pow(player_node.speed_upgrade_number+1, 3))
		player_node.speed_ratio += .05
		player_node.speed_upgrade_number += 1

func _on_TimerUpgradeButton_button_up():
	if player_node.timer_upgrade_number < 20 and player_node.coins >= 3 + int(pow(player_node.timer_upgrade_number+1, 3)):
		player_node.coins -= 3 + int(pow(player_node.timer_upgrade_number+1, 3))
		player_node.timer_upgrade_ratio += 1
		player_node.timer_upgrade_number += 1

func _on_PlayButton_button_up():
	player_node.global_position = Vector2(0,0)
	get_tree().paused = false
	
	player_node.get_node("CanvasLayer/Timer").visible = true
	player_node.get_node("CanvasLayer/Timer/Timer").wait_time = int(5 * player_node.timer_upgrade_ratio)
	player_node.get_node("CanvasLayer/Timer/Timer").start(player_node.get_node("CanvasLayer/Timer/Timer").wait_time)
	
	player_node.get_node("CanvasLayer/HBoxContainer/HBoxContainer/Coin Counter").visible = true
	player_node.get_node("CanvasLayer/HBoxContainer/HBoxContainer2/TextureRect").visible = true
	

	self.queue_free()

func _process(delta):
	if player_node.jump_upgrade_number < 20 and player_node.coins < 3 + int(pow(player_node.jump_upgrade_number+1, 3)):
		$UpgradeScreen/Panel/UpgradeContainer/JumpUpgrade/VBoxContainer2/JumpUpgradeButton.disabled = true
	else: 
		$UpgradeScreen/Panel/UpgradeContainer/JumpUpgrade/VBoxContainer2/JumpUpgradeButton.disabled = false
		
	if player_node.speed_upgrade_number < 20 and player_node.coins < 3 + int(pow(player_node.speed_upgrade_number+1, 3)):
		$UpgradeScreen/Panel/UpgradeContainer/SpeedUpgrade/VBoxContainer2/SpeedUpgradeButton.disabled = true
	else: 
		$UpgradeScreen/Panel/UpgradeContainer/SpeedUpgrade/VBoxContainer2/SpeedUpgradeButton.disabled = false
		
	if player_node.coin_upgrade_number < 20 and player_node.coins < 3 + int(pow(player_node.coin_upgrade_number+1, 3)):
		$UpgradeScreen/Panel/UpgradeContainer/CoinUpgrade/VBoxContainer2/CoinUpgradeButton.disabled = true
	else: 
		$UpgradeScreen/Panel/UpgradeContainer/CoinUpgrade/VBoxContainer2/CoinUpgradeButton.disabled = false
		
	if player_node.timer_upgrade_number < 20 and player_node.coins < 3 + int(pow(player_node.timer_upgrade_number+1, 3)):
		$UpgradeScreen/Panel/UpgradeContainer/TimeUpgrade/VBoxContainer2/TimerUpgradeButton.disabled = true
	else: 
		$UpgradeScreen/Panel/UpgradeContainer/TimeUpgrade/VBoxContainer2/TimerUpgradeButton.disabled = false
	
	$UpgradeScreen/Panel/UpgradeContainer/JumpUpgrade/VBoxContainer3/Label.text = str(player_node.jump_upgrade_number) + "/20"
	$UpgradeScreen/Panel/UpgradeContainer/SpeedUpgrade/VBoxContainer3/Label2.text = str(player_node.speed_upgrade_number) + "/20"
	$UpgradeScreen/Panel/UpgradeContainer/CoinUpgrade/VBoxContainer3/Label3.text = str(player_node.coin_upgrade_number) + "/20"
	$UpgradeScreen/Panel/UpgradeContainer/TimeUpgrade/VBoxContainer3/Label4.text = str(player_node.timer_upgrade_number) + "/20"
	
	$UpgradeScreen/Panel/UpgradeContainer/JumpUpgrade/Price/PriceLabel/Label.text = "$" + str(3 + int(pow(player_node.jump_upgrade_number+1, 3)))
	$UpgradeScreen/Panel/UpgradeContainer/SpeedUpgrade/Price/PriceLabel/Label.text = "$" + str(3 + int(pow(player_node.speed_upgrade_number+1, 3)))
	$UpgradeScreen/Panel/UpgradeContainer/CoinUpgrade/Price/PriceLabel/Label.text = "$" + str(3 + int(pow(player_node.coin_upgrade_number+1, 3)))
	$UpgradeScreen/Panel/UpgradeContainer/TimeUpgrade/Price/PriceLabel/Label.text = "$" + str(3 + int(pow(player_node.timer_upgrade_number+1, 3)))
	
	$UpgradeScreen/Panel/CoinCounter/VBoxContainer/CounterLabel.text = str(int(player_node.coins))
	
