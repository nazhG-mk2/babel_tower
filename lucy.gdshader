shader_type spatial;

void fragment() {
    vec3 view_dir = normalize(VIEW);
    float angle = dot(NORMAL, view_dir);
    
    if (angle < 0.3) { // Ajusta el umbral para controlar el grosor
        ALBEDO = vec3(0.0); // Negro para los bordes
    } else {
        ALBEDO = vec3(1.0, 0.5, 0.7);
    }
}
