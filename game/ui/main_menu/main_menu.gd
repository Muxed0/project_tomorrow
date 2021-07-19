extends Control

func _on_Button_pressed():
	get_tree().change_scene("res://world/battle/battle_stage_1.tscn")


func _on_ship1_select_button_button_down():
	$"/root/ShipData".ship_type = 1
	$ship2_select_button.pressed = false


func _on_ship2_select_button_button_down():
	$"/root/ShipData".ship_type = 0
	$ship1_select_button.pressed = false
