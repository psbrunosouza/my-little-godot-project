extends PlayerModel

func _physics_process(delta):
	gravity(delta)
	
	idle()
	movement()
	wall_jump()
	jump()
	
	motion = move_and_slide(motion, Vector2.UP)
	
func gravity(delta):
	if(motion.y <= 0):
		motion.y += JUMP_GRAVITY * delta
	else:
		motion.y += FALL_GRAVITY * delta 
	
	if(!is_jumping && next_to_wall() && direction != 0):
		motion.y = WALL_ATTACHED_GRAVITY
		
func idle(): 
	if(is_on_floor()):
		is_jumping = false
		performed_jumps = 0
		animation_player_machine.travel("idle")
	
func movement(): 
	direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	if(direction != 0): 
		motion.x = lerp(motion.x, direction * MOVE_SPEED, 0.2)
		sprite.scale.x = direction;
		animation_player_machine.travel("run")
	else:
		motion.x = lerp(motion.x, 0, 0.3)
		
func wall_jump():
	if(
		Input.is_action_just_pressed("jump") 
		&& !is_on_floor() 
		&& wall_detector_right.is_colliding() 
		&& performed_jumps <= 2):
		motion.y = WALL_IMPULSE_HEIGHT
		motion.x = -WALL_IMPULSE_SPEED
		performed_jumps += 1
	elif(
		Input.is_action_just_pressed("jump") 
		&& !is_on_floor() 
		&& wall_detector_left.is_colliding() 
		&& performed_jumps <= 2):
		motion.y = WALL_IMPULSE_HEIGHT 
		motion.x = WALL_IMPULSE_SPEED
		performed_jumps += 1
		
func jump():
	if(Input.is_action_just_pressed("jump") && is_on_floor()):
		performed_jumps += 1;
		if(performed_jumps <= MAX_JUMP_QUANTITY):
			motion.y = JUMP_FORCE
			animation_player_machine.travel("jump")
			is_jumping = true
	elif(Input.is_action_just_pressed("jump") && !is_on_floor() && !next_to_wall()):
		performed_jumps += 1;
		if(performed_jumps <= MAX_JUMP_QUANTITY):
			motion.y = JUMP_FORCE
			animation_player_machine.travel("double_jump")
	elif(Input.is_action_just_released("jump") && motion.y < 0):
		motion.y = 0
	

