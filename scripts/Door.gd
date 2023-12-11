extends Node2D

@onready var start_position = $start_position
var previous_room
var connected_door
func connect_doors(last_door):
	connected_door = last_door

func disconnect_doors():
	if (self.connected_door != null):
		connected_door = null
		previous_room=null
	

func _on_door_area_body_entered(body):
	if(previous_room != null):
		Utils.game.reload_room(previous_room, self, connected_door)
	else:
		if (self.is_in_group("north_entrance")):
			Utils.game.generate_room(self, "south")
		if (self.is_in_group("right_entrance")):
			Utils.game.generate_room(self, "left")
		if (self.is_in_group("south_entrance")):
			Utils.game.generate_room(self, "north")
		if (self.is_in_group("left_entrance")):
			Utils.game.generate_room(self, "right")
