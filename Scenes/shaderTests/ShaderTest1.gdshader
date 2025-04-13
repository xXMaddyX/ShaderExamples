shader_type canvas_item;

uniform float delta;
uniform float skew;
uniform float tilt;

void fragment() {
	if (COLOR.a > 0.0) {
		vec4 uv = texture(TEXTURE, UV);
		COLOR.rgb -= vec3(UV, (uv.x -= tilt) - delta);
		COLOR.rgb -= vec3(UV.y - delta);
	};
}

void vertex() {
	float offset = skew * (UV.x -1.0);
	VERTEX.x += offset;
}
