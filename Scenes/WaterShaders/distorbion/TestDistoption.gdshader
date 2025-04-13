shader_type canvas_item;

uniform sampler2D distMap;
uniform float strength = 0.01;

void fragment() {
	vec2 base_uv = UV;

	// Sample die Distortion-Map
	vec2 dist_uv = base_uv + vec2(sin(TIME * 0.5), cos(TIME * 0.7)) * 0.05;
	vec4 distortion = texture(distMap, dist_uv);

	// Verwende rot/grün für UV-Offset (von [0,1] zu [-1,1])
	vec2 offset = (distortion.rg * 2.0 - 1.0) * strength;

	// Veränderte UV-Koordinate
	vec4 final_color = texture(TEXTURE, base_uv + offset);

	COLOR = final_color;
}

