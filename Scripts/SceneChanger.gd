extends CanvasLayer

onready var game_path = "res://Scenes/Root.tscn"

signal on_game_ready


func change_scene(path):
	get_tree().change_scene(path)
	get_tree().paused = false


func load_game(data):
	change_scene(game_path)
	yield(self, "on_game_ready")
	var able_to_load = get_tree().get_nodes_in_group(GlobalVars.saving_group)
	able_to_load[0].load_from_data(data)


func game_ready():
	emit_signal("on_game_ready")
