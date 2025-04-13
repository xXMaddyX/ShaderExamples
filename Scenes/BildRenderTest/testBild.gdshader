shader_type canvas_item;

uniform float frequenz = 60.0;

void fragment() {
	vec2 uv = UV;
	vec4 myTex = texture(TEXTURE, UV);
	if (myTex.a > 0.0) {
		uv.x -= clamp(sin(uv.y * 3.0 + TIME), 0.0, 1.0) * 1.0;
		//uv.x += sin(uv.y * 60.0 * 30.0 + TIME) * 0.001;
		
		COLOR.rgb = texture(TEXTURE, uv).rgb;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
