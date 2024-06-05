extends Node2D

@export var enemy_scenes: Array[PackedScene] = []
@onready var  timer = $"Enemy Spawn Timer"
@onready var enemycontainer = $"Enemy Container"
@onready var shotcontainer = $ShotContainer
@onready var player_spawn_pos = $PlayerSpawnPosition
@onready var game_time = 0
@onready var formationamt = 0
@onready var formation1 = true
@onready var formation2 = false

var player = null


# Called when the node enters the scene tree for the first time.
func _ready():
	Game.continues = 2
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.global_position = player_spawn_pos.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if game_time >= 0:
		timer.wait_time = 1
	#if game_time <= 20 and game_time >= 0:
	#	timer.wait_time = 3
	#if game_time > 20 and game_time <=30:
	#	timer.wait_time = 2.5
	#if game_time >30 and game_time <= 40:
	#	timer.wait_time = 2
	#if game_time >40 and game_time <=50:
	#	timer.wait_time = 1.5
	#if game_time >50 and game_time <=60:
	#	timer.wait_time = 1
	#if game_time > 60:
	#	timer.wait_time = 0.5
	


func _on_enemy_spawn_timer_timeout():
	#var e = enemy_scenes.pick_random().instantiate()
	#e.global_position = Vector2(randf_range(4, 124), 0)
	#enemycontainer.add_child(e)
	
	if formationamt < 6 and formation1 == true:
		var e1 = enemy_scenes[0].instantiate()
		e1.global_position = Vector2(64, 0)
		enemycontainer.add_child(e1)
		formationamt += 1
	elif formationamt >= 6 and formation1 == true:
		formation1 = false
		formationamt = 0
		await get_tree().create_timer(2).timeout
		formation2 = true
		
	if formation1 == false and formationamt <8 and formation2 == true:
		var e1 = enemy_scenes[1].instantiate()
		e1.global_position = Vector2(32, 0)
		enemycontainer.add_child(e1)
		formationamt += 1
	elif formationamt >= 8 and formation2 == true:
		formation2 = false
		formationamt = 0
		await get_tree().create_timer(2).timeout
		formation1 = true
		
	if formation1 == false and formationamt <8 and formation2 == true:
		var e1 = enemy_scenes[1].instantiate()
		e1.global_position = Vector2(96, 0)
		enemycontainer.add_child(e1)
		formationamt += 1
	elif formationamt >= 8 and formation2 == true:
		formation2 = false
		formationamt = 0
		


func _on_game_time_timeout():
	game_time += 1
