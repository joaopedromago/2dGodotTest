extends RigidBody2D

var speed = 200
var velocity = Vector2.ZERO
var has_double_jump = false


func _ready():
	pass


func _process(delta):
	var has_velocity_changes = false
	var current_velocity = self.get_linear_velocity()

	var new_x_velocity = velocity.x * speed
	if new_x_velocity != current_velocity.x:
		current_velocity.x = new_x_velocity
		has_velocity_changes = true

	if has_velocity_changes:
		self.set_linear_velocity(current_velocity)
	
	deathCheck()
		
func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_left"):
			velocity.x = -1
		elif event.is_action_pressed("ui_right"):
			velocity.x = 1
		elif event.is_action_pressed("ui_up"):
			jump()
		elif event.is_action_released("ui_left") or event.is_action_released("ui_right"):
			velocity.x = 0




func deathCheck():
	if ceil(self.global_position.y) >= 1000:
		get_tree().change_scene_to_file(Globals.menu_scene)


func jump():
	if is_touching_something():
		performJump()
		has_double_jump = true
	elif has_double_jump:
		performJump()
		has_double_jump = false


func performJump():
	var input_vector = Vector2.ZERO
	input_vector.y = -2
	var velocity = input_vector * speed
	self.linear_velocity = velocity
	self.set_linear_velocity(velocity)

func is_touching_something():
	return get_contact_count()
