extends Camera2D

onready var zoomfactor = 1 # насколько далеко отдаляется камера
onready var zoomspeed = 20 # скорость отдаления
onready var zoomstep = 0.03 
onready var factorstep = 0.0001 

func _ready():
	pass 

func _process(delta):
	
	zoom.x = lerp(zoom.x, zoomfactor * zoom.x, zoomspeed * delta)
	zoom.y = lerp(zoom.y, zoomfactor * zoom.y, zoomspeed * delta)
	
	zoom.x = clamp(zoom.x, 0.5, 2)
	zoom.y = clamp(zoom.y, 0.5, 2)
	
	print(zoomfactor)
	
	if zoomfactor > 1:
		zoomfactor = max(1, zoomfactor-factorstep)
	elif zoomfactor < 1:
		zoomfactor = min(1, zoomfactor+factorstep)
	
func _unhandled_input(event):
	
	if event is InputEventMouseButton:
		
		if event.button_index == BUTTON_WHEEL_UP:
			zoomfactor -= zoomstep
			
		elif event.button_index == BUTTON_WHEEL_DOWN:
			zoomfactor += zoomstep
			
