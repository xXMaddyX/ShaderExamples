shader_type canvas_item;

uniform float increment = 0.01;

void fragment() {
    vec3 color = COLOR.rgb;
    if (COLOR.r > 0.0) {
        vec3 newColor = color.rgb + increment;
        COLOR.rgb = clamp(newColor, vec3(0.0), vec3(1.0));
    }
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
