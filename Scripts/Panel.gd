extends NinePatchRect

onready var item = preload("res://Scenes/InventItem.tscn")
onready var container = $Scroll/Grid

func _ready():
	clear()
	visible = false

func clear():
	for i in container.get_children():
		container.remove_child(i)


func show_inventory(inventory):
	clear()
	for i in inventory:
		container.add_child(i)
