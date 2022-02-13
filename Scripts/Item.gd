extends Node2D

onready var pre_inv = preload("res://Scenes/InventItem.tscn")

var properties = {}
var item = ""
var amount = 1
var stack_limit = 8

func set_item(props):
	$Sprite.texture = load("res://Sprites/Items/%s.png" % props[0])
	item = props[0]
	stack_limit = props[1]
	self.properties = props[2]

func _ready():
	pass

func get_item():
	return item

func get_amount():
	return amount

func set_amount(am):
	amount = am

func get_item_stack():
	return stack_limit


func _input(event):
	if event.is_action_pressed("e_click"):
		var pl = get_parent().get_parent().get_player()
		if abs(pl.position.x - position.x) < 64 and abs(pl.position.y - position.y) < 64:
			var new_item = pre_inv.instance()
			new_item.set_item(item, amount, properties)
			var is_picked = pl.pick(new_item)
			if is_picked:
				get_parent().remove_child(self)
				queue_free()
			else:
				new_item.queue_free()
			


func save():
	var data = {
		"filename": get_filename(),
		"position": position,
		"item": item,
		"amount": amount,
		"stack_limit": stack_limit,
		"properties": properties
	}
	
	return data


func load_from_data(data):
	position = data["position"]
	set_item([data["item"], data["stack_limit"], data["properties"]])
	amount = data["amount"]



