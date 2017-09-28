
extends Node2D

var json = preload("res://scripts/ReadJSON.gd")
onready var ui = get_node("ui")
onready var path1 = get_node("path")
onready var path2 = get_node("path2")
onready var path3 = get_node("path3")
onready var map = get_node("map")

var RED =  Color(1, 0.3, 0.3, 0.5)
var GREEN =  Color(0.3, 1, 0.3, 0.5)

var wave = null
var selected = null

var gold = 0

func _ready():
	wave = json.get_level1()
	set_process_input(true)
	set_fixed_process(true)

func _fixed_process(delta):
	update()

func _draw():
	if selected != null:
		var to_map = map.map_to_world(selected)

		var color = RED if not map.is_cell_empty(selected) else GREEN

		draw_rect(Rect2(to_map, map.get_cell_size()), color)


func _input( event ):
	if Input.is_action_pressed("left_click"):
		if is_ui_state(consts.UI_BUILDING_SELECTED):
			if map.is_cell_empty(map.get_mouse_hover_cell()):
				create_building()
				map.set_cell_type(map.get_mouse_hover_cell(), map.FILL)
				change_ui_state(consts.UI_IDLE)

	elif Input.is_action_pressed("right_click"):
		selected = null
		if is_ui_state(consts.UI_BUILDING_SELECTED):
			ui.reset_state()

func change_ui_state(state, args = []):
	ui.change_state(state, args)

func is_ui_state(state):
	return ui.get_current_state() == state

func start_spawn():
	print("Starting wave")
	path1.spawn_plan = wave[0]["path1"]
	path2.spawn_plan = wave[0]["path2"]
	path3.spawn_plan = wave[0]["path3"]

func create_building():
	var building = ui.building_selected
	var inst = null
	if building == 'cannon':
		inst = load("res://scenes/cannon.tscn").instance()
		inst.set_global_pos( map.map_to_world(map.get_mouse_hover_cell()) + map.get_cell_size()/2 - Vector2(0, -10) )

	add_child(inst)


