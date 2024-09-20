extends Node

signal onAnimalDied
signal onCupDestroyed
signal onAttemptMade
signal onScoreUpdated(attempts: int)
signal onLevelComplete

func emitOnAnimalDied() -> void:
	onAnimalDied.emit()
	
func emitOnCupDestroyed() -> void:
	onCupDestroyed.emit()
	
func emitOnAttemptMade() -> void:
	onAttemptMade.emit()

func emitLevelComplete() -> void:
	onLevelComplete.emit()
	
func emitOnScoreUpdated(attempts: int):
	onScoreUpdated.emit(attempts)
