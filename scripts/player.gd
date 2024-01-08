extends RigidBody2D

var speed = 200
var velocity = Vector2.ZERO
var isGrounded = false
var hasDoubleJump = false

func _ready():
	pass

func _process(delta):
	var hasVelocityChanges = false
	var current_velocity = self.get_linear_velocity()
	
	var newXVelocity = velocity.x * speed	
	if newXVelocity != current_velocity.x:
		current_velocity.x = newXVelocity
		hasVelocityChanges = true
		
	if hasVelocityChanges:
		self.set_linear_velocity(current_velocity)
	
	deathTest()

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
	
func _physics_process(delta):
	var collisionObject = move_and_collide(velocity * speed * delta)
	if collisionObject and collisionObject.get_collider().name:
		isGrounded = true
		
func deathTest():
	if ceil(self.global_position.y) >= 1000:
		var menuScene = "res://scenes/menu.tscn"
		get_tree().change_scene_to_file(menuScene)

func jump():
	if isGrounded:
		performJump()
		isGrounded = false
		hasDoubleJump = true
	elif hasDoubleJump:
		performJump()
		hasDoubleJump = false
	
func performJump():
	var input_vector = Vector2.ZERO
	input_vector.y = -2;
	var velocity = input_vector * speed
	self.linear_velocity = velocity
	self.set_linear_velocity(velocity)
