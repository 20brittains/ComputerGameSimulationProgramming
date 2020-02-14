extends KinematicBody2D

var speed = 50
var max_speed = 340
var Velocity = Vector2()
var deceleration = 25

#processes mmovement on every frame
func _process(delta):
	Velocity.y += 45
	
	print(is_on_floor())
	#checks if not moving left or right and velocity is less than deceleration amount, then decelerate
	if !(Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")) and abs(Velocity.x) >= deceleration:
		if Velocity.x > 0: #if moving right reduce speed towards right
			Velocity.x -= deceleration
		elif Velocity.x < 0: #if moving left reduce speed towards left
			Velocity.x += deceleration
	
	if Input.is_action_pressed("ui_left") and Velocity.x > deceleration:
		Velocity.x -= speed
	if Input.is_action_pressed("ui_right") and Velocity.x < -deceleration:
		Velocity.x += speed
		
	#if abs(velocity.x) is less than decel amnt and greater than 0 then stop
	if !(Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")) and abs(Velocity.x) < deceleration: 
		Velocity.x = 0
	
	if Input.is_action_pressed("ui_right"): #accelerate the player to the right
		$PlayerSprite.flip_h = false
		Velocity.x += speed
	if Input.is_action_pressed("ui_left"): #accelerate the player to the left
		$PlayerSprite.flip_h = true
		Velocity.x -= speed
	
	if Velocity.x > max_speed: #if exceeding the max speed of the player reduce to max speed
		Velocity.x = max_speed
	elif Velocity.x < -max_speed:
		Velocity.x = -max_speed
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		print("Jump")
		Velocity.y = -1000
	
	self.move_and_slide(Velocity, Vector2(0,-1))
	
