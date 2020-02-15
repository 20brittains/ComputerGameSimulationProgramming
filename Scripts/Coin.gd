extends Area2D

var ignore

func _on_Coin_body_entered(body):
	if body.name == "Player" and ignore != true:
		$GoldParticle.emitting = true
		$DespawnTimer.start()
		$CoinSprite.hide()
		ignore = true
		

func _on_Timer_timeout():
	queue_free()
