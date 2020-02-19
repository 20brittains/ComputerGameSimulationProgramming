extends Node


var upgrade_scene = load("res://Scenes/UpgradeScreen.tscn")
var world1_scene = load("res://Scenes/World.tscn")
var player_scene = load("res://Scenes/Player.tscn")

var game_initialized = false

func initialize_game():
	get_node("TitleScreen").queue_free()
	game_initialized = true
	
	var world = world1_scene.instance()
	add_child(world)
	
	var player = player_scene.instance()
	player.global_position = Vector2(0,0)
	add_child(player)
	
	get_tree().paused = true
	
	var up = upgrade_scene.instance()
	add_child(up)
