shader_type canvas_item;

uniform sampler2D mask_texture;
uniform sampler2D blackOverlay;
uniform float speed = 1.0;
uniform float scale = 1.0;

void fragment() {
    vec2 uv = UV;
    float offset = TIME * speed;
    uv.x = mod(uv.x + offset, 1.0);
    vec4 color1 = texture(TEXTURE, uv);

    vec4 mask_color = texture(mask_texture, UV);
    float mask_value = mask_color.r * scale;

    vec4 blackImage = texture(blackOverlay, UV); // Das Schwarzbild-Overlay

    blackImage.a *= (1.0 - mask_value);

    COLOR = mix(blackImage, color1, blackImage.a);
}