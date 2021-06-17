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

onready var hp = get_node("Control/HP")
onready var hp_val = get_node("Control/HPVal")
onready var dmg_val = get_node("Control/DmgVal")
onready var sword = get_node("Control/Sword")

onready var Game = get_parent().get_parent()

func _process(delta):
	if tipo in ["esqueleto", "slime", "zumbi"] and index in Game.area_player:
		hp.show()
		hp_val.show()
		dmg_val.show()
		sword.show()
		dmg_val.text = str(info.monstro_dano)
		hp_val.text = str(info.monstro_vida)
	else:
		dmg_val.hide()
		sword.hide()
		hp.hide()
		hp_val.hide()

func _on_MapTile_pressed():
	Game.move_player(self)
