extends RigidBody2D
@onready var player=$Player
@onready var hit_cone=$HitScan
var action
var first_hit
# Called when the node enters the scene tree for the first time.
func _ready():
	action = "idle";
	player.play("warrior_walk_0")
	first_hit = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_change_direction();
	if (action == "attack"):
		await(player.animation_finished)
		first_hit = true
		#check direction cone (from given direction, check -22.5 and +22.5) 
		#+ range of attack to see if hit regustered
		#detect hit object/objects if true, and call on_hit function - make group hittable
	action = "idle";
	linear_velocity = Vector2(0,0);
	if(Input.is_action_pressed("ui_down")):
		linear_velocity.y = 100;
		action = "walk";		
	if(Input.is_action_pressed("ui_up")):
		linear_velocity.y = -100;
		action = "walk";
	if(Input.is_action_pressed("ui_left")):
		linear_velocity.x = -100;
		action = "walk";
	if(Input.is_action_pressed("ui_right")):
		linear_velocity.x = 100;
		action = "walk";
	if(Input.is_action_pressed("ui_attack")):
		action = "attack";
		linear_velocity.y = 0;
		linear_velocity.x = 0;
	
#	if(Input.is_action_pressed("ui_accept")):
#		var drop=preload("res://test_drop.tscn").instantiate()
#		drop.global_position=global_position
#		Utils.game.currentRoom.add_child(drop)
		

		
func _change_direction():
	var play_backwards = false
	var direction = snappedf(-rad_to_deg((get_global_mouse_position()-global_position).angle_to(Vector2.UP)),22.5)
	if (direction == -180):
		direction = 180
	var current_frame = player.get_frame()
	var current_progress = player.get_frame_progress()
	player.play("warrior_"+action+"_"+str(direction))
	player.set_frame_and_progress(current_frame,current_progress); #this can cause attack anim to be shorter
	
	if (action == "attack" && first_hit == true):
		hit_cone.look_at(get_global_mouse_position())
		hit_cone.rotation += PI/2
		var collisions = hit_cone.get_collision_count()
		for i in collisions:
			var obj = hit_cone.get_collider(i)
			if(obj.has_method("hit")):
				obj.hit()
		first_hit = false
