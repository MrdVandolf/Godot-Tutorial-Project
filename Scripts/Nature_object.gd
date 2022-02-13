extends StaticBody2D


func save():
	var data = {
		"filename": get_filename(),
		"position": position
	}
	
	return data


func load_from_data(data):
	position = data["position"]
