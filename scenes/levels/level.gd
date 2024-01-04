extends Node2D

var laser_scene: PackedScene = preload("res://laser.tscn")
var grenade_scene: PackedScene = preload("res://projectiles/grenade.tscn")

func _on_gate_player_entered_gate():
	print("Player has entered the gate")


func _on_player_grenade_signal(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)

func _on_player_laser_signal(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.position = pos
	laser.direction = direction
	$Projectiles.add_child(laser)
