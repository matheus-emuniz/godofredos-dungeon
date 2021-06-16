extends Label

onready var stats = get_parent().get_parent().get_node("Stats")

func _process(delta):
	self.text = str(stats.current_score)
