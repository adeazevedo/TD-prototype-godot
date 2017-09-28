extends Node2D

var preload_enemy = preload("res://scenes/simple_enemy.tscn")
var spawn_cd = 4 #seconds
var spawn_time = 0

var nav
var start
var end

func _ready():
	randomize()

func _process(delta):
	if spawn_time >= spawn_cd:
		# Spawn enemies code here
		spawn_enemy('')
		reset_spawn_time()

	update_spawn_time(delta)

func init(nav, start, end):
	self.nav = nav
	self.start = start
	self.end = end


func spawn_enemy(_enemy):
	var enemy = preload_enemy.instance()
	var offset = Vector2(0, 0)

	if _enemy.has("x_offset") and _enemy.has("y_offset"):
		offset = Vector2(_enemy["x_offset"], _enemy["y_offset"])

	enemy.init(nav, start + offset, end)

	get_parent().add_child(enemy)

func update_spawn_time(delta):
	spawn_time += delta

func reset_spawn_time():
	spawn_time = 0