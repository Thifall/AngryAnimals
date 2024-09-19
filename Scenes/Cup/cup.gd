extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func vanish() -> void:
	animation_player.play("Vanish")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	SignalManager.onCupDestroyed.emit()
	queue_free()
