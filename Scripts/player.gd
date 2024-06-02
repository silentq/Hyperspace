class_name Player extends CharacterBody2D

var speed = 60

@onready var muzzle1 = $Muzzle1
@onready var ShotContainer = $"../ShotContainer"

var shoot_cooldown := false
var shot_scene = preload("res://Scenes/shot.tscn")
var rate_of_fire = 0.25

func _ready():
	Game.Player_Present = true

func _process(_delta):
	if Input.is_action_pressed("shoot"):
		if shoot_cooldown == false:
			shoot_cooldown = true
			shoot()
			await get_tree().create_timer(rate_of_fire).timeout
			shoot_cooldown = false

func _physics_process(_delta):
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	velocity = direction * speed
	move_and_slide()
	
	$".".global_position.x = clamp($".".global_position.x, 4, 124)
	$".".global_position.y = clamp($".".global_position.y, 21, 120)
	
func shoot():
	var s1 = shot_scene.instantiate()
	ShotContainer.add_child(s1)
	s1.transform = muzzle1.global_transform
	
func die():
	Game.Player_Present = false
	if Game.continues > 0:
		Game.Player_Dead = true
		queue_free()
	if Game.continues == 0:
		get_tree().change_scene_to_file.bind("res://Scenes/title.tscn").call_deferred()

	
	
