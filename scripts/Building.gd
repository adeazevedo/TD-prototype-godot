extends Area2D

var target = null
var sight_radius = 200 setget set_sight_radius, get_sight_radius
var enemies_in_sight = []

func _ready():
	pass

####################################
# Targeting functions
####################################

# Mark a object as a target
func target_enemy( target ):
	if is_in_sight(target):
		self.target = target
		if !target.is_connected("on_die", self, "on_target_die"):
			target.connect("on_die", self, "on_target_die", [target], CONNECT_ONESHOT )


func on_target_die( enemy ):
	remove_in_sight_enemy( enemy )
	# If target is out of sight, clear it
	if self.target == enemy:
		clear_target()


func has_target():
	return self.target != null and is_in_sight(self.target)


# Get a angle between cannon and the target
func angle_to_target():
	if has_target():
		var target_pos = self.target.get_global_pos()
		var pos_node = self.get_global_pos()

		return pos_node.angle_to_point(target_pos) + PI/2


# Makes cannon follow current target
func follow_target():
	if has_target():
		var angle = angle_to_target()
		set_rot(angle)


func get_next_enemy():
	if is_sight_empty():
		return enemies_in_sight.front()

	return null


# Clear current target
func clear_target():
	self.target = null

############################################
func add_in_sight_enemy( enemy ):
	enemies_in_sight.push_back(enemy)

func remove_in_sight_enemy( enemy ):
	return enemies_in_sight.erase( enemy )

func is_in_sight( obj ):
	return enemies_in_sight.has(obj)

func is_sight_empty():
	return !enemies_in_sight.empty()

######################################
func get_sight_radius():
	return sight_radius

func set_sight_radius( radius ):
	sight_radius = radius
