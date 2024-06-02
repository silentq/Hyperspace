extends Marker2D

var player_scene = preload("res://Scenes/player.tscn")
var player = null

func _process(_delta):
	if Game.Player_Dead == true:
		var new_player = player_scene.instantiate()
		new_player.position = position
		$"..".add_child(new_player)
		Game.Player_Dead = false
		Game.continues -= 1
