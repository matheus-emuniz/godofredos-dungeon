extends TouchScreenButton

export var index: int = 0

onready var Game = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_MapTile_pressed():
	Game.move_player(self)
