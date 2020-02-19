extends Timer

func _process(delta):
	get_parent().text = str(int(self.time_left))
