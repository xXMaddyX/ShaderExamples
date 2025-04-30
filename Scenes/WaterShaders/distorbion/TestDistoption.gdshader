shader_type canvas_item;

uniform sampler2D distMap;
uniform float strength = 0.01;
uniform vec2 scroll_speed = vec2(0.1, 0.1);

void fragment() {
	vec2 base_uv = UV;

	vec2 dist_uv = fract(base_uv + TIME * 0.03 * scroll_speed);
	vec4 distortion = texture(distMap, dist_uv);

	// Verwende rot/grün-Kanäle für die Verzerrung, skaliert auf [-1,1]
	vec2 offset = (distortion.rg * 2.0 - 1.0) * strength;

	vec4 final_color = texture(TEXTURE, base_uv + offset);

	COLOR = final_color;
}


