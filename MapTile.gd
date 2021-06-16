extends TouchScreenButton

export var index: int = 0
var tipo = "vazio"
var info = {
	'cura': 0,
	'resistencia_espada': 0,
	'dano_espada': 0,
	'vida_monstro': 0,
	'dano_monstro': 0,
	'xp_monstro': 0,
}

onready var Game = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_MapTile_pressed():
	Game.move_player(self)
