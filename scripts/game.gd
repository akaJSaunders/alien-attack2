extends Node

var lives = 3
var score = 0
@onready var player = $Player
@onready var hud = $UI/HUD
@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_damage_sound = $PlayerDamageSound

var game_over_scene = preload("res://scenes/gave_over_screen.tscn")

func _ready():
	hud.set_score_label(0)
	hud.set_lives_left_label(lives)

func _on_deathzone_area_entered(area):
	area.queue_free()

func _on_player_took_damage():
	lives -= 1
	hud.set_lives_left_label(lives)
	player_damage_sound.play()
	
	
	if lives == 0:
		var game_over_instance = game_over_scene.instantiate()
		player.die()
		
		await get_tree().create_timer(1.5).timeout
		
		hud.add_child(game_over_instance)
		game_over_instance.set_score(score)
		

func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()

func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)


func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance):
	print("hi")
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("died", _on_enemy_died)
