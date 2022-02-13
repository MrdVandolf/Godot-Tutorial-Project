extends Control


func _ready():
	hide()
	$Panel/Main/Buttons/Resume.connect("pressed", self, "open")
	
	$Panel/Main/Buttons/Quit.connect("pressed", SceneChanger, "change_scene", ["res://Scenes/Menu.tscn"])
	
	$Panel/Main/Buttons/Save.connect("pressed", $Panel/Main, "hide")
	$Panel/Main/Buttons/Save.connect("pressed", $Panel/Save, "open")
	
	$Panel/Main/Buttons/Load.connect("pressed", $Panel/Main, "hide")
	$Panel/Main/Buttons/Load.connect("pressed", $Panel/Load, "open")
	
	$Panel/Save/Box/Buttons/Cancel.connect("pressed", $Panel/Save, "hide")
	$Panel/Save/Box/Buttons/Cancel.connect("pressed", $Panel/Main, "show")
	
	$Panel/Load/Box/Buttons/Cancel.connect("pressed", $Panel/Load, "hide")
	$Panel/Load/Box/Buttons/Cancel.connect("pressed", $Panel/Main, "show")
	
	$Panel/Save.connect("on_saved", $Panel/Main, "show")
	$Panel/Save.connect("on_saved", $Panel/Save, "hide")
	$Panel/Load.connect("on_close_menu", self, "open")


func open():
	print(32)
	if visible:
		hide()
		get_tree().paused = false
	else:
		get_tree().paused = true
		show()
		$Panel/Load.hide()
		$Panel/Save.hide()
		$Panel/Main.show()
