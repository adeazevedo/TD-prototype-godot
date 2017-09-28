
extends "res://scripts/Building.gd"

var StateMachine = load("res://scripts/StateMachine.gd")
var preload_bullet = preload("res://scenes/cannon_bullet.tscn")

var fire_cd = 1
var fire_delay = 0	#segundos

enum State {
	IDLE, ATTACK
}
var machine = null

func _ready():
	set_process(true)
	set_rot(PI/2)

	machine = StateMachine.new(self)
	machine.add(State.IDLE, "idle_state")
	machine.add(State.ATTACK, "attack_state")
	machine.initial(State.IDLE)


func _process(delta):
	machine.execute_next()


func idle_state():
	var next_target = get_next_enemy()

	if next_target != null:
		target_enemy(next_target)
		machine.change_to(State.ATTACK)


func attack_state():
	if !has_target():
		machine.change_to(State.IDLE)
		return

	follow_target()

	if fire_delay > fire_cd:
		fire()
		fire_delay = 0

	fire_delay += get_process_delta_time()

# Instantiate a new bullet object
func create_bullet():
	var bullet = preload_bullet.instance()
	bullet.init(angle_to_target())
	bullet.set_global_pos(get_node("pos").get_global_pos())

	return bullet

# fire a bullet form the cannon
func fire():
	var bullet = create_bullet()
	get_node("/root/main").add_child(bullet)


#######################################
# Events
#######################################
func _on_cannon_area_enter( obj ):
	if obj.is_in_group(consts.GROUP_ENEMY):
		add_in_sight_enemy(obj)


func _on_cannon_area_exit( obj ):
	remove_in_sight_enemy( obj )
	# If target is out of sight, clear it
	if self.target == obj:
		clear_target()

