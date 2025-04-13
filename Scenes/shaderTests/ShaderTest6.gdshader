shader_type canvas_item;

uniform sampler2D distortion;
uniform float strength = 0.1;
uniform float speed = 1.0;
uniform float zoom = 1.1;

void fragment() {
    float time = TIME * speed;

	vec2 center = vec2(0.5);
	vec2 centered_uv = UV - center;
	vec2 zoomed_uv = centered_uv / zoom + center;

    vec2 distortion1 = texture(distortion, zoomed_uv + vec2(time * 0.5, time * 0.7)).rg * 2.0 - 1.0;
    vec2 distortion2 = texture(distortion, zoomed_uv * 1.5 + vec2(time * -0.2, time * 0.2)).rg * 2.0 - 1.0;

    vec2 total_distortion = (distortion1 + distortion2) * strength;
    float wave = sin(zoomed_uv.y * 10.0 + time * 3.0) * 0.05;
	if (COLOR.a > 0.0) {
	    vec2 distorted_uv = zoomed_uv * 1.2 + total_distortion + vec2(wave);
	    COLOR = texture(TEXTURE, distorted_uv);

	}
}