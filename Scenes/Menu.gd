extends Control

onready var stats = get_node("Stats")
onready var high_score_val: Label = get_node("HighScoreVal")
onready var last_score_val: Label = get_node("LastScoreVal")

func _ready():
	stats.current_score = 0
	print("6 em baixo ? lul")
	var kkj = ResourceLoader.load('res://Suamae/stats.tscn').instance()
	print("Agora vai")
	print(kkj.last_score)
	print(kkj.high_score)
	print("Agora vai")
	stats.last_score = kkj.last_score
	stats.high_score = kkj.high_score
	print(stats.last_score)
	print(stats.last_score)
	
	#SimpleSave.load_scene_partial(stats, "stats.tscn")


func _process(delta):
	high_score_val.text = str(stats.high_score)
	last_score_val.text = str(stats.last_score)


func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_Exit_pressed():
	get_tree().quit()
