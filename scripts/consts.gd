
extends Node

const FACE_RIGHT = 0
const FACE_UP = 1
const FACE_LEFT = 2
const FACE_DOWN = 3

const UI_IDLE = "ui_idle"
const UI_BUILDING_SELECTED = "ui_building_selected"

const GROUP_ENEMY = 'enemy'

signal gold_gained
var gold = 0

func add_gold( gold ):
	self.gold += gold
	emit_signal("gold_gained", self.gold)