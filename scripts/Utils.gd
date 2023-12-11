extends Node
var game: Game
var Rooms: Array = [load("res://room_0.tscn"), load("res://room_1.tscn"), load("res://room_2.tscn"), load("res://room_3.tscn"), load("res://room_4.tscn")]
var Entrance= [[1,1,0,0,1], #NESW
				[1,0,1,1,0],
				[0,1,1,1,1],
				[1,1,1,0,0]]
var old_room

