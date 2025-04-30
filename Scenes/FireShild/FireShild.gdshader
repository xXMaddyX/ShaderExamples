shader_type spatial;
render_mode blend_mix;

uniform sampler2D noiseMap;
uniform float changeIntense = 0.5;

void fragment() {
	vec2 uv = UV;
	vec4 noiseTexture = texture(noiseMap, uv + vec2(TIME * 0.2, TIME * 0.4));
	vec3 baseColor = noiseTexture.rgb;

	// Farbverlauf: Gelb → Rot
	vec3 yellow = vec3(1.0, 1.0, 0.0);
	vec3 red = vec3(1.0, 0.0, 0.0);

	// smoothstep als Ersatz für den vorherigen pulse-Wert
	float t = smoothstep(0.0, 1.0, baseColor.r) * 1.1; // von schwarz (ausgeblendet) bis weiß (max Farbe)
	vec3 finalColor = mix(yellow, red, t); // Gelb → Rot nach Helligkeit

	if (baseColor.r < changeIntense) {
		ALPHA = 0.0;
		discard;
	} else {
		ALBEDO = finalColor;
		EMISSION = finalColor;
		ALPHA = 1.0;
	}
}