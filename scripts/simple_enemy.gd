extends Node2D

onready var visibility_notifier = get_node("visibility")

var nav = null setget set_nav
var goal = null
var path = []

var hp = 3
var spd = 25

signal on_die

func _ready():
	add_to_group(consts.GROUP_ENEMY)
	set_fixed_process(true)

func _fixed_process(delta):
	if path.size() > 0:
		var g_pos = get_global_pos()
		var d = g_pos.distance_to(path[0])
		if d >= 3:
			var pos = g_pos.linear_interpolate(path[0], spd * delta / d)
			var delta_x = pos.x - g_pos.x
			var delta_y = pos.y - g_pos.y

			if abs(delta_x) >= abs(delta_y):
				pos = Vector2(pos.x, g_pos.y + delta_y)

			else:
				pos = Vector2(g_pos.x + delta_x, pos.y)

			set_global_pos(pos)
			var angle = int(rad2deg(pos.angle_to_point(path[0])))
			set_rotd(angle + 90)

		else:
			path.remove(0)

func init(nav, start, goal):
	set_pos(start)
	self.goal = goal
	set_nav(nav)

func set_nav(n):
	nav = n
	update_path()

func update_path():
	path = nav.get_simple_path(get_global_pos(), goal, true)
	if path.size() == 0:
		free_node()

func apply_dmg( dmg ):
	hp -= dmg
	play_anim('hit')

	if hp <= 0:
		die()

func play_anim( name ):
	get_node("anim").play(name)

func die():
	remove_child(get_node("collision"))
	emit_signal("on_die")
	play_anim("die")

	consts.add_gold(1)

func free_node():
	set_process(false)
	queue_free()
