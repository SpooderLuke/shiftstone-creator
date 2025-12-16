extends MeshInstance3D
@export var id : String

@export var mesh_reference : String
@export var albedo : Color
@export_range(0,1) var metallic : float
@export var emmision : Color
@export var emmision_strength : float

@export var shiftstone_material := false

func _ready() -> void:
	var mat : StandardMaterial3D
	mat = StandardMaterial3D.new()
	material_override = mat
	while is_inside_tree():
		await get_tree().create_timer(0.3).timeout
		mat.albedo_color = albedo
		mat.metallic = metallic
		mat.roughness = 0
		mat.emission_enabled = emmision != Color.BLACK
		mat.emission = emmision
		mat.emission_energy_multiplier = emmision_strength
