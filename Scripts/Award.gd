extends Area2D

var ignore = false

func _on_MonitorTimer_timeout():
	self.monitoring = true
	
func _on_DespawnTimer_timeout():
	get_parent().get_parent().reset_stats()
	get_parent().get_parent().call_deferred("player_death")
	queue_free()

func _on_BAAaward_body_entered(body):
	if body.name == "Player" and ignore == false:
		print("got here")
		body.awards += 1
		$CoinSound.play()
		$GoldParticle.emitting = true
		$DespawnTimer.start()
		$CoinSprite.hide()
		ignore = true
