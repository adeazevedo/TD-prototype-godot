extends Navigation2D

onready var spawner = get_node("spawner")
onready var start = get_node("start_pos")
onready var end = get_node("end_pos")

var spawn_plan = {} setget set_plan

var time_counter = 0
var times = []
var index = 0

func _ready():
	pass

func _process(delta):
	if index >= times.size():
		return

	if time_counter >= int(times[index]):
		var spawn = spawn_plan[index]
		spawn_enemies(spawn["enemies"])
		index += 1

	time_counter += delta

func set_plan( plan ):
	spawn_plan = plan
	times = []

	for i in spawn_plan:
		times.append(i["time"])

	time_counter = 0
	index = 0
	start()
	set_process(true)

func start():
	spawner.init(self, start.get_pos(), end.get_pos())

func spawn_next_wave():
	pass

func spawn_enemies(enemies):
	print("Spawning " + str(enemies.size()) + "enemy(ies)")
	for enemy in enemies:
		spawner.spawn_enemy(enemy)