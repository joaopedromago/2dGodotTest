extends Node


func _ready():
	pass


func _process(delta):
	pass


func _on_start_game_pressed():
	Globals.set_is_load(false)
	start_game()


func _on_load_game_pressed():
	Globals.set_is_load(true)
	start_game()


func start_game():
	var gameScene = "res://scenes/game.tscn"
	get_tree().change_scene_to_file(gameScene)
