extends KinematicBody2D

var default_speed = 50
var default_max_speed = 340
var Velocity = Vector2()
var deceleration = 25
var default_jump_power = 1000
var jump_upgrade_number = 0
var speed_ratio = .5
var speed_upgrade_number = 0
var jump_ratio = 0
var coin_upgrade_number = 0
var coins = 0
var coin_multiplier = 1
var timer_upgrade_ratio = 1
var timer_upgrade_number = 0
var snap = false
var hp_upgrade_number = 3
var hp = 3
var heart_array = ["CanvasLayer/Hearts/Heart1","CanvasLayer/Hearts/Heart2","CanvasLayer/Hearts/Heart3","CanvasLayer/Hearts/Heart4","CanvasLayer/Hearts/Heart5"]
var is_jumping = false
var Upgrade_Screen_Scene = load("res://Scenes/UpgradeScreen.tscn")
var awards = 0
var on_floor

#processes movement on every frame
# warning-ignore:unused_argument
func _process(delta):
	print($RayCast2D.get_collider(),$RayCast2D2.get_collider(),$RayCast2D3.get_collider())
	if $RayCast2D.get_collider() is KinematicBody2D or $RayCast2D.get_collider() is TileMap:
		on_floor = true
		Velocity.y = 0
	elif $RayCast2D2.get_collider() is KinematicBody2D or $RayCast2D2.get_collider() is TileMap:
		on_floor = true
		Velocity.y = 0
	elif $RayCast2D3.get_collider() is KinematicBody2D or $RayCast2D3.get_collider() is TileMap:
		on_floor = true
		Velocity.y = 0
	else:
		on_floor = false
	print(on_floor)
	
	if Input.is_action_just_pressed("ui_end"):
		coins += 9999999
	var speed = default_speed * speed_ratio
	var max_speed = default_max_speed * speed_ratio
	var jump_power = default_jump_power * jump_ratio
	
	if is_on_ceiling():
		Velocity.y = 0
		
	if !is_on_floor():
		Velocity.y += 45
	else:
		Velocity.y = 45
	
	if Input.is_action_pressed("down"):
		self.set_collision_layer_bit(1, false)
	else:
		self.set_collision_layer_bit(1, true)
		
	#checks if not moving left or right and velocity is less than deceleration amount, then decelerate
	if !(Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")) and abs(Velocity.x) >= deceleration:
		if Velocity.x > 0: #if moving right reduce speed towards right
			Velocity.x -= deceleration
		elif Velocity.x < 0: #if moving left reduce speed towards left
			Velocity.x += deceleration
	
	if Input.is_action_pressed("move_left") and Velocity.x > deceleration:
		Velocity.x -= speed
	if Input.is_action_pressed("move_right") and Velocity.x < -deceleration:
		Velocity.x += speed
		
	#if abs(velocity.x) is less than decel amnt and greater than 0 then stop
	if !(Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")) and abs(Velocity.x) < deceleration: 
		Velocity.x = 0
	
	if Input.is_action_pressed("move_right"): #accelerate the player to the right
		$AnimationPlayer.play("Run", -1, speed_ratio - .1)
		$PlayerSprite.flip_h = false
		Velocity.x += speed
	if Input.is_action_pressed("move_left"): #accelerate the player to the left
		$AnimationPlayer.play("Run", -1, speed_ratio - .1)
		$PlayerSprite.flip_h = true
		Velocity.x -= speed
	
	if Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"):
		Velocity.x = 0
	
	if Velocity.x == 0:
		$AnimationPlayer.play("Idle")
	
	
	if Velocity.x > max_speed: #if exceeding the max speed of the player reduce to max speed
		Velocity.x = max_speed
	elif Velocity.x < -max_speed:
		Velocity.x = -max_speed
	
	if Input.is_action_just_pressed("jump") and jump_upgrade_number != 0 and is_on_floor():
		$JumpSound.play()
		Velocity.y = -jump_power
	
	if snap:
		self.move_and_slide_with_snap(Velocity, Vector2(0,-1))
	else:
		self.move_and_slide(Velocity, Vector2(0,-1))

func set_health_vis():
	for i in hp:
		get_node(heart_array[i]).visible = true

func damage():
	print("ow")
	if hp > 1 and $InvincibilityTimer.is_stopped():
		$Hurt.play()
		hp -= 1
		get_node(heart_array[hp-1]).hide()
		$InvincibilityTimer.start()
		$DamageBlinkTimer.start()
	elif hp == 1:
		get_parent().call_deferred("player_death")

func _on_Timer_timeout():
	get_parent().call_deferred("player_death")

func _on_PlatDetector_body_exited(body):
	if body is KinematicBody2D and body.name != "Player":
		snap = false
	if body is TileMap:
		is_jumping = true

func _on_PlatDetector_body_entered(body):
	print(body.name)
	if body is KinematicBody2D and body.name != "Player":
		snap = true
	if body is TileMap:
		is_jumping = false


func _on_DamageBlinkTimer_timeout():
	$PlayerSprite.visible = !$PlayerSprite.visible
	
func _on_InvincibilityTimer_timeout():
	$DamageBlinkTimer.stop()
	$PlayerSprite.visible = true


func _on_Respawn_Button_button_up():
	get_parent().call_deferred("player_death")
