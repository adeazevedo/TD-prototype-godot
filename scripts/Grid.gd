extends TileMap

var grid = []
var cell_size = get_cell_size()
var size = Vector2(10, 8)

const TILE_PATH = 8
const TILE_GRASS = 10
enum Cell_type {EMPTY, FILL, PATH}


func _ready():
	for x in range(size.x):
		grid.append([])
		for y in range(size.y):
			grid[x].append(EMPTY)
			grid[x][y] = PATH if get_cellv(Vector2(x, y)) == TILE_PATH else EMPTY

func set_cell_type(pos, type):
	if pos.x >= 0 and pos.x < size.x:
		if pos.y >= 0 and pos.y < size.y:
			grid[pos.x][pos.y] = type

func is_cell_empty(pos):
	if pos.x - size.x < 0 and pos.y - size.y < 0 :
		return grid[pos.x][pos.y] == EMPTY

	return false

func get_mouse_hover_cell():
	return world_to_map(get_global_mouse_pos())