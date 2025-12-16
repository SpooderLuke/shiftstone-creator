extends Panel
@onready var trail := $"../../Exporter/Features/Unused/Trail"
@onready var particles := $"../../Exporter/Features/Unused/Particles"
@onready var act_particles := $"../../Exporter/Features/Unused/ActivateParticles"

func _physics_process(delta: float) -> void:
	trail.start_color = $ScrollContainer/VBoxContainer/ColorPickerButton.color
	trail.end_color = $ScrollContainer/VBoxContainer/ColorPickerButton2.color
	trail.width = $ScrollContainer/VBoxContainer/SpinBox.value
	
	particles.type = $ScrollContainer/VBoxContainer/OptionButton.selected
	particles.color = $ScrollContainer/VBoxContainer/ColorPickerButton3.color
	particles.amount = $ScrollContainer/VBoxContainer/SpinBox2.value + 1
	
	act_particles.type = $ScrollContainer/VBoxContainer/OptionButton2.selected
	act_particles.color = $ScrollContainer/VBoxContainer/ColorPickerButton4.color
	act_particles.amount = $ScrollContainer/VBoxContainer/SpinBox3.value + 1
