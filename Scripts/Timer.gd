extends Timer

func _process(_delta):
	get_parent().text = str(int(self.time_left))
