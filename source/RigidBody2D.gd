extends RigidBody
var move = Vector3(0,0,0)
var planet
const gravity: float = 6.6743*pow(10,-1)
var gravity_force = Vector3(0,0,0)
const world1_mass: float = 2.303*pow(10, 7)
const world2_mass: float = 8.558*pow(10, 6)
const world3_mass: float = 5.895*pow(10,6)
const ball_mass: float = pow(2,1)#2
var planet_mass = world1_mass
var purse: int = 0
func _ready():
	planet = get_node("/root/Environment/planet")
	get_node("/root/Environment/transport/").translation = (get_node("/root/Environment/planet").translation+get_node("/root/Environment/world").translation)/2
	get_node("/root/Environment/transport/mesh").mesh.height = (get_node("/root/Environment/planet").translation-get_node("/root/Environment/world").translation).length()
	get_node("/root/Environment/transport/collision").shape.height = (get_node("/root/Environment/planet").translation-get_node("/root/Environment/world").translation).length()
	get_node("/root/Environment/transport/").look_at(get_node("/root/Environment/planet").global_transform.origin, Vector3(0,1,0))
	
	get_node("/root/Environment/transport2/").translation = (get_node("/root/Environment/planet").translation+get_node("/root/Environment/moon").translation)/2
	get_node("/root/Environment/transport2/mesh").mesh.height = (get_node("/root/Environment/planet").translation-get_node("/root/Environment/moon").translation).length()
	get_node("/root/Environment/transport2/collision").shape.height = (get_node("/root/Environment/planet").translation-get_node("/root/Environment/moon").translation).length()
	get_node("/root/Environment/transport2/").look_at(get_node("/root/Environment/planet").global_transform.origin, Vector3(0,1,0))
func _integrate_forces(state):
	var dt = state.get_step()
	gravity_force = gravity * (planet_mass*ball_mass) / pow(planet.translation.distance_to(translation),2) * (planet.translation-translation).normalized()
	var velocity = state.get_linear_velocity()
	get_node("/root/Environment/cambase").look_at(planet.global_transform.origin, Vector3(0,1,0))
	state.angular_velocity = (get_node("/root/Environment/cambase").transform.basis.x*move.x+get_node("/root/Environment/cambase").transform.basis.y*move.y+get_node("/root/Environment/cambase").transform.basis.z*move.z)*250*PI*dt
	if velocity.y > -100:
		state.add_central_force(gravity_force * dt)
	if Input.is_action_pressed("ui_select"):
		if get_colliding_bodies().size() != 0:
			add_central_force(-40000*(planet.translation-translation).normalized()*dt)
func _physics_process(_delta):
	$"/root/Environment/cambase".translation = translation - 10*(planet.translation-translation).normalized()
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

func purse():
	purse += 1
	get_node("/root/Environment/UI/RichTextLabel").set_bbcode("[img]purse.png[/img][font=font/font.res] " + str(purse) + "/10[/font]")

func _on_transport_body_entered(body):
	var id = get_node("/root/Environment/ball").get_instance_id()
	var type = get_node("/root/Environment/ball").get_class()
	if str(body) == "[" + type + ":" + str(id) + "]":
		if planet == get_node("/root/Environment/planet"):
			planet = get_node("/root/Environment/world")
			planet_mass = world2_mass
		else:
			planet = get_node("/root/Environment/planet")
			planet_mass = world1_mass
func _on_transport2_body_entered(body):
	var id = get_node("/root/Environment/ball").get_instance_id()
	var type = get_node("/root/Environment/ball").get_class()
	if str(body) == "[" + type + ":" + str(id) + "]":
		if planet == get_node("/root/Environment/planet"):
			planet = get_node("/root/Environment/moon")
			planet_mass = world3_mass
		else:
			planet = get_node("/root/Environment/planet")
			planet_mass = world1_mass


func _on_purse_body_entered(_body):
	purse()
	get_node("/root/Environment/purse").queue_free()

func _on_purse2_body_entered(_body):
	purse()
	get_node("/root/Environment/purse2").queue_free()


func _on_purse3_body_entered(_body):
	purse()
	get_node("/root/Environment/purse3").queue_free()


func _on_purse4_body_entered(_body):
	purse()
	get_node("/root/Environment/purse4").queue_free()


func _on_purse5_body_entered(_body):
	purse()
	get_node("/root/Environment/purse5").queue_free()


func _on_purse6_body_entered(_body):
	purse()
	get_node("/root/Environment/purse6").queue_free()


func _on_purse7_body_entered(_body):
	purse()
	get_node("/root/Environment/purse7").queue_free()


func _on_purse8_body_entered(body):
	purse()
	get_node("/root/Environment/purse8").queue_free()


func _on_purse9_body_entered(body):
	purse()
	get_node("/root/Environment/purse9").queue_free()


func _on_purse10_body_entered(body):
	purse()
	get_node("/root/Environment/purse10").queue_free()
