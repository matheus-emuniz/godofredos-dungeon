extends AnimatedSprite

export var goldSword: SpriteFrames
export var sword: SpriteFrames
export var torch: SpriteFrames

onready var game = get_parent()

onready var tipo = "player"
onready var index = "qualquer_merda"

onready var dano = 1
onready var resistencia = 100
onready var vida = 11



var hp: int

func _ready():
	self.frames = torch

func change_texture():
	pass
