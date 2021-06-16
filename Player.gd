extends AnimatedSprite

export var gold_sword: SpriteFrames
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

func change_texture(texture):
	match texture:
		"sword":
			self.frames = sword
		"gold_sword":
			self.frames = gold_sword
		"torch":
			self.frames = torch
