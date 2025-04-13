shader_type canvas_item;

uniform float speed = 1.0;
uniform float speedFactor = 1.0;
uniform float radius = 30.0;
uniform vec2 offset = vec2(5.0, 0.0);
uniform float delta = 0.0;

void vertex() {
	float angel = TIME * speed;

	float offsetX = radius * cos(angel * offset.x);
	float offsetY = radius * sin(angel * speedFactor);

	VERTEX.x += offsetX;
	VERTEX.y += offsetY;
}

void fragment() {
	if (COLOR.a > 0.0) {
		vec4 uv = texture(TEXTURE, UV);
		COLOR.rgb -= vec3(UV, (uv.x -= 1.0) + delta);
		COLOR.rgb -= vec3(UV.y + delta);
	};
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
