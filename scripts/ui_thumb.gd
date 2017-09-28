extends Area2D

var cannon_tex = preload("res://sprites/PNG/Default size/towerDefense_tile249.png")
var occupied = false

func _ready():
	reset()
	set_process(true)

func is_occupied():
	return occupied

func set_cannon_tex():
	set_texture(cannon_tex)

func set_texture(tex):
	get_node("sprite").set_texture(tex)

	if tex == null:
		occupied = false
	else:
		occupied = true

func reset():
	set_texture(null)