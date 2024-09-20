extends Node

var _attempts: int = 0
var _cups_hit: int = 0
var _total_cups: int = 0
var _level_number: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_total_cups = get_tree().get_nodes_in_group("cup").size()
	_level_number = ScoreManager.get_level_selected()
	SignalManager.onAttemptMade.connect(onAttemptMade)
	SignalManager.onCupDestroyed.connect(onCupDestroyed)
	
func onAttemptMade() -> void:
	_attempts += 1
	SignalManager.emitOnScoreUpdated(_attempts)
	
func onCupDestroyed() -> void:
	_cups_hit += 1
	if _cups_hit == _total_cups:
		SignalManager.onLevelComplete.emit()
		ScoreManager.set_score_for_level(_attempts, str(_level_number))
