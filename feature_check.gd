extends CheckBox
@export var target : Node3D
@export var passive := true

func _pressed() -> void:
	if button_pressed:
		if passive:
			target.get_parent().remove_child(target)
			$"../../../../../Exporter/Features/Passive".add_child(target)
		else:
			target.get_parent().remove_child(target)
			$"../../../../../Exporter/Features/Activate".add_child(target)
	else:
		target.get_parent().remove_child(target)
		$"../../../../../Exporter/Features/Unused".add_child(target)
