extends Node

var current_score = 0

export var last_score = 0
export var high_score = 0

func add_score(val):
	current_score += val
