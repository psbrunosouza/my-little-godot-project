extends KinematicBody2D

class_name PlayerModel

const FALL_GRAVITY: int = 800
const JUMP_GRAVITY: int = 600
const WALL_ATTACHED_GRAVITY: int = 50
const JUMP_FORCE: int = -250
const WALL_IMPULSE_HEIGHT = -250
const MOVE_SPEED: int = 150
const WALL_IMPULSE_SPEED: int = 450
const MAX_JUMP_QUANTITY: int = 2

onready var motion: Vector2 = Vector2(0, 0)
onready var performed_jumps: int = 0
onready var is_jumping: bool = false
var direction: float

onready var wall_detector_right: RayCast2D = $WallDetectorRight
onready var wall_detector_left: RayCast2D = $WallDetectorLeft
onready var sprite: Sprite = $Sprite
onready var animation_player_tree: AnimationTree = $AnimationMachinePlayer
onready var animation_player_machine = animation_player_tree.get("parameters/playback")

func next_to_wall() -> bool:
	return wall_detector_right.is_colliding() || wall_detector_left.is_colliding()

