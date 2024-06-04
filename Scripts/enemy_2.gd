extends Area2D


@export var speed = 30
@export var hp = 3

@onready var muzzle = $Muzzle
@onready var ShotContainer = $"../../ShotContainer"
@onready var anim = $AnimatedSprite2D

var shoot_cooldown = false
var rate_of_fire = 2
var enemy_shot = preload("res://Scenes/enemy_shot_h.tscn")
var armor = true

func _physics_process(delta):
	global_position.y += speed * delta

func _process(_delta):
	if shoot_cooldown == false:
		shoot_cooldown = true
		shootatplayer()
		await get_tree().create_timer(rate_of_fire).timeout
		shoot_cooldown = false

func get_player():
	var nodes = get_tree().get_nodes_in_group("player")
	if len(nodes) > 0:
		return nodes[0]
	push_error("The player is missing...")

func shootatplayer():
	if Game.Player_Present == true:
		var b = enemy_shot.instantiate()
		ShotContainer.add_child(b)
		b.global_position = global_position
		var dir = (get_player().global_position - global_position).normalized()
		b.global_rotation = dir.angle() + PI / 2.0
		b.direction = dir

func die():
	Game.Current_Score += 100
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.die()
		die()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func take_damage(amount):
	if armor == false:
		hp -= amount
		anim.modulate = Color(10, 10, 10, 10)
		await get_tree().create_timer(0.1).timeout
		anim.modulate = Color.WHITE
	if  hp == 0:
		set_physics_process(false)
		$CollisionShape2D.set_deferred("disabled", true)
		anim.play("explosion")
		await get_tree().create_timer(0.5).timeout
		die()
	else:
		return

func _on_visible_on_screen_notifier_2d_screen_entered():
	armor = false
