shader_type canvas_item;

uniform float flash_amount : hint_range(0, 1) = 0.0; // Parámetro controlable desde código

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    vec3 red_tint = vec3(0.9, 0.2, 0.6); // Color del efecto
    color.rgb = mix(color.rgb, red_tint, flash_amount);
    COLOR = color;
}
