extends Node

var playerPath = "runningGame/Player/PlayerObject"

func _ready():
	var is_load = Globals.get_is_load()

	if is_load:
		Globals.set_is_load(false)
		load_game()


func _process(delta):
	pass


func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		print("SAVE NOT FOUND")
		return

	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	
	print("loading", save_game)
	
	var json_string = save_game.get_line()
	print("json_string", json_string)

	var json = JSON.new()
	var parse_result = json.parse(json_string)
	print("parse_result", parse_result)
	
	if not parse_result == OK:
		print(
			"JSON Parse Error: ",
			json.get_error_message(),
			" in ",
			json_string,
			" at line ",
			json.get_error_line()
		)

	var node_data = json.get_data()
	print("node_data", node_data)

	var object = load(node_data["filename"])
	print("object", object)

	if !object:
		print("OBJECT NOT FOUND")
		return

	var player = get_node(playerPath)
	object.instantiate()
	player.position = Vector2(node_data["pos_x"], node_data["pos_y"])


func save():
	var player = get_node(playerPath)
	var position = player.position

	var save_dict = {
		"filename": self.get_scene_file_path(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y
	}

	return save_dict
