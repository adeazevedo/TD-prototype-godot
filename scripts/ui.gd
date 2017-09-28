
extends Control

var StateMachine = preload("res://scripts/StateMachine.gd")
var machine = null

var ui_thumb = preload("res://scenes/ui_thumb.tscn").instance()
onready var main = get_parent()


var building_selected = null

func _ready():
	machine = StateMachine.new(self)
	machine.add(consts.UI_IDLE, "idle_state")
	machine.add(consts.UI_BUILDING_SELECTED, "building_selected_state")

	machine.initial(consts.UI_IDLE)

	set_fixed_process(true)


func _fixed_process(delta):
	execute_next_state()


func change_state( state, args = [] ):
	machine.change_to(state, args)

func get_current_state():
	return machine.get_current()

func execute_next_state():
	machine.execute_next()

func reset_state():
	change_state(consts.UI_IDLE)

func idle_state():
	building_selected = null
	if ui_thumb.is_inside_tree():
		ui_thumb.hide()
		main.remove_child(ui_thumb)
		ui_thumb.reset()

func building_selected_state( building_selected ):
	if !ui_thumb.is_occupied():
		if building_selected[0] == "cannon":
			ui_thumb.set_cannon_tex()
			self.building_selected = building_selected[0]

		main.add_child(ui_thumb)
		ui_thumb.show()

	main.selected = main.get_node("map").world_to_map(main.get_global_mouse_pos())
	ui_thumb.set_global_pos(get_global_mouse_pos())


func _on_make_cannon_bt_pressed():
	change_state(consts.UI_BUILDING_SELECTED, ["cannon"])

func _on_start_wave_bt_pressed():
	main.start_spawn()
