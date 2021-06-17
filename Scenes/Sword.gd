extends AnimatedSprite

onready var sword_val = get_parent().get_node("SwordVal")
onready var Player = get_parent().get_parent().get_node("Player")

onready var gold_sword = load("res://Sprites/espada_dourada.tres")
onready var sword = load("res://Sprites/espada.tres")

func _ready():
	print(sword_val)


func _process(delta):
	set_val(Player.dano, Player.resistencia)

func set_val(dano, res):
	if dano > 1:
		sword_val.show()
		self.show()
		sword_val.text = "%s / %s" % [str(dano), str(res)]
		if dano == 4:
			self.frames = gold_sword
		else:
			self.frames = sword
	else:
		sword_val.hide()
		self.hide()
