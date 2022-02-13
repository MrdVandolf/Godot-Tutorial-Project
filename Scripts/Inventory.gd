extends Control


onready var items = []


func add_item(item):
	var added = false
	
	if item.can_stack():
		for i in items:
			if i.get_item_name() == item.get_item_name():
				i.add_amount(item.get_amount())
				added = true
				item.queue_free()
				break
				
	if not item.can_stack() or not added:
		items.append(item)



func get_items():
	return items


func get_saves():
	var saves = []
	for i in items:
		saves.append(i.save())
	return saves
