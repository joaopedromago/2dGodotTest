extends Button


func _ready():
	self.pressed.connect(self._button_pressed)


func _process(delta):
	pass


func _button_pressed():
	var gameScene = "res://scenes/menu.tscn"
	get_tree().change_scene_to_file(gameScene)
