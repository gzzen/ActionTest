extends Node2D

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$ColorRect.set_size(screen_size)
	


func _on_Player_hit():
	$Enemy/DamageLabel.visible = true
	$Enemy/DamageLabelTimer.start()
