extends Control

func _ready():
	$Buttons/Button.connect("pressed", self, "change_scene", [$Buttons/Button.scene_to_open])
	
	$Buttons/Open_load.connect("pressed", $Load, "open")
	$Buttons/Open_load.connect("pressed", $Buttons, "hide")
	
	$Load/Box/Buttons/Cancel.connect("pressed", $Load, "hide")
	$Load/Box/Buttons/Cancel.connect("pressed", $Buttons, "show")


func change_scene(path):
	SceneChanger.change_scene(path)
