extends Spatial

var moon_area = 0
var moon_entity2D = preload("res://entities/trash/Moon01.tscn")
#In sight signal should hold: 
#For permanent entities: 1, area
#For follower entities: 2, 
signal in_sight
signal out_sight

func _ready():
	moon_area = get_node("moon_area")

func _on_moon_area_area_entered(area):
	print(moon_area)
	emit_signal("in_sight", 1, moon_area, moon_entity2D)


func _on_moon_area_area_exited(area):
	emit_signal("out_sight", 1, moon_area)
