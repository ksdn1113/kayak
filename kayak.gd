extends RigidBody3D

# Export variables for key bindings using InputEventKey
@export var left_key: InputEventKey = InputEventKey.new()
@export var right_key: InputEventKey = InputEventKey.new()
@export var button_delay: float = 0.2  # Time to wait in seconds
@export var row_force: float = 10.0

var left_static_row: Node3D
var right_static_row: Node3D

var animation_player: AnimationPlayer

var timer_left: Timer
var timer_right: Timer
var is_left_pressed: bool = false
var is_right_pressed: bool = false
var timer_flag_left: bool = false  # Flag to track timer timeout for "left"
var timer_flag_right: bool = false  # Flag to track timer timeout for "right"
var is_animation_playing: bool = false  # Flag to track if an animation is playing

func _ready():
	# Set default keys if not assigned
	if left_key.keycode == 0:
		left_key.keycode = KEY_Q
	if right_key.keycode == 0:
		right_key.keycode = KEY_R
	
	# Get references to the StaticBody3D children
	left_static_row = get_node("Row1")
	right_static_row = get_node("Row2")
	
	
	# Initialize the Timer and add it as a child node
	timer_left = Timer.new()
	timer_left.wait_time = button_delay  # Set the timer to wait
	timer_left.one_shot = true  # Make sure the timer only runs once
	add_child(timer_left)
	# Connect the timer's timeout signal to a function
	timer_left.timeout.connect(Callable(self, "_on_timer_left_timeout"))
	
	# Initialize the Timer and add it as a child node
	timer_right = Timer.new()
	timer_right.wait_time = button_delay  # Set the timer to wait
	timer_right.one_shot = true  # Make sure the timer only runs once
	add_child(timer_right)
	# Connect the timer's timeout signal to a function
	timer_right.timeout.connect(Callable(self, "_on_timer_right_timeout"))
	
	
	# Get the AnimationPlayer node
	animation_player = $AnimationPlayer
	# Connect the animation finished signal to a function
	animation_player.connect("animation_finished", Callable(self, "_on_animation_finished"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if timer_flag_left:
		apply_force_from_node(left_static_row)
	if timer_flag_right:
		apply_force_from_node(right_static_row)

	if is_animation_playing:
		return  # Do nothing if an animation is currently playing
		
	# Check if the "q" key is being held down
	if Input.is_key_pressed(left_key.keycode):
		if not is_left_pressed and not is_right_pressed:
			# Start the timer if it's not already started
			timer_left.start()
			is_left_pressed = true
			animation_player.play("row1 down")
			is_animation_playing = true
	else:
		if is_left_pressed:
			# Stop and reset the timer if the "q" key is released
			timer_left.stop()
			is_left_pressed = false
			animation_player.play("row1 up")
			is_animation_playing = true

	# Check if the "r" key is being held down
	if Input.is_key_pressed(right_key.keycode):
		if not is_right_pressed and not is_left_pressed:
			# Start the timer if it's not already started
			timer_right.start()
			is_right_pressed = true
			animation_player.play("row2 down")
			is_animation_playing = true
	else:
		if is_right_pressed:
			# Stop and reset the timer if the "q" key is released
			timer_right.stop()
			is_right_pressed = false
			animation_player.play("row2 up")
			is_animation_playing = true

func _on_timer_left_timeout():
	# Perform the desired action here
	
	# Set the flag to true when the timer times out
	timer_flag_left = true

func _on_timer_right_timeout():
	# Perform the desired action here
	
	# Set the flag to true when the timer times out
	timer_flag_right = true

func apply_force_from_node(node: Node3D):
	# Calculate the force vector (backward direction)
	var force_vector = -global_transform.basis.z * row_force
	# Get the point of application from the StaticBody3D
	var point_of_application = node.global_transform.origin
	# Apply the force to the RigidBody3D
	apply_force(force_vector, point_of_application)


func _on_animation_finished(anim_name):
	# Reset the flag when the animation finishes
	if anim_name in ["row1 down", "row1 up", "row2 down", "row2 up"]:
		is_animation_playing = false
