shader_type canvas_item;

uniform float rotation_speed : hint_range(0.0, 10.0) = 1.0;
uniform vec2 center = vec2(0.5, 0.5);

void vertex() {
	vec2 centered_vertex = VERTEX - UV;
	vec2 pivot = center * UV;
	centered_vertex = VERTEX - pivot;

	float angle = atan(centered_vertex.y, centered_vertex.x);
	float rotated_angle = angle + TIME * rotation_speed;

	float radius = length(centered_vertex);
	float new_x = cos(rotated_angle) * radius;
	float new_y = sin(rotated_angle) * radius;

	VERTEX = vec2(new_x, new_y) + pivot;
}
