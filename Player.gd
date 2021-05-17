extends AnimatedSprite

export var goldSword: SpriteFrames
export var sword: SpriteFrames
export var torch: SpriteFrames

onready var game = get_parent()



var hp: int

func _ready():
	self.frames = torch

func change_texture():
	pass
