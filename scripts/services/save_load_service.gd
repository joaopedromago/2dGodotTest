class_name SaveLoadService


func load_game(this):
	if not FileAccess.file_exists(Globals.save_file):
		return

	var save_game = FileAccess.open(Globals.save_file, FileAccess.READ)

	var json_string = save_game.get_line()

	var json = JSON.new()
	var parse_result = json.parse(json_string)

	var node_data = json.get_data()

	var object = load(node_data["filename"])

	if !object:
		return

	var player = this.get_node(Globals.player_path)
	object.instantiate()
	player.position = Vector2(node_data["pos_x"], node_data["pos_y"])


func save_game(this):
	var save_game = FileAccess.open(Globals.save_file, FileAccess.WRITE)
	var save_nodes = this.get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		if node.scene_file_path.is_empty():
			continue

		if !node.has_method("save"):
			continue

		var node_data = node.call("save")

		var json_string = JSON.stringify(node_data)

		save_game.store_line(json_string)
