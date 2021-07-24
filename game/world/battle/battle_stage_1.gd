extends Node2D

var player = 0
var player_pos = Vector2(0,0)
var p = 0
var smo = Vector3(0,0,0)
var smo2 = 0
var whatever = Vector2(0,0)

var entity_array = []

func _input(event):
	if Input.is_key_pressed(KEY_C):
		if $player_cam.is_current():
			$debug_2D.current = true
		elif $debug_2D.is_current():
			$player_cam.current = true

func _ready():
	player = get_node("player_ship")

func _process(delta):
	player_pos = $player_ship.position
	$player_cam.position = player_pos
	$background.position = player_pos

	var texture = $"3D_viewport".get_texture()
	$background.texture = texture
	
	if entity_array.size():
		smo = $"3D_viewport/Spatial/3D_cam".translation - entity_array[0].translation
		#print($"3D_viewport/Spatial/3D_cam".translation.length(),",",entity_array[0].translation.length())
		#p = smo.length()/2 * asin(smo.length()/(2*7)) * delta * $"3D_viewport/Spatial/3D_cam".SPEED_SCALE
		smo2 = smo.length()* delta * $"3D_viewport/Spatial/3D_cam".SPEED_SCALE
		smo = $"3D_viewport/Spatial/3D_cam".transform.basis * smo
		whatever = Vector2(smo.x,smo.y).normalized()
		$debug_vector.set_point_position(1,$player_ship.position + Vector2(whatever.x * smo2, -whatever.y * smo2))
		$Moon.position = $player_ship.position + Vector2(whatever.x * smo2, -whatever.y * smo2)
		print(smo.length(),",",Vector2(whatever.x * smo2, -whatever.y * smo2))
		#print($Moon.position)
	
	
func _on_3D_cam_wrap_x():
	$"3D_viewport/3D_scene/3D_cam".rotation.x = 0

func _on_3D_cam_wrap_y():
	$"3D_viewport/3D_scene/3D_cam".rotation.y = 0


func _on_render_box_area_entered(area):
	entity_array.append(area)
	#print(entity_array[entity_array.size()-1]," ready to render! ", area.translation)
