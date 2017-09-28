extends Area2D

var spd = 200
var angle = 0

func init(angle):
	self.angle = angle
	set_rot(angle)

func _ready():
	set_process(true)

func _process(delta):
	set_pos( get_global_pos() + Vector2(cos(angle), -sin(angle)) * delta * spd )


#Events
func _on_cannon_bullet_area_enter( area ):
	if area.is_in_group(consts.GROUP_ENEMY):
		area.apply_dmg(1)
		hide()
		queue_free()

func _on_VisibilityNotifier2D_exit_screen():
	queue_free()
