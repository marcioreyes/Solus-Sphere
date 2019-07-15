extends RigidBody
var move = Vector3(0,0,0)
func _ready():
	set_physics_process(true)
func _integrate_forces(state):
	var dt = state.get_step()
	var gravity = 9.8 * (get_node("/root/Environment/planet").translation-translation).normalized()
	var velocity = state.get_linear_velocity()
	get_node("/root/Environment/cambase").look_at(get_node("/root/Environment/planet").global_transform.origin, Vector3(0,1,0))
	state.angular_velocity = (get_node("/root/Environment/cambase").transform.basis.x*move.x+get_node("/root/Environment/cambase").transform.basis.y*move.y+get_node("/root/Environment/cambase").transform.basis.z*move.z)*250*PI*dt
	if velocity.y > -100:
		state.apply_central_impulse((gravity) * dt)

func _physics_process(_delta):
	$"/root/Environment/cambase".translation = translation - 10*(get_node("/root/Environment/planet").translation-translation).normalized()
	if Input.is_action_pressed("ui_up"):
		if move.x > -2:
			move.x -= 0.04
	elif Input.is_action_pressed("ui_down"):
		if move.x < 2:
			move.x += 0.04
	else:
		move.x = 0
	if Input.is_action_pressed("ui_right"):
		if move.y < 2:
			move.y += 0.04
	elif Input.is_action_pressed("ui_left"):
		if move.y > -2:
			move.y -= 0.04
	else:
		move.y = 0
	if Input.is_action_pressed("ui_select"):
		if get_colliding_bodies().size() != 0:
			apply_central_impulse(-5*(get_node("/root/Environment/planet").translation-translation).normalized())


func _on_purse_body_entered(_body):
	get_node("/root/Environment/purse").hide()
