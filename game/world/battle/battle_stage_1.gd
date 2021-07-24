extends Node2D

#This 

var player = 0
var player_pos = Vector2(0,0)
var p = 0
var smo = Vector3(0,0,0)
var smo_cam = Vector3(0,0,0)
var smo2 = 0
var smo2_length = Vector2(0,0)
var whatever = Vector2(0,0)
var ship_vector_pos = Vector3(0,0,0)

var avg_delta = 0
var total_delta = 0
var frame_count = 0

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
	
	if frame_count < 120:
		frame_count += 1
	else:
		total_delta = total_delta - avg_delta
	total_delta += delta
	avg_delta = (total_delta)/frame_count
	
	player_pos = $player_ship.position
	$player_cam.position = player_pos
	$background.position = player_pos

	var texture = $"3D_viewport".get_texture()
	$background.texture = texture
	
	if entity_array.size():
		ship_vector_pos = $"3D_viewport/Spatial/3D_cam".translation + $"3D_viewport/Spatial/3D_cam".transform.basis * $"3D_viewport/Spatial/3D_cam/render_box".translation
		smo = ship_vector_pos - entity_array[0].translation
		smo_cam = $"3D_viewport/Spatial/3D_cam".transform.basis * smo
		smo2 = Vector2(smo_cam.x,smo_cam.y)
		smo2_length = smo2.length()* avg_delta * $"3D_viewport/Spatial/3D_cam".SPEED_SCALE
		whatever = Vector2(smo_cam.x,smo_cam.y).normalized()
		$debug_vector.set_point_position(1,$player_ship.position + Vector2(whatever.y * smo2_length, -whatever.x * smo2_length))
		$Moon.position = $player_ship.position + Vector2(whatever.y * smo2_length, -whatever.x * smo2_length)
		print(avg_delta)
	
	
func _on_3D_cam_wrap_x():
	$"3D_viewport/3D_scene/3D_cam".rotation.x = 0

func _on_3D_cam_wrap_y():
	$"3D_viewport/3D_scene/3D_cam".rotation.y = 0


func _on_render_box_area_entered(area):
	entity_array.append(area)
	print(entity_array[entity_array.size()-1]," ready to render! ")
