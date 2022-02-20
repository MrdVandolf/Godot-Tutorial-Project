extends Control


onready var border = $Border

var item_name = ""
var item_amount = 0
var properties = {}

var inventory = null
signal on_picked


func set_inventory(val):
	inventory = val


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


func remove_amount(am):
	item_amount -= am
	$Box/Amount.text = str(item_amount)
	if item_amount == 0:
		inventory.remove_item(self)


func pick():
	border.show()


func unpick():
	border.hide()


func use():
	var target = inventory.get_inv_owner()
	if "function" in properties.keys():
		
		match properties["function"]:
			"heal":
				target.increase_hp(properties["heal_val"])
				if properties["expandable"]:
					remove_amount(properties["exp_rate"])


func get_amount():
	return item_amount


func get_props():
	return properties


func can_stack():
	return properties["can_stack"]


func save():
	return [item_name, item_amount, properties] 


func _on_InventItem_gui_input(event):
	if event.is_action_pressed("left_click"):
		emit_signal("on_picked")
