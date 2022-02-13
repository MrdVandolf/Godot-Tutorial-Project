extends Control

var item_name = ""
var item_amount = 0
var properties = {}


func set_item(item_name, amount, props):
	self.item_name = item_name
	self.item_amount = amount
	self.properties = props.duplicate()
	$Box/Texture.texture = load("res://Sprites/Items/%s.png" % item_name)
	$Box/Amount.text = str(amount)


func get_item_name():
	return item_name


func add_amount(am):
	item_amount += am
	$Box/Amount.text = str(item_amount)


func get_amount():
	return item_amount


func get_props():
	return properties


func can_stack():
	return properties["can_stack"]


func save():
	return [item_name, item_amount, properties] 
