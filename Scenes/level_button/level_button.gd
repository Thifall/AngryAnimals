extends TextureButton

#region const
const HOVER_SCALE: Vector2 = Vector2(1.1, 1.1)
const DEFAULT_SCALE: Vector2 = Vector2(1.0, 1.0)
#endregion

#region export 
@export var level_number: int = 1
#endregion

#region onready
@onready var level_number_lbl: Label = $MC/VBoxContainer/LevelNumberLbl
@onready var score_lbl: Label = $MC/VBoxContainer/ScoreLbl
#endregion

#region var
var _level_scene: PackedScene
#endregion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_number_lbl.text = str(level_number)
	var bestScore = ScoreManager.get_best_for_level(str(level_number))
	score_lbl.text = ("BEST: %s" % bestScore)
	_level_scene = load("res://Scenes/level/level%s.tscn" % level_number)

func _on_pressed() -> void:
	ScoreManager.set_level_selected(level_number)
	get_tree().change_scene_to_packed(_level_scene)

func _on_mouse_entered() -> void:
	scale = HOVER_SCALE

func _on_mouse_exited() -> void:
	scale = DEFAULT_SCALE
