extends RigidBody2D
var vision_range
var out_of_vision
var action
var hp
var active
var distance

# Called when the node enters the scene tree for the first time.
func _ready():
	hp = 100
	vision_range = 100.0
	out_of_vision = 200.0
	active = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	linear_velocity = Vector2(0,0);
	distance = Utils.game.player.global_position - self.global_position
	var angle = snappedf(-rad_to_deg((distance).angle_to(Vector2.UP)),22.5)
	if(distance.length() <= vision_range || active == true):
		move_and_collide(distance.normalized())
		active = true
	if (distance.length() >= out_of_vision):
		active = false
	
func hit():# przekazać do hita rotacja miecza na knockback
	self.translate(distance.normalized() * 50 * -1)
	print("hit")
