extends Node


var upgrade_scene = load("res://Scenes/UpgradeScreen.tscn")
var world1_scene = load("res://Scenes/World.tscn")
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
		var World1 = world1_scene.instance()
		World1.name = "World1"
		add_child(World1)
	
	get_node("Player/CanvasLayer/HBoxContainer/HBoxContainer2/TextureRect").hide()
	get_node("Player/CanvasLayer/HBoxContainer/HBoxContainer/Coin Counter").hide()
	get_node("Player/CanvasLayer/Timer").hide()
	
	get_tree().paused = true
	
	var up = upgrade_scene.instance()
	add_child(up)
	pass
