extends Control

const MAIN = preload("res://Scenes/Main/main.tscn")
@onready var levellbl: Label = $MC/VB/Levellbl
@onready var attemptslbl: Label = $MC/VB/Attemptslbl
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var vb_2: VBoxContainer = $MC/VB2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	levellbl.text = "%s" % ScoreManager.get_level_selected()
	update_attempts(0)
	SignalManager.onScoreUpdated.connect(update_attempts)
	SignalManager.onLevelComplete.connect(onLevelComplete)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		get_tree().change_scene_to_packed(MAIN)
		
func update_attempts(attempts: int) -> void:
	attemptslbl.text = "Attempts: %s" % attempts

func onLevelComplete() -> void:
	vb_2.show()
	audio_stream_player.play()
