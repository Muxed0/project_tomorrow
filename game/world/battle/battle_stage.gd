extends Node2D

var player_data = 0
var world_data = 0
var stage = 0
var stage_instance = 0
var spatial_cam = 0

var avg_delta = 0
var total_delta = 0
var frame_count = 0

var inverse_cam_transform = 0
var ship_to_entity = Vector3(0,0,0)
var ship_to_entity_2d = Vector2(0,0)
var ship_to_entity_2d_pix_length = 0
var ship_to_entity_2d_dir = Vector2(0,0)
#Two arrays to hold 3D areas from the spatial map and the attached 2D entities
#for permanent entities
var perm_area_array = []
var perm_entity_array = []

var debug_y_axis

func _input(event):
	if Input.is_key_pressed(KEY_C):
		if $player_cam.is_current():
			$debug_2D.current = true
		elif $debug_2D.is_current():
			$player_cam.current = true
			
func _enter_tree():
	player_data = get_node("/root/PlayerData")
	world_data = get_node("/root/WorldData")
	spatial_cam = get_node("3D_viewport/spatial_map/3D_cam")
	
	match world_data.current_stage:
		1:
			stage = load("res://world/places/3D_place_1.tscn")
		2:
			stage = load("res://world/places/3D_place_2.tscn")
	stage_instance = stage.instance()
	$"3D_viewport/spatial_map".add_child(stage_instance)
	world_data.spatial_cam_radius = stage_instance.radius

func _ready():
	stage_instance.connect("in_sight", self, "_on_battle_stage_in_sight")
	stage_instance.connect("out_sight", self, "_on_battle_stage_out_sight")   
	
	$debug_y_vector.set_point_position(0, $player_ship.position)

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
		inverse_cam_transform = spatial_cam.transform.inverse()
		ship_to_entity = inverse_cam_transform.basis * (perm_area_array[i].translation - spatial_cam.translation)
		ship_to_entity_2d = Vector2(ship_to_entity.x, -ship_to_entity.y)
		ship_to_entity_2d_pix_length = ship_to_entity_2d.length()* avg_delta * spatial_cam.SPEED_SCALE
		ship_to_entity_2d_dir = ship_to_entity_2d.normalized()
		perm_entity_array[i].position = $player_ship.position + Vector2(ship_to_entity_2d_dir.x * ship_to_entity_2d_pix_length, ship_to_entity_2d_dir.y * ship_to_entity_2d_pix_length)
		$debug_vector.set_point_position(1,perm_entity_array[0].position)
	
	$debug_y_vector.set_point_position(0, $player_ship.position)
	debug_y_axis = spatial_cam.transform.basis * Vector3(0,1000,0)
	$debug_y_vector.set_point_position(1, Vector2(debug_y_axis.x,-debug_y_axis.y)+$player_ship.position)
	
func _on_battle_stage_in_sight(type, area3D, entity2D):
	if type == 1:
		perm_area_array.append(area3D)
		perm_entity_array.append(entity2D.instance())
		add_child(perm_entity_array[perm_entity_array.size() - 1])

func _on_battle_stage_out_sight(type, area3D):
	if type == 1:
		var remove_index = perm_area_array.find(area3D)
		perm_entity_array[remove_index].queue_free()
		perm_entity_array.remove(remove_index)
		perm_area_array.remove(remove_index)
