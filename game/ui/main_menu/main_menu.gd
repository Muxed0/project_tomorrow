extends Control

var world_data = 0
var player_data = 0

func _ready():
	world_data = get_node("/root/WorldData")
	player_data = get_node("/root/PlayerData")

func _on_Button_pressed():
	if player_data.ship_type and world_data.current_stage:
		get_tree().change_scene("res://world/battle/battle_stage.tscn")

func _on_ship1_select_button_button_down():
	$"/root/PlayerData".ship_type = 1
	$ship2_select_button.pressed = false


func _on_ship2_select_button_button_down():
	$"/root/PlayerData".ship_type = 2
	$ship1_select_button.pressed = false

func _on_planet1_select_pressed():
	$"/root/WorldData".current_stage = 1
	$planet2_select.pressed = false

func _on_planet2_select_pressed():
	$"/root/WorldData".current_stage = 2
	$planet1_select.pressed = false


