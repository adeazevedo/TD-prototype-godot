extends Node

func _ready():
	pass

static func read( path ):
	var file = File.new()
	file.open(path, file.READ)
	var text = file.get_as_text()
	var dict = {}
	dict.parse_json(text)
	file.close()

	return dict

static func get_level1():
	return read("res://scripts/level1.json")["waves"]