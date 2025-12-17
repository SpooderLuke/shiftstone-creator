shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, unshaded;

uniform vec4 crystal_color : source_color = vec4(0.3, 0.8, 1.0, 1.0);
uniform float pulse_speed = 2.0;
uniform float pulse_strength = 0.4;
uniform float crystal_sharpness = 20.0;

float hash(vec3 p) {
	return fract(sin(dot(p, vec3(12.9898, 78.233, 45.164))) * 43758.5453);
}

float crystal_noise(vec3 p) {
	vec3 ip = floor(p);
	vec3 fp = fract(p);

	fp = fp * fp * (3.0 - 2.0 * fp);

	float n =
		mix(
			mix(mix(hash(ip + vec3(0,0,0)), hash(ip + vec3(1,0,0)), fp.x),
			    mix(hash(ip + vec3(0,1,0)), hash(ip + vec3(1,1,0)), fp.x), fp.y),
			mix(mix(hash(ip + vec3(0,0,1)), hash(ip + vec3(1,0,1)), fp.x),
			    mix(hash(ip + vec3(0,1,1)), hash(ip + vec3(1,1,1)), fp.x), fp.y),
			fp.z
		);

	return pow(n, crystal_sharpness);
}

void fragment() {
	// Pulse
	float pulse = sin(TIME * pulse_speed) * 0.5 + 0.5;
	float pulse_mul = 1.0 + pulse * pulse_strength;

	// Crystal pattern
	float crystal = crystal_noise(NORMAL * 4.0 + UV.xyx * 2.0);

	// Fresnel highlight
	float fresnel = pow(1.0 - dot(NORMAL, VIEW), 3.0);

	vec3 color =
		crystal_color.rgb *
		pulse_mul *
		mix(0.6, 1.2, crystal);

	color += fresnel * 0.6;

	ALBEDO = color;
	ROUGHNESS = 0.15;
	METALLIC = 0.1;
}
