extends Node3D
var data = {}
func export_pressed():
	$"../FileDialog".popup_centered()
	
func _export(path):
	data = {
	"version" : 2,
	"objects":[],
	"passive":[],
	"activate":[]
	}
	var Gameobjects := get_node("GameObjects").get_children()
	for i in Gameobjects:
		if i.get_script() == load("res://Object.gd"):
			data["objects"].append(object_load(i))

	var Passives := get_node("Features/Passive").get_children()
	for i in Passives:
		if i.get_script() == load("res://trail.gd"):
			data["passive"].append(load_trail(i))
		elif i.get_script() == load("res://particles.gd"):
			data["passive"].append(load_particles(i))
		#elif i is AudioStreamPlayer3D:
			#data["passive"].append(load_sound(i))
		elif i.get_script() == load("res://animation.gd"):
			data["passive"].append(load_anim(i))

	var Activates := get_node("Features/Activate").get_children()
	for i in Activates:
		if i.get_script() == load("res://trail.gd"):
			data["activate"].append(load_trail(i))
		elif i.get_script() == load("res://particles.gd"):
			data["activate"].append(load_particles(i))
		#elif i is AudioStreamPlayer3D:
			#data["activate"].append(load_sound(i))
		elif i.get_script() == load("res://animation.gd"):
			data["activate"].append(load_anim(i))

	finalize(path)

func finalize(p):
	FileAccess.open(p, FileAccess.WRITE).store_string(JSON.stringify(data, "\t"))

func object_load(object : Node3D) -> Dictionary:
	var obj_data = {}
	obj_data["id"] = object.id
	var transform_data = {}
	transform_data["position"] = _vec(object.global_position)
	transform_data["rotation"] = _vec(object.global_rotation_degrees)
	transform_data["scale"] = _vec(object.scale)
	obj_data["transform"] = transform_data
	
	obj_data["albedo"] = _col(object.albedo)
	obj_data["metallic"] = object.metallic
	obj_data["emmision"] = _col(object.emmision)
	obj_data["emmision_strength"] = object.emmision_strength
	
	obj_data["shader"] = object.shader
	
	return obj_data

func load_trail(object):
	var obj_data = {
		"type":"trail"
	}
	obj_data["start_color"] = _col(object.start_color)
	obj_data["end_color"] = _col(object.end_color)
	obj_data["width"] = object.width
	
	return obj_data

func load_particles(object):
	var obj_data ={
		"type":"particles"
	}
	obj_data["particle_type"] = object.type
	obj_data["amount"] = object.p_amount
	obj_data["color"] = _col(object.p_color)
	
	return obj_data

#func load_sound(object : AudioStreamPlayer3D):
	#var obj_data = {
		#"type":"sound"
	#}
	#obj_data["sound_path"] = object.stream.resource_path
	#obj_data["volume"] = object.volume_db
	#
	#return obj_data

func load_anim(object):
	var obj_data ={
		"type":"anim",
		"movements":[]
	}
	for i in object.movements:
		obj_data["movements"].append(serialize_movement(i))
	
	return obj_data

func serialize_movement(move: Movement) -> Dictionary:
	return {
		"target": move.target_id,
		"position": _vec(move.pos),
		"rotation": _vec(move.rot),
		"scale": _vec(move.scale),
		"speed": move.speed,
		"duration": move.duration
	}

func _vec(v: Vector3) -> Array:
	return [v.x, v.y, v.z]
func _col(v: Color) -> Array:
	return [v.r, v.g, v.b, v.a]

func _export_single_mesh(mesh: MeshInstance3D, path: String) -> void:
	var gltf := GLTFDocument.new()
	var state := GLTFState.new()

	gltf.append_from_scene(mesh, state)
	gltf.write_to_filesystem(state, path)
