shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform float lerp_percent : hint_range(0.0, 1.0);

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	vec4 final_color = mix(texture_color, vec4(1.0, 0.2, 0.2, texture_color.a), lerp_percent);
	COLOR = final_color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
