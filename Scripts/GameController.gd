extends Node


var upgrade_scene = load("res://Scenes/UpgradeScreen.tscn")
var world1_scene = load("res://Scenes/World.tscn")
var world2_scene = load("res://Scenes/World2.tscn")
var world3_scene = load("res://Scenes/World3.tscn")
var world4_scene = load("res://Scenes/World4.tscn")
var win_scene = load("res://Scenes/Win.tscn")
var player_scene = load("res://Scenes/Player.tscn")

var game_initialized = false


func initialize_game():
	
	get_node("TitleScreen").queue_free()
	game_initialized = true
	
	var World1 = world1_scene.instance()
	World1.name = "World1"
	add_child(World1)
	
	var player = player_scene.instance()
	player.global_position = Vector2(0,0)
	add_child(player)
	
	get_tree().paused = true
	
	var up = upgrade_scene.instance()
	add_child(up)

func player_death():
	get_node("Player/CanvasLayer/Timer/Timer").stop()
	
	if self.has_node("World1"):
		remove_child(get_node("World1"))
	elif self.has_node("World2"):
		remove_child(get_node("World2"))
	elif self.has_node("World3"):
		remove_child(get_node("World3"))
	elif self.has_node("World4"):
		remove_child(get_node("World4"))
		
	if get_node("Player").awards == 0:
		var World1 = world1_scene.instance()
		World1.name = "World1"
		add_child(World1)
		
	elif get_node("Player").awards == 1:
		var World2 = world2_scene.instance()
		World2.name = "World2"
		add_child(World2)
		
	elif get_node("Player").awards == 2:
		var World3 = world3_scene.instance()
		World3.name = "World3"
		add_child(World3)
	
	elif get_node("Player").awards == 3:
		var World4 = world4_scene.instance()
		World4.name = "World4"
		add_child(World4)
	
	elif get_node("Player").awards == 4:
		var Win = win_scene.instance()
		Win.name = "Win"
		add_child(Win)
	
	get_node("Player/CanvasLayer/HBoxContainer/HBoxContainer2/TextureRect").hide()
	get_node("Player/CanvasLayer/HBoxContainer/HBoxContainer/Coin Counter").hide()
	get_node("Player/CanvasLayer/Timer").hide()
	
	get_tree().paused = true
	
	var up = upgrade_scene.instance()
	add_child(up)
	get_node("Player/CanvasLayer/Respawn Button").visible = false
	for i in get_node("Player").heart_array.size():
		get_node("Player").get_node(get_node("Player").heart_array[i]).hide()
	pass

func reset_stats():
	get_node("Player").jump_upgrade_number= 0
	get_node("Player").coin_upgrade_number= 0
	get_node("Player").timer_upgrade_number= 0
	get_node("Player").speed_upgrade_number= 0
	get_node("Player").jump_upgrade_number = 0
	get_node("Player").speed_ratio = .5
	get_node("Player").speed_upgrade_number = 0
	get_node("Player").jump_ratio = 0
	get_node("Player").coin_upgrade_number = 0
	get_node("Player").coins = 0
	get_node("Player").coin_multiplier = 1
	get_node("Player").timer_upgrade_ratio = 1
	get_node("Player").timer_upgrade_number = 0
	get_node("Player").hp_upgrade_number = 1
	get_node("Player").hp = 1
