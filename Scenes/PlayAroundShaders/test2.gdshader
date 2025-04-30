shader_type canvas_item;

uniform mat3 texture_matrix;
uniform sampler2D overlay;

uniform float disturbance;

void vertex() {
	vec3 vertexUV = vec3(VERTEX, 1.0);
	float changedUV = abs(sin(TIME) * 5.0);
	vertexUV.y -= changedUV * 50.0;
	VERTEX = vertexUV.xy;
}

void fragment() {
	vec2 uv = UV;
	vec4 tex = texture(TEXTURE, UV);
	vec4 textOver_uv = texture(overlay, vec2(uv.x * 1.0, uv.y * 1.0) * 1.0);
	
	if (tex.a > 0.0) {
		vec2 offset = abs(sin(TIME) * vec2(textOver_uv.x + disturbance, textOver_uv.y + disturbance));
		vec4 mainText = texture(TEXTURE, offset);
		COLOR = mainText;
		
	}
}
