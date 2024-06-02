extends Area2D

@export var speed = 30
@export var hp = 3

@onready var muzzle = $Muzzle
@onready var ShotContainer = $"../../ShotContainer"
@onready var sprite = $Sprite2D

var shoot_cooldown = false
var rate_of_fire = 1
var enemy_shot = preload("res://Scenes/enemy_shot_s.tscn")
var armor = true
var side = true

func _physics_process(delta):
	global_position.y += speed * delta
	if side == true:
		global_position.x -= speed/2 * delta
		await get_tree().create_timer(1).timeout
		side = false
	if side == false:
		global_position.x += speed/2 * delta
		await get_tree().create_timer(1).timeout
		side = true
	
	
	
	

func _process(_delta):
	if shoot_cooldown == false:
		shoot_cooldown = true
		shoot()
		await get_tree().create_timer(rate_of_fire).timeout
		shoot_cooldown = false

func shoot():
	var b = enemy_shot.instantiate()
	ShotContainer.add_child(b)
	b.transform = muzzle.global_transform

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
		sprite.modulate = Color(10, 10, 10, 10)
		await get_tree().create_timer(0.1).timeout
		sprite.modulate = Color.WHITE
	if  hp == 0:
		die()
	else:
		return
		
func _on_visible_on_screen_notifier_2d_screen_entered():
	armor = false
