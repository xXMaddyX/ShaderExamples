extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var isPlayBack: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("open")

	
func playAnimation() -> void:
	if !isPlayBack and animation_player.current_animation_position > 3.0:
		isPlayBack = true
		animation_player.play("open", -1, -0.5, true)
		
	if isPlayBack and animation_player.current_animation_position <= 0.05:
		animation_player.stop(false)
		animation_player.play("open", -1, 0.5, false)
		isPlayBack = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	playAnimation()
	rotation.y += delta / 2
