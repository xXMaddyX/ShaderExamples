shader_type canvas_item;

uniform float time_scale = 0.01;
uniform float strength = 0.1;
uniform float zoom = 1.1;
uniform vec2 center = vec2(0.5, 0.5);
uniform float displace_factor = 0.05;

void fragment() {
	vec2 fraq_uv = UV;
	vec2 displace = normalize(fraq_uv - center) * displace_factor;
	COLOR = texture(TEXTURE, fraq_uv - displace);
}

/*void fragment() {
	float offest = TIME * time_scale;

	// Berechne die zentrierten UV-Koordinaten
	vec2 center = vec2(0.5);
	vec2 centered_uv = UV - center;

	// Skaliere die zentrierten UV-Koordinaten, um zu zoomen
	vec2 zoomed_uv = centered_uv / zoom + center;

	vec2 distortion1 = texture(TEXTURE, zoomed_uv + vec2(offest * 0.5, offest * 0.7)).rg * 2.0 - 1.0;
    vec2 distortion2 = texture(TEXTURE, zoomed_uv * 1.5 + vec2(offest * -0.2, offest * 0.2)).rg * 5.0 - 1.0;

	vec2 total_distortion = (distortion1 + distortion2) * strength;
    float wave = sin(zoomed_uv.y * 35.0 + offest * 4.0) * 0.01;

    vec2 distorted_uv = zoomed_uv + total_distortion + vec2(wave);

	COLOR = texture(TEXTURE, distorted_uv);
}*/