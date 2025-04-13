shader_type canvas_item;

uniform float speed = 0.5;
uniform float speedFactor = 5.0;
uniform float radius = 30.0;
uniform vec2 offset = vec2(5.0, 0.0);

void vertex() {
	float angel = TIME * speed;

	float offsetX = radius * cos(angel * offset.x);
	float offsetY = radius * sin(angel * speedFactor);

	VERTEX.x += offsetX;
	VERTEX.y += offsetY;
}