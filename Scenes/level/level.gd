extends Node2D

const ANIMAL = preload("res://Scenes/animal/animal.tscn")
@onready var animal_start_point: Marker2D = $AnimalStartPoint

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.onAnimalDied.connect(instantiateAnimalScene)
	instantiateAnimalScene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func instantiateAnimalScene():
	var newAnimal = ANIMAL.instantiate()
	newAnimal.position = animal_start_point.position
	add_child(newAnimal)
