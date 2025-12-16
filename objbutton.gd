extends Button
@export var Obj : Node3D
func _pressed() -> void:
	$"../../../../../..".update_vals(Obj)
	$"../../../../../..".targetObject = Obj

func _process(delta: float) -> void:
	text = Obj.id

func _delete():
	Obj.queue_free()
	$"../../../../../..".targetObject = null
	get_parent().queue_free()
