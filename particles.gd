extends CPUParticles3D
enum ParticleType{
	BURST,
	DRIP,
	RISE,
	FIZZLE,
	SUCK,
}
@export var type : ParticleType
@export var p_amount : int
@export var p_color: Color
