extends MeshInstance3D
@export var id : String

@export var mesh_reference : String
@export var albedo : Color = Color.WHITE
@export_range(0,1) var metallic : float
@export var emmision : Color
@export var emmision_strength : float
enum shadertype {
	DEFAULT,
	SHIFTSTONE,
	TOON,
}
@export var shader := shadertype.DEFAULT

func _ready() -> void:
	var mat : StandardMaterial3D
	mat = StandardMaterial3D.new()
	var shiftmat := load("res://shiftstone.tres").duplicate()
	var toonnmat := load("res://toon.tres").duplicate()
	material_override = mat
	while is_inside_tree():
		await get_tree().create_timer(0.3).timeout
		if shader == shadertype.DEFAULT:
			material_override = mat
			mat.albedo_color = albedo
			mat.metallic = metallic
			mat.roughness = 0
			mat.emission_enabled = emmision != Color.BLACK
			mat.emission = emmision
			mat.emission_energy_multiplier = emmision_strength
		elif shader == shadertype.SHIFTSTONE:
			material_override = shiftmat
			shiftmat.set_shader_parameter("crystal_color",Color.AQUA)
		elif shader == shadertype.TOON:
			material_override = toonnmat
			toonnmat.set_shader_parameter("base_color",albedo)
