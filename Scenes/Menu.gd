extends Control

onready var stats = get_node("Stats")
onready var high_score_val: Label = get_node("HighScoreVal")
onready var last_score_val: Label = get_node("LastScoreVal")

func _ready():
	SimpleSave.load_scene_partial(stats, "stats.tscn")


func _process(delta):
	high_score_val.text = str(stats.high_score)
	last_score_val.text = str(stats.last_score)


func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_Exit_pressed():
	get_tree().quit()
