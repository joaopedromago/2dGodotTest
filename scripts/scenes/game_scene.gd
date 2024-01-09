extends Node

const SaveLoadService = preload("res://scripts/services/save_load_service.gd")

var save_load_service = SaveLoadService.new()


func _ready():
	var is_load = Globals.get_is_load()

	if is_load:
		Globals.set_is_load(false)
		save_load_service.load_game(self)


func _process(delta):
	pass


func save():
	var player = get_node(Globals.player_path)
	var position = player.position

	var save_dict = {
		"filename": self.get_scene_file_path(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y
	}

	return save_dict


func return_to_title():
	get_tree().change_scene_to_file(Globals.menu_scene)


func _on_return_pressed():
	return_to_title()


func _on_save_pressed():
	save_load_service.save_game(self)
