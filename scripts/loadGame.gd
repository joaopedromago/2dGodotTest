extends Node


func _ready():
	self.pressed.connect(self._button_pressed)


func _process(delta):
	pass


func _button_pressed():
	start_load_game()


func start_load_game():
	Globals.set_is_load(true)
	var gameScene = "res://scenes/game.tscn"
	get_tree().change_scene_to_file(gameScene)
