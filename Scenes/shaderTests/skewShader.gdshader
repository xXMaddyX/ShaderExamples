shader_type canvas_item;

uniform float skew = 150.0;
uniform float time_scale;

void vertex() {
	float verX = VERTEX.x;
	float verY = VERTEX.y;
	if (VERTEX.y < 0.5) {
		verX += sin(TIME * time_scale) * skew;
	}
	if (VERTEX.x < 0.5) {
		verY -= sin(TIME * time_scale) * skew;
	}
	if (VERTEX.y > 0.5) {
		verX -= sin(TIME * time_scale) * skew;
	}
	
	VERTEX.x = verX;
	VERTEX.y = verY;
	
}

void fragment() {
	vec4 uv = texture(TEXTURE, UV);
	if (uv.b > 0.4 && uv.r < 0.8) {
		uv.b = sin(TIME * 0.5);
		uv.g = sin(TIME * 0.2);
	}
	
	COLOR = uv;
}
