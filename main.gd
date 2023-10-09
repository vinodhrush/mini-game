extends Node2D

var can_shoot : bool = true
var bulletScene: PackedScene =  preload("res://player/Bullet/bullet.tscn")

@onready var enemey_count = 0

# Called when the node enters the scene tree for the first time.
 
func _physics_process(delta):
	if Globals.health == 0:
		get_tree().change_scene_to_file("res://trans/startMenu.tscn")
	
	print(enemey_count)
	if enemey_count == 3:
		get_tree().change_scene_to_file("res://scene2/main2.tscn")
		
func _on_character_shot(pos,direction) :
	var bullet_new = bulletScene.instantiate()
	bullet_new.position = pos 
	bullet_new.direction = direction
	$Projectiles.add_child(bullet_new)
	$CanvasLayer.update_ammo_text()
	
	


func _on_character_update_status():
	$CanvasLayer.update_ammo_text()


func _on_enemy_dead_count():
	enemey_count += 1

func _on_enemy_2_dead_count():
	enemey_count += 1

func _on_enemy_3_dead_count():
	enemey_count += 1
