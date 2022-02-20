extends Node

var items = {
	"apple": ["apple", 8, {"can_stack": true, "function": "heal", "heal_val": 10, "expandable": true, "exp_rate": 1}],
	"prut": ["prut", 8, {"can_stack": true}],
	"pebble": ["pebble", 8, {"can_stack": true}],
	"branch": ["branch", 4, {"can_stack": false}],
	"wolfskin": ["wolfskin", 1, {"can_stack": false}]
	}

onready var item = preload("res://Scenes/Item.tscn")
onready var inv_item = preload("res://Scenes/InventItem.tscn")


func has_item(item_name):
	return item_name in items.keys()


func generate_item(item_name, item_amount=1):
	if has_item(item_name):
		var new_item = item.instance()
		new_item.set_item(items[item_name])
		new_item.set_amount(item_amount)
		return new_item
	return null


func generate_inventory_item(item_name, item_amount=1):
	if has_item(item_name):
		var new_item = inv_item.instance()
		new_item.set_item(item_name, item_amount, items[item_name][2])
		return new_item
	return null


func get_item_properties(item_name):
	if has_item(item_name):
		return items[item_name]
	return []


func get_openworld_items():
	return ["apple", "prut", "pebble", "branch"]
