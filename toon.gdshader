shader_type spatial;
render_mode cull_back, depth_draw_opaque;

uniform vec4 base_color : source_color = vec4(1.0, 0.8, 0.2, 1.0);
uniform float levels = 5;

void fragment() {
	ALBEDO = base_color.rgb;
	ROUGHNESS = 1.0;
	METALLIC = 0.0;
}

void light() {
	float ndotl = max(dot(NORMAL, LIGHT), 0.0)* ATTENUATION;
    ndotl = clamp(ndotl, 0.0, 1.0);

    float stepped = floor(ndotl * levels) / levels;

    DIFFUSE_LIGHT += LIGHT_COLOR * stepped;
}
