shader_type spatial;
render_mode unshaded, blend_add;

uniform sampler2D phoenix: filter_nearest;
uniform sampler2D white;

void vertex () {
	VERTEX *= 3.0;
	
	VERTEX += vec3(2.5, 0.0, 2.0);
	VERTEX.xy += vec2(VERTEX.x, VERTEX.y); 
}

void fragment() {
	vec2 uv = UV;
	vec4 phoenixTex = texture(phoenix, UV);
	vec4 blendColor = texture(white, UV);

	if (phoenixTex.a > 0.0 && UV.x < 0.15 && UV.y < 0.37) {
		blendColor.rgb = vec3(sin(TIME * 5.0) * 0.5) * 2.0;
	} else {
		ALPHA = 0.0;
	}
	
    ALBEDO = blendColor.rgb + phoenixTex.rgb;
}