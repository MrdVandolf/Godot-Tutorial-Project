extends "res://Scripts/Stickman.gd"

var stands = true
var destination = Vector2()
var velocity = Vector2()

var prev_pos = Vector2()

var target = null

var default_speed = 45

var bite_strength = 10
var target_intercepted = false
var can_bite = true

func _ready():
	speed = default_speed
	self.hp = 45
	self.max_hp = 60
	set_start_hp(self.hp, self.max_hp)
	add_to_group(GlobalVars.entity_group)
	add_to_group(GlobalVars.animal_group)
	
	var skin = ItemMachine.generate_inventory_item("wolfskin")
	self.inventory.add_item(skin)

func _process(delta):
	if velocity:
		prev_pos = position
		move_and_slide(velocity)
		position.x = clamp(position.x, 0, 10000)
		position.y = clamp(position.y, 0, 10000)
	wander()
	search_for_target()
	
	if target_intercepted and can_bite:
		bite(target)

func search_for_target():
	var pl = get_parent().get_parent().get_player()
	
	if pl:
		if target:
			if position.distance_to(target.position) > 200:
				cancel_movement()
			else:
				set_destination(target.position)
		
		elif position.distance_to(pl.position) < 200:
			cancel_movement()
			speed = default_speed * 2 if speed == default_speed else speed
			target = pl


func set_destination(dest):
	destination = dest
	velocity = (destination - position).normalized() * speed
	
	if abs(dest.x - position.x) > abs(dest.y - position.y):
		$Anim.play("Walk")
	elif velocity.y < 0:
		$Anim.play("Up")
	else:
		$Anim.play("Down")
	
	$Anim.flip_h = velocity.x < 0
	
	stands = false

func cancel_movement():
	$Anim.play("Idle")
	velocity = Vector2()
	destination = Vector2()
	speed = default_speed
	$StandingTimer.start(2)
	target = null

func wander():
	var pos = position
	if stands:
		randomize()
		
		var x = int(rand_range(pos.x - 150, pos.x + 150))
		var y = int(rand_range(pos.y - 150, pos.y + 150))
		
		x = clamp(x, 0, 10000)
		y = clamp(y, 0, 10000)
		
		set_destination(Vector2(x, y))
	
	elif velocity != Vector2() and not target:
		if pos.distance_to(destination) <= speed:
			cancel_movement()
			
		elif pos.distance_to(prev_pos) <= 0.6:
			cancel_movement()

func bite(targ):
	var is_alive = targ.reduce_hp(bite_strength)
	can_bite = false
	# Запуск таймера кулдауна
	$BiteCooldown.start(1)
	if not is_alive:
		cancel_movement()

func _on_StandingTimer_timeout():
	stands = true
	pass # Replace with function body.


func _on_BiteCooldown_timeout():
	can_bite = true
	pass # Replace with function body.


func _on_BiteArea_area_entered(area):
	if area.get_parent() == target:
		target_intercepted = true
	pass # Replace with function body.


func _on_BiteArea_area_exited(area):
	if area.get_parent() == target:
		target_intercepted = false
	pass # Replace with function body.


func save():
	var data = .save()
	data["bite_strength"] = bite_strength
	data["default_speed"] = default_speed
	return data

func load_from_data(data):
	.load_from_data(data)
	bite_strength = data["bite_strength"]
	default_speed = data["default_speed"]



