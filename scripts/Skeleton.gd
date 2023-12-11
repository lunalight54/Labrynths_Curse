extends RigidBody2D
var vision_range
var out_of_vision
var action
var hp
var active
var movespeed
var dead
var angle

# Called when the node enters the scene tree for the first time.
func _ready():
	hp = 160
	vision_range = 100.0
	out_of_vision = 200.0
	active = false
	movespeed = 0.8
	dead = false
	angle = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (dead == false):
		if (movespeed < 0.8):
			movespeed += 0.05
		linear_velocity = Vector2(0,0);
		var distance = Utils.game.player.global_position - self.global_position
		angle = snappedf(-rad_to_deg((distance).angle_to(Vector2.UP)),22.5)
		if(distance.length() <= vision_range || active == true):
			move_and_collide(distance.normalized() * movespeed)
			active = true
		if (distance.length() >= out_of_vision):
			active = false
			movespeed = 0.8
	
func die():
	dead = true
	#play death anim

func attack():
	pass

func hit(hit_pos, dmg):# przekazać do hita rotacja miecza na knockback
	if (dead == false):
		var knockback = hit_pos - self.global_position
		self.translate(knockback.normalized() * 50 * -1)
		movespeed = 0.2
		hp -= dmg
		if (hp <= 0):
			die()
