extends RigidBody2D

enum ANIMAL_STATE {READY, DRAG, RELEASE}

const DRAG_MAX_LIMIT: Vector2 = Vector2(0, 90)
const DRAG_MIN_LIMIT: Vector2 = Vector2(-90, 0)
const IMPULSE_MULT: float = 20.0
const IMPULSE_MAX: float = 1200.0

var _state: ANIMAL_STATE = ANIMAL_STATE.READY
var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _last_dragged_vector: Vector2 = Vector2.ZERO
var _arrow_scale_x: float = 0.0

@onready var stretch_sound: AudioStreamPlayer2D = $StretchSound
@onready var launch_sound: AudioStreamPlayer2D = $LaunchSound
@onready var arrow: Sprite2D = $Arrow

func _ready() -> void:
	_arrow_scale_x = arrow.scale.x
	_start = position
	arrow.hide()

func _physics_process(delta: float) -> void:
	update(delta)

func get_impulse() -> Vector2:
	return _dragged_vector *(-1) * IMPULSE_MULT

func set_drag() -> void:
	arrow.show()
	_drag_start = get_global_mouse_position()

func set_release() -> void:
	arrow.hide()
	freeze = false
	apply_central_impulse(get_impulse())
	launch_sound.play()

func setState(newState: ANIMAL_STATE) -> void:
	_state = newState
	if _state == ANIMAL_STATE.RELEASE:
		set_release()
	elif _state == ANIMAL_STATE.DRAG:
		set_drag()

func onScreenExited():
	die()
	
func die() -> void:
	SignalManager.onAnimalDied.emit()
	queue_free()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if _state == ANIMAL_STATE.READY and event.is_action_pressed("drag"):
		setState(ANIMAL_STATE.DRAG)
	
func updateOnDrag() -> void:
	if detect_release():
		return
	var gmp = get_global_mouse_position()
	_dragged_vector = get_dragged_vector(gmp)
	play_stretch_sound()
	drag_in_limists()
	scale_arrow()

func scale_arrow() -> void:
	var impulse_length = get_impulse().length()
	var perc = impulse_length / IMPULSE_MAX
	arrow.scale.x = (_arrow_scale_x * perc) + _arrow_scale_x
	arrow.rotation = (_start - position).angle()

func play_stretch_sound() -> void:
	if(_last_dragged_vector - _dragged_vector).length() > 0:
		if !stretch_sound.playing:
			stretch_sound.play()

func get_dragged_vector(gmp: Vector2) -> Vector2:
	return gmp - _drag_start
	
func drag_in_limists() -> void:
	_last_dragged_vector = _dragged_vector
	_dragged_vector.x = clampf(_dragged_vector.x, DRAG_MIN_LIMIT.x, DRAG_MAX_LIMIT.x)
	_dragged_vector.y = clampf(_dragged_vector.y, DRAG_MIN_LIMIT.y, DRAG_MAX_LIMIT.y)
	position = _start + _dragged_vector;

func detect_release() -> bool:
	if _state == ANIMAL_STATE.DRAG:
		if Input.is_action_just_released("drag"):
			setState(ANIMAL_STATE.RELEASE)
			return true
	return false

func update(delta: float) ->  void:
	match _state:
		ANIMAL_STATE.DRAG:
			updateOnDrag()
			
