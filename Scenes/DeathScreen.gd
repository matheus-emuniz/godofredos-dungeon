extends Control



func _on_Replay_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_Menu_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
