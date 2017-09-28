extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	consts.connect("gold_gained", self, "update_gold")

func update_gold(gold):
	set_text("Gold: " + str(gold))
