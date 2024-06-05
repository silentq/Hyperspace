extends Area2D

@export var speed = 80
@export var damage = 1

@onready var hit = get_node("../../hit")


func _ready():
	$laser.play()

func _physics_process(delta):
	position += transform.y * -speed * delta
	
	
func _on_area_entered(area):
	hit.play()
	if area.is_in_group("enemy"):
		area.take_damage(damage)
		queue_free()
		


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
