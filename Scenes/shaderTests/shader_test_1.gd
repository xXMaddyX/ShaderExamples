extends Node2D

@onready var icon: Sprite2D = $Icon
@onready var icon_2: Sprite2D = $Icon2
@onready var icon_3: Sprite2D = $Icon3
@onready var icon_7: Sprite2D = $Icon7
@onready var phönix: AnimatedSprite2D = $Phönix


var shaderMat: ShaderMaterial;
var shader2Mat: ShaderMaterial;
var shader3Mat: ShaderMaterial;
var shader7Mat: ShaderMaterial;
var phoenixShaderMat: ShaderMaterial;
func _ready() -> void:
	shaderMat = icon.material
	
	shader2Mat = icon_2.material
	
	shader3Mat = icon_3.material
	
	shader7Mat = icon_7.material
	shader7Mat.set_shader_parameter("scale", -100.0);

	phoenixShaderMat = phönix.material
#------------------------->>>>SHADER1_CONTROLLER<<<<----------------------------
var CURRENT_ALPHA: float = -1.0
var goInvi: bool = true
func switchOverTimer(delta: float) -> void:
	if CURRENT_ALPHA < 1.0 and goInvi:
		CURRENT_ALPHA += delta / 4
		shaderMat.set_shader_parameter("delta", CURRENT_ALPHA)
		shaderMat.set_shader_parameter("tilt", CURRENT_ALPHA)
		if CURRENT_ALPHA > 1.0:
			goInvi = false
	
	if CURRENT_ALPHA >= -0.0 and !goInvi:
		CURRENT_ALPHA -= delta / 4
		shaderMat.set_shader_parameter("delta", CURRENT_ALPHA)
		if CURRENT_ALPHA < 0.0:
			goInvi = true
#-------------------------------------------------------------------------------
enum ShaderState {
	A_INCREASING,
	B_INCREASING,
	B_DECREASING,
	A_DECREASING
}
var currentState: ShaderState = ShaderState.A_INCREASING
var CURRENT_A_FACTOR: float = 0.0
var CURRENT_B_FACTOR: float = 0.0

func handelShader2(delta: float) -> void:
	if shader2Mat == null:
		printerr("handelShader2 wurde aufgerufen, aber shader2Mat ist null!")
		return

	match currentState:
		ShaderState.A_INCREASING:
			CURRENT_A_FACTOR += delta * 0.5
			if CURRENT_A_FACTOR >= 1.0:
				CURRENT_A_FACTOR = 1.0
				currentState = ShaderState.B_INCREASING
			shader2Mat.set_shader_parameter("afactor", CURRENT_A_FACTOR)

		ShaderState.B_INCREASING:
			CURRENT_B_FACTOR += delta * 0.5
			if CURRENT_B_FACTOR >= 1.0:
				CURRENT_B_FACTOR = 1.0
				currentState = ShaderState.B_DECREASING
			shader2Mat.set_shader_parameter("bfactor", CURRENT_B_FACTOR)

		ShaderState.B_DECREASING:
			CURRENT_B_FACTOR -= delta * 0.5
			if CURRENT_B_FACTOR <= 0.0:
				CURRENT_B_FACTOR = 0.0
				currentState = ShaderState.A_DECREASING
			shader2Mat.set_shader_parameter("bfactor", CURRENT_B_FACTOR)

		ShaderState.A_DECREASING:
			CURRENT_A_FACTOR -= delta * 0.5
			if CURRENT_A_FACTOR <= 0.0:
				CURRENT_A_FACTOR = 0.0
				currentState = ShaderState.A_INCREASING
			shader2Mat.set_shader_parameter("afactor", CURRENT_A_FACTOR)
		
#----------------------->>>>Shader3<--------------------------------------------
var CURRENT_SHADER3_DELTA: float = 0.0
var getBrighter: bool = false
func handelShader3(delta: float) -> void:
	if !getBrighter:
		CURRENT_SHADER3_DELTA -= delta
		shader3Mat.set_shader_parameter("delta", CURRENT_SHADER3_DELTA)
		if CURRENT_SHADER3_DELTA < -2.0:
			getBrighter = true
			
	if getBrighter:
		CURRENT_SHADER3_DELTA += delta
		shader3Mat.set_shader_parameter("delta", CURRENT_SHADER3_DELTA)
		if CURRENT_SHADER3_DELTA > 0.0:
			getBrighter = false
		
		
enum SHADER7 {
	START_ANIM,
	HOLD_FOR_DELAY,
	FIN_ANIM,
}
var currentAnimShader7: SHADER7 = SHADER7.START_ANIM;
var scalePos = -100.0
func shader7Handler(delta: float) -> void:
	match currentAnimShader7:
		SHADER7.START_ANIM:
			if scalePos < -30.0:
				scalePos += delta * 25;
			if scalePos >= -30.0:
				scalePos += delta * 15;
			if scalePos >= -10:
				scalePos += delta * 5;  
			if scalePos >= -5:
				scalePos += delta * 0.5;
			shader7Mat.set_shader_parameter("scale", scalePos)
			if scalePos > 0.0:
				scalePos = 0.0;
				shader7Mat.set_shader_parameter("scale", scalePos)
				currentAnimShader7 = SHADER7.HOLD_FOR_DELAY
				
		SHADER7.HOLD_FOR_DELAY:
			shader7Timer(delta)
			if timerDone:
				scalePos += delta * 20;
				shader7Mat.set_shader_parameter("scale", scalePos)
				if scalePos > 100.0:
					scalePos = 100.0;
					shader7Mat.set_shader_parameter("scale", scalePos)
					currentAnimShader7 = SHADER7.FIN_ANIM
				
		SHADER7.FIN_ANIM:
			timerDone = false
			scalePos = -100.0
			currentAnimShader7 = SHADER7.START_ANIM
			
var CURRENT_TIMER_SHADER7 = 2.0
var timerDone: bool = false
func shader7Timer(delta: float) -> void:
	if CURRENT_TIMER_SHADER7 > 0.0 and !timerDone:
		CURRENT_TIMER_SHADER7 -= delta
		if CURRENT_TIMER_SHADER7 <= 0.0:
			CURRENT_TIMER_SHADER7 = 2.0
			timerDone = true
			
var isPhoenixBrighter: bool = true
var CurrentBrightness = 0.0
var pulseSpeed: float = 5
func phoenixShaderHandler(delta: float) -> void:
	if isPhoenixBrighter:
		CurrentBrightness += delta * pulseSpeed
		phoenixShaderMat.set_shader_parameter("increment", CurrentBrightness)
		if CurrentBrightness > 1.0:
			CurrentBrightness = 1.0
			phoenixShaderMat.set_shader_parameter("increment", CurrentBrightness)
			isPhoenixBrighter = false
	if !isPhoenixBrighter:
		CurrentBrightness -= delta * pulseSpeed
		phoenixShaderMat.set_shader_parameter("increment", CurrentBrightness)
		if CurrentBrightness < 0.0:
			CurrentBrightness = 0.0
			phoenixShaderMat.set_shader_parameter("increment", CurrentBrightness)
			isPhoenixBrighter = true
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	phoenixShaderHandler(delta)
	switchOverTimer(delta)
	handelShader2(delta)
	handelShader3(delta)
	shader7Handler(delta)
