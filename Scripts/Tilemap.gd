extends Node2D



func get_player():
	if has_node("Player"):
		return $Player
	else:
		return false


func update_label(value):
	get_parent().update_label(value)


func _ready():
	
	var items_to_spawn = ItemMachine.get_openworld_items()
	
	for i in range(100):
		randomize()
		var a = int(rand_range(0, len(items_to_spawn)))
		var new_item = ItemMachine.generate_item(items_to_spawn[a])
		add_item_to_world(new_item, int(rand_range(0, 32*58)), int(rand_range(0, 32*41)))
		
	add_to_group(GlobalVars.saving_group)
	SceneChanger.game_ready()


func add_item_to_world(item, x, y):
	$Items.add_child(item)
	item.position = Vector2(x, y)


func add_lying_item(i, x, y):
	var new_item = ItemMachine.generate_item(i.get_item_name(), i.get_amount())
	add_item_to_world(new_item, x, y)


func _unhandled_input(event):
	if event.is_action_pressed("Alt"):
		for i in get_tree().get_nodes_in_group(GlobalVars.entity_group):
			i.toggle_hp_bar()


func save():
	var data = {
		"filename": get_filename(),
		"player": $Player.save(),
		"items": [],
		"nature": [],
		"animals": []
	}
	
	for item in $Items.get_children():
		data["items"].append(item.save())
	
	for object in $Nature.get_children():
		data["nature"].append(object.save())
	
	for animal in $Animals.get_children():
		data["animals"].append(animal.save())
	
	return data


func load_from_data(data):
	
	for item in $Items.get_children():
		$Items.remove_child(item)
		item.queue_free()
	
	for obj in $Nature.get_children():
		$Nature.remove_child(obj)
		obj.queue_free()
	
	for anim in $Animals.get_children():
		$Animals.remove_child(anim)
		anim.queue_free()
	
	var p = $Player
	remove_child($Player)
	p.queue_free()
	
	var new_player = load(data["player"]["filename"]).instance()
	add_child(new_player)
	new_player.name = "Player"
	new_player.load_from_data(data["player"])
	
	for i in data["items"]:
		var item = load(i["filename"]).instance()
		$Items.add_child(item)
		item.load_from_data(i)
	
	for i in data["nature"]:
		var obj = load(i["filename"]).instance()
		$Nature.add_child(obj)
		obj.load_from_data(i)
	
	for i in data["animals"]:
		var anim = load(i["filename"]).instance()
		$Animals.add_child(anim)
		anim.load_from_data(i)
	
	
