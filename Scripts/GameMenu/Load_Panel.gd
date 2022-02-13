extends Control

onready var file_to_load = ""

signal on_close_menu
signal on_loaded(data)


func _ready():
	hide()
	$Box/Scroll/ItemList.connect("item_selected", self, "set_file_to_load")
	$Box/Buttons/Load.connect("pressed", self, "load_file")
	connect("on_loaded", SceneChanger, "load_game")


func set_file_to_load(ind):
	var text = $Box/Scroll/ItemList.get_item_text(ind)
	file_to_load = text


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


func open():
	show()
	update_saves()
	file_to_load = ""


func load_file():
	if file_to_load != "":
		var file_path = GlobalVars.save_dir.plus_file(GlobalVars.save_temp % file_to_load)
		var file = File.new()
		
		if file.file_exists(file_path):
			
			var saved_game = load(file_path)
			
			emit_signal("on_close_menu")
			emit_signal("on_loaded", saved_game.get_data())
		
