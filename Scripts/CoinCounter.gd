extends Label

onready var player_node = get_parent().get_parent().get_parent().get_parent()

func _process(delta):
	self.text = str(int(player_node.coins))
