extends Node2D

func update_label(value):
	get_node("UI/Control/Counter").text = "Items: %s" % str(value)

func _ready():
	connect_player_to_death()


func connect_player_to_death():
	var pl = $Outdoor.get_player()
	pl.connect("on_death", $UI/Control, "set_death_screen", [])
