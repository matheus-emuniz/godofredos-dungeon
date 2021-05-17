extends Node2D

onready var Player = get_node("Player")

var can_move = []
onready var player_position: TouchScreenButton = get_node("Map/MapTile8")


func _ready():
	move_player(player_position)

func get_center(node: TouchScreenButton):
	return node.position + Vector2(
		(32 * player_position.scale.x) / 2,
		(32 * player_position.scale.x) / 2)

func move_player(node: TouchScreenButton):
	Player.position = get_center(node)
