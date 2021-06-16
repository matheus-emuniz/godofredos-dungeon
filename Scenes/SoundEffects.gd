extends AudioStreamPlayer

onready var death = load("res://Sounds/death.ogg")
onready var pickup = load("res://Sounds/pickup.ogg")
onready var battle = load("res://Sounds/battle")

func play_death():
	self.stream = death
	self.play()

func play_pickup():
	self.stream = pickup
	self.play()

func play_battle():
	self.stream = battle
	self.play()
