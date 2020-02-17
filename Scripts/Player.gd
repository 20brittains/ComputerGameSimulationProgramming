extends KinematicBody2D

var default_speed = 50
var default_max_speed = 340
var Velocity = Vector2()
var deceleration = 25
var default_jump_power = 1000
var speed_ratio = 1
var jump_ratio = 0

var Upgrade_Screen_Scene = load("res://Scenes/UpgradeScreen.tscn")

#processes movement on every frame
func _process(delta):
	var speed = default_speed * speed_ratio
	var max_speed = default_max_speed * speed_ratio
	var jump_power = default_jump_power * jump_ratio
	
	Velocity.y += 45
	
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
		$PlayerSprite.flip_h = false
		Velocity.x += speed
	if Input.is_action_pressed("move_left"): #accelerate the player to the left
		$PlayerSprite.flip_h = true
		Velocity.x -= speed
	
	if Velocity.x > max_speed: #if exceeding the max speed of the player reduce to max speed
		Velocity.x = max_speed
	elif Velocity.x < -max_speed:
		Velocity.x = -max_speed
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		print("Jump")
		Velocity.y = -jump_power
	
	self.move_and_slide(Velocity, Vector2(0,-1))
	
	if Input.is_action_just_pressed("upgrade_menu") and !has_node("CanvasLayer/UpgradeScreen"):
		var up = Upgrade_Screen_Scene.instance()
		up.name = "UpgradeScreen"
		get_node("CanvasLayer").add_child(up)
	elif Input.is_action_just_pressed("upgrade_menu") and has_node("CanvasLayer/UpgradeScreen"):
		get_node("CanvasLayer/UpgradeScreen").queue_free()
	
