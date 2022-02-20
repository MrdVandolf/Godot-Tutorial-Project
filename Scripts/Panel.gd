extends NinePatchRect

onready var item = preload("res://Scenes/InventItem.tscn")
onready var container = $Box/Scroll/Grid
onready var item_buttons = {"drop": $Box/Buttons/Drop, "use": $Box/Buttons/Use}

onready var picked_item = null
onready var inventory_owner = null

func _ready():
	clear()
	visible = false
	for i in item_buttons.keys():
		item_buttons[i].connect("pressed", self, "interact", [i])

func clear():
	if picked_item:
		unpick()
	else:
		for i in item_buttons.values():
			i.hide()
	
	for i in container.get_children():
		container.remove_child(i)


func show_inventory(inventory):
	clear()
	inventory_owner = inventory.get_inv_owner()
	for i in inventory.get_items():
		container.add_child(i)
		if not i.is_connected("on_picked", self, "pick"):
			i.connect("on_picked", self, "pick", [i])


func pick(item):
	if picked_item:
		unpick()
	picked_item = item
	item.pick()
	
	for i in item_buttons.values():
		i.show()

func unpick():
	picked_item.unpick()
	picked_item = null
	
	for i in item_buttons.values():
		i.hide()


func interact(act):
	match act:
		"drop":
			var link = picked_item
			unpick()
			inventory_owner.drop_item(link)
		"use":
			picked_item.use()
