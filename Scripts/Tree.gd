extends "res://Scripts/Nature_object.gd"

onready var texture = 0

func _ready():
	randomize() # Функция, которая заставляет Godot подбирать случайные числа в любых рандомных функциях
	# Случайное целое число в пределах от 1 до 3 [1;3]
	var a = int(rand_range(1,4))
	# Обращаемся к дочернему узлу Sprite, к его параметру texture и изменяем его
	# Функция load загружает ресурс из файловой системы проекта
	# Внутри нее пишется адрес файла
	# %s - ссылка, в которую вставляется фрагмент, записанный вне самой строки
	$Sprite.texture = load("res://Sprites/tree%s.png" % str(a))
	texture = a
	pass


func save():
	var data = .save()
	data["texture"] = texture
	return data


func load_from_data(data):
	.load_from_data(data)
	$Sprite.texture = load("res://Sprites/tree%s.png" % str(data["texture"]))
