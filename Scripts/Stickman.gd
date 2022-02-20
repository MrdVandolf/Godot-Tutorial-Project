extends KinematicBody2D

onready var pre_inv = preload("res://Scenes/Inventory.tscn")
onready var pre_item = preload("res://Scenes/InventItem.tscn")

onready var ui = get_viewport().get_node("Root/UI/Control") # ссылка на интрефейс
onready var world = get_viewport().get_node("Root/Outdoor")

var speed = 200
var inventory

onready var hp = 50
export var max_hp = 100

func _ready():
	set_start_hp(hp, max_hp)
	create_inventory()


func create_inventory():
	inventory = pre_inv.instance()
	add_child(inventory)
	inventory.set_inv_owner(self)


func pick(item):
	self.inventory.add_item(item)
	return true


func set_start_hp(hp, max_hp):
	$HP_bar.value = hp
	$HP_bar.max_value = max_hp

func update_hp():
	$HP_bar.value = hp

func toggle_hp_bar():
	$HP_bar.visible = !$HP_bar.visible

func die():
	randomize()
	for i in inventory.get_items():
		var x_coord = rand_range(-1, 1) * 10 + self.position.x
		var y_coord = rand_range(-1, 1) * 10 + self.position.y
		world.add_lying_item(i, x_coord, y_coord)
	get_parent().remove_child(self)
	queue_free()

func reduce_hp(val):
	self.hp -= val
	update_hp()
	if self.hp <= 0:
		die()
		return false
	return true


func increase_hp(val):
	self.hp = min(self.hp + val, self.max_hp)
	update_hp()


func save():
	var data = {
		"filename": get_filename(),
		"position": position,
		"speed": speed,
		"hp": hp,
		"max_hp": max_hp,
		"inventory": self.inventory.get_saves()
	}
	
	return data


func load_from_data(data):
	position = data["position"]
	speed = data["speed"]
	hp = data["hp"]
	max_hp = data["max_hp"]
	set_start_hp(hp, max_hp)
	create_inventory()
	
	for item in data["inventory"]:
		var new_item = pre_item.instance()
		new_item.set_item(item[0], item[1], item[2])
		self.inventory.add_item(new_item)



