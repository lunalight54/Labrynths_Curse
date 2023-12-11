extends Node2D
class_name Game
@onready var player = $Character
@onready var timer = $Timer
@onready var camera = $Character/Camera2D
var currentRoom
var spawnPosition = Vector2(650,500)
var old_room
var loaded_rooms = []

func _ready():
	Utils.game=self
	timer.wait_time = (randf_range(10, 20));
	timer.start();
	generate_room(null, "south")
	spawn_character()
	
	
func spawn_character(): 
	player.global_position = spawnPosition
	
func choose_room(entrance):
	var rooms = Utils.Rooms
	var next
	var done = 0
	while (done != 1):
		next = randi_range(0,4)
		if (entrance == "north"):
			done = Utils.Entrance[0][next]
		if (entrance == "right"):
			done = Utils.Entrance[1][next]
		if (entrance == "south"):
			done = Utils.Entrance[2][next]
		if (entrance == "left"):
			done = Utils.Entrance[3][next]
			
	currentRoom = rooms[next].instantiate()
	add_child(currentRoom)
	loaded_rooms.append(currentRoom)

func generate_room(last_door, entrance):
	if ( currentRoom != null): #save last room
		old_room = currentRoom
		remove_child(currentRoom) 
	choose_room(entrance) #checks if next room has proper entrance

	var Doors = get_tree().get_nodes_in_group(entrance + "_entrance")
	var choosen=Doors.front()
	spawnPosition = choosen.start_position.global_position
	choosen.previous_room = old_room
	choosen.connect_doors(last_door)
	spawn_character()
	
func reload_room(prev, last_door, door):
	old_room = currentRoom
	remove_child(currentRoom)
	currentRoom = prev
	add_child(currentRoom)
	spawnPosition = door.start_position.global_position
	door.previous_room = old_room
	door.connect_doors(last_door)
	spawn_character()

func _on_timer_timeout():
	print("shifts")
	var Doors = get_tree().get_nodes_in_group("door")
	for i in Doors:
		i.disconnect_doors()
	for j in loaded_rooms:
		if (j != currentRoom):
			if (is_instance_valid(j)):
				j.queue_free()
	loaded_rooms.clear()
	loaded_rooms.append(currentRoom)	
	
	#implement signal to camera and shake for 5 sec
	
	timer.wait_time = (randf_range(10, 20));
	timer.start();
	
	
