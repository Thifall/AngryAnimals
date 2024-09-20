extends Node2D

#region Const
const ANIMAL = preload("res://Scenes/animal/animal.tscn")
const MAIN = preload("res://Scenes/Main/main.tscn")
#endregion

#region onready
@onready var animal_start_point: Marker2D = $AnimalStartPoint
#endregion

func _ready() -> void:
	SignalManager.onAnimalDied.connect(instantiateAnimalScene)
	instantiateAnimalScene()

func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_packed(MAIN)
	
func instantiateAnimalScene():
	var newAnimal = ANIMAL.instantiate()
	newAnimal.position = animal_start_point.position
	add_child(newAnimal)
