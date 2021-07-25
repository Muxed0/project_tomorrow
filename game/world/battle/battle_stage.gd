extends Node2D

var player_data = 0
var spatial_cam = 0

var avg_delta = 0
var total_delta = 0
var frame_count = 0

var ship_to_entity = Vector3(0,0,0)
var ship_to_entity_2d = Vector2(0,0)
var ship_to_entity_2d_pix_length = 0
var ship_to_entity_2d_dir = Vector2(0,0)
#Two arrays to hold 3D areas from the spatial map and the attached 2D entities
#for permanent entities
var perm_area_array = []
var perm_entity_array = []

func _input(event):
	if Input.is_key_pressed(KEY_C):
		if $player_cam.is_current():
			$debug_2D.current = true
		elif $debug_2D.is_current():
			$player_cam.current = true

func _ready():
	player_data = get_node("/root/PlayerData")
	spatial_cam = get_node("3D_viewport/spatial_map/3D_cam")

func _process(delta):
	#Smoothing out the delta value for use in positioning permanent entities and returning follower entities.
	#Do NOT use the raw delta value or entities' position will stutter, use avg_delta instead
	if frame_count < 120:
		frame_count += 1
	else:
		total_delta = total_delta - avg_delta
	total_delta += delta
	avg_delta = (total_delta)/frame_count
	
	#Cycles through the array of 2D permanent entities to be rendered and places
	#them according to the ship's position to coincide with spatial meshes
	for i in perm_entity_array.size():
		ship_to_entity = spatial_cam.transform.basis * (spatial_cam.translation - perm_area_array[i].translation)
		ship_to_entity_2d = Vector2(ship_to_entity.x,ship_to_entity.y)
		ship_to_entity_2d_pix_length = ship_to_entity_2d.length()* avg_delta * spatial_cam.SPEED_SCALE
		ship_to_entity_2d_dir = ship_to_entity_2d.normalized()
		perm_entity_array[i].position = $player_ship.position + Vector2(ship_to_entity_2d_dir.y * ship_to_entity_2d_pix_length, -ship_to_entity_2d_dir.x * ship_to_entity_2d_pix_length)
		$debug_vector.set_point_position(1,perm_entity_array[0].position)

func _on_render_box_area_entered(area):
	perm_area_array.append(area)
	perm_entity_array.append(area.entity2D.instance())
	add_child(perm_entity_array[perm_entity_array.size() - 1])
	print(perm_entity_array[perm_entity_array.size()-1]," ready to render! ")

func _on_render_box_area_exited(area):
	print(perm_entity_array[perm_entity_array.size()-1]," No longer rendered! ")
	var remove_index = perm_area_array.find(area)
	perm_entity_array.remove(remove_index)
	perm_area_array.remove(remove_index)
