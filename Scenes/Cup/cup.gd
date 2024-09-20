extends StaticBody2D

#region onready
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#endregion

func vanish() -> void:
	animation_player.play("Vanish")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	SignalManager.onCupDestroyed.emit()
	queue_free()
