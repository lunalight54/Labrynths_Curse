extends Camera2D
@export var randStrength: float = 30.0
@export var shakeFade: float = 5.0
var rand = RandomNumberGenerator.new()
var shake_strength: float = 0.0


func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		shake_strength = randStrength
	if (shake_strength > 0):
		shake_strength = lerp(shake_strength,0.0,shakeFade*delta)
		offset = random_offset()

func random_offset() -> Vector2:
	return Vector2(rand.randf_range(-shake_strength, shake_strength), rand.randf_range(-shake_strength, shake_strength))
