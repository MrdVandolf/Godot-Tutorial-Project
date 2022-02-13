extends Control


func _ready():
	var b = $Button
	b.connect("pressed", self, "change_stage", [b.scene_to_open])

func change_stage(path):
	SceneChanger.change_scene(path)
