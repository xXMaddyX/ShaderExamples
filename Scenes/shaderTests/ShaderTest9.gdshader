shader_type canvas_item;

uniform float time_scale = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float offest = TIME * time_scale;
	vec2 uv = UV;
	if (COLOR.a > 0.0) {
		uv.x = mod(uv.x - offest, 1.0);
		uv.y = mod(uv.y - offest, 1.0);
	}
	
	COLOR = texture(TEXTURE, uv);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
