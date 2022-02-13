extends Resource

export var save_name = "" setget set_name, get_save_name
export var data = {} setget set_data, get_data


func set_name(n):
	save_name = n


func get_save_name():
	return save_name


func set_data(d):
	data = d.duplicate(true)


func get_data():
	return data
