extends Label

func _process(_delta):
	text = str(int(Game.Current_Score))
