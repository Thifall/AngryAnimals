extends Area2D

@onready var splash: AudioStreamPlayer2D = $splash


func _on_body_entered(_body: Node2D) -> void:
	splash.play()
