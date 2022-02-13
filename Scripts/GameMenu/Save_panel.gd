extends Control

onready var save_name = "" setget set_name
onready var save_file = preload("res://Scripts/Resources/SaveData.gd")

signal on_saved


func _ready():
	#hide()
	$Box/Naming.connect("text_changed", self, "set_name")
	$Box/Scroll/ItemList.connect("item_selected", self, "change_line")
	$Box/Buttons/Save.connect("pressed", self, "save")


func open():
	show()
	update_saves()
	$Box/Naming.text = ""


func set_name(n):
	save_name = n


func change_line(ind):
	var sname = $Box/Scroll/ItemList.get_item_text(ind)
	$Box/Naming.text = sname
	set_name(sname)


func update_saves():
	$Box/Scroll/ItemList.clear()
	
	var dir = Directory.new()
	if not dir.dir_exists(GlobalVars.save_dir):
		dir.make_dir_recursive(GlobalVars.save_dir)
	dir.change_dir(GlobalVars.save_dir)
	
	dir.list_dir_begin(true)
	var file = dir.get_next()
	while file != "":
		$Box/Scroll/ItemList.add_item(file.split('.')[0])
		file = dir.get_next()
	dir.list_dir_end()


func save():
	if save_name != "":
		var file = save_file.new()
		file.set_name(save_name)
		var able_to_save = get_tree().get_nodes_in_group(GlobalVars.saving_group)
		file.set_data(able_to_save[0].save())
		var save_path = GlobalVars.save_dir.plus_file(GlobalVars.save_temp % save_name)
		
		ResourceSaver.save(save_path, file)
		
		emit_signal("on_saved")
