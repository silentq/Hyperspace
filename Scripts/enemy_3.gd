extends Area2D


@export var speed = 100
@export var hp = 2
@onready var sprite = $Sprite2D

var armor = true

func _physics_process(delta):
	global_position.y += speed * delta
	
func die():
	Game.Current_Score += 500
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
