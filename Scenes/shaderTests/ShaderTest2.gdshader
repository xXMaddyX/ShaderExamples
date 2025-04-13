shader_type canvas_item;

uniform float afactor;
uniform float bfactor;

void fragment() {
	if (COLOR.a > 0.0) {
		float uv1 = UV.x + 1.0;
		float uv2 = UV.y + 1.0;

		float newA = uv1 * afactor;
		float newB = uv2 * bfactor;

		COLOR.agb = vec3(newA, newB, newB * COLOR.b);
	}
}
