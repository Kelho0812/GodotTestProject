extends CharacterBody2D

var speed : int = 500
var can_laser: bool = true
var can_grenade: bool = true
signal laser_signal(pos, direction)
signal grenade_signal(pos, direction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#input
	var direction = Input.get_vector("left", "right","up","down")
	velocity = direction * speed
	move_and_slide()
	
	#rotate player
	look_at(get_global_mouse_position())
	
	var player_direction = (get_global_mouse_position() - position).normalized()
	#laser shooting input
	if Input.is_action_pressed("primary_action") and can_laser:
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$LaserTimer.start()
		laser_signal.emit(selected_laser.global_position, player_direction)
		
	if Input.is_action_pressed("secondary_action")  and can_grenade:
		can_grenade = false 
		var pos = $LaserStartPositions/Marker2D.global_position
		$GrenadeTimer.start()
		grenade_signal.emit(pos, player_direction)

func _on_laser_timer_timeout():
	can_laser = true

func _on_grenade_timer_timeout():
	can_grenade = true
