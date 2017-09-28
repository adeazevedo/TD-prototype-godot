
extends Area2D

var ROOT = null
var preload_cannon = preload("res://scenes/cannon.tscn")
var occupied = false

func _ready():
	ROOT = get_node("/root/main")

func create_cannon():
	var cannon = preload_cannon.instance()
	cannon.set_pos(Vector2(0, 0))
	return cannon

func occupied():
	return occupied


func mouse_clicked(event):
	return event.is_action_pressed("left_click")


func _on_platform_input_event( viewport, event, shape_idx ):
	if ROOT.is_ui_state(consts.UI_BUILDING_SELECTED):
		if mouse_clicked(event) and !occupied():
			var cannon = create_cannon()
			add_child(cannon)
			occupied = true

			ROOT.change_ui_state(consts.UI_IDLE)
