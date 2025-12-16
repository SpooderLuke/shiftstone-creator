extends Panel
var targetObject : Node3D

func update_vals(obj : Node3D):
	targetObject = null
	$VSplitContainer/Panel2/ScrollContainer/VBoxContainer/LineEdit.text = obj.id
	
	$VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer/SpinBox.value = obj.global_position.x
	$VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer/SpinBox2.value = obj.global_position.y
	$VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer/SpinBox3.value = obj.global_position.z
	
	$VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer2/SpinBox.value = obj.global_rotation_degrees.x
	$VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer2/SpinBox2.value = obj.global_rotation_degrees.y
	$VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer2/SpinBox3.value = obj.global_rotation_degrees.z
	
	$VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer3/SpinBox.value = obj.scale.x
	$VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer3/SpinBox2.value = obj.scale.y
	$VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer3/SpinBox3.value = obj.scale.z
	
	$VSplitContainer/Panel2/ScrollContainer/VBoxContainer/CheckButton.button_pressed = obj.shiftstone_material
	
	$VSplitContainer/Panel2/ScrollContainer/VBoxContainer/ColorPickerButton.color = obj.albedo
	$VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HSlider.value = obj.metallic
	$VSplitContainer/Panel2/ScrollContainer/VBoxContainer/ColorPickerButton2.color = obj.emmision
	$VSplitContainer/Panel2/ScrollContainer/VBoxContainer/SpinBox.value = obj.emmision_strength

func _physics_process(delta: float) -> void:
	if targetObject:
		_apply_vals()
	$"../../Camera3D".fov = $"../VSlider".value

func _apply_vals(): #if youre reading this im sorry for the atrocities i just commited and am about to commit
	targetObject.id = $VSplitContainer/Panel2/ScrollContainer/VBoxContainer/LineEdit.text 
	
	targetObject.global_position.x = $VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer/SpinBox.value
	targetObject.global_position.y = $VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer/SpinBox2.value
	targetObject.global_position.z = $VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer/SpinBox3.value
	
	targetObject.global_rotation_degrees.x = $VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer2/SpinBox.value
	targetObject.global_rotation_degrees.y = $VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer2/SpinBox2.value
	targetObject.global_rotation_degrees.z = $VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer2/SpinBox3.value
	
	targetObject.scale.x = $VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer3/SpinBox.value
	targetObject.scale.y = $VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer3/SpinBox2.value
	targetObject.scale.z = $VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HBoxContainer3/SpinBox3.value
	
	targetObject.shiftstone_material = $VSplitContainer/Panel2/ScrollContainer/VBoxContainer/CheckButton.button_pressed
	
	targetObject.albedo = $VSplitContainer/Panel2/ScrollContainer/VBoxContainer/ColorPickerButton.color
	targetObject.metallic = $VSplitContainer/Panel2/ScrollContainer/VBoxContainer/HSlider.value
	targetObject.emmision = $VSplitContainer/Panel2/ScrollContainer/VBoxContainer/ColorPickerButton2.color
	targetObject.emmision_strength = $VSplitContainer/Panel2/ScrollContainer/VBoxContainer/SpinBox.value


func _on_add_object_button_pressed() -> void:
	load_and_list_meshes()

func _collect_meshes(node: Node, out: Array):
	if node is MeshInstance3D and node.mesh:
		out.append({
			"name": node.name,
			"mesh": node.mesh
		})

	for child in node.get_children():
		_collect_meshes(child, out)

var loaded_meshes := [
	SphereMesh.new(),
	BoxMesh.new(),
	CylinderMesh.new(),
	CapsuleMesh.new()
]

func load_and_list_meshes():
	$"../MeshPicker".visible = true
func apply_selected_mesh():
	var idx = $"../MeshPicker".selected
	if idx < 0:
		return
	var m = MeshInstance3D.new()
	m.mesh = loaded_meshes[idx]
	m.set_script(load("res://Object.gd"))
	m.mesh_reference = $"../MeshPicker".text
	m.id = $"../MeshPicker".text
	$"../../Exporter/GameObjects".add_child(m)
	
	var b = load("res://tree_button.tscn").instantiate()
	b.get_child(0).Obj = m
	$VSplitContainer/Panel/ScrollContainer/VBoxContainer.add_child(b)
	b.get_node("Button")._pressed()
	$"../MeshPicker".visible = false
