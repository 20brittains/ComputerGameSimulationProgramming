extends Label

onready var player_node = get_parent().get_parent().get_parent().get_parent()

func _process(delta):
	self.text = str(player_node.coins)