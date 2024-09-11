extends Camera3D

# Export variables to set the target objects and follow parameters from the inspector
@export var targets: Array[Node3D] = []
@export var follow_speed: float = 5.0  # Speed at which the camera follows the targets
@export var offset: Vector3 = Vector3(-10, 7, 0)  # Offset from the centroid

func _process(delta):
	if targets.size() == 0:
		return  # Do nothing if there are no targets

	# Calculate the centroid of the target objects
	var centroid = Vector3.ZERO
	for target in targets:
		centroid += target.global_transform.origin
	centroid /= targets.size()

	# Calculate the desired position with offset
	var desired_position = centroid + offset
	# Move towards the desired position
	global_transform.origin = global_transform.origin.lerp(desired_position, follow_speed * delta)
	# Make the camera look at the centroid
	look_at(centroid, Vector3.UP)
