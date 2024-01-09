extends Node

const player_path = "runningGame/Player/PlayerObject"
const game_scene = "res://scenes/game.tscn"
const menu_scene = "res://scenes/menu.tscn"
const save_file = "user://savegame.save"

var is_load = false


func get_is_load():
	return is_load


func set_is_load(value):
	is_load = value
