class_name SaveLoadService


func load_game(this):
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

	var player = this.get_node(Globals.playerPath)
	object.instantiate()
	player.position = Vector2(node_data["pos_x"], node_data["pos_y"])


func save_game(this):
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = this.get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		var node_data = node.call("save")

		var json_string = JSON.stringify(node_data)

		print("SAVED", json_string)
		save_game.store_line(json_string)
