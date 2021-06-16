extends Label

onready var Player = get_parent().get_parent().get_node("Player")

func _process(delta):
	self.text = str(Player.vida)
