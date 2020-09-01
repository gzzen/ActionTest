extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$DamageLabel.visible = false


func _on_DamageLabelTimer_timeout():
	$DamageLabel.visible = false
