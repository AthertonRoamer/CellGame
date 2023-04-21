shader_type canvas_item;

uniform float alpha = 1.0;

void fragment() {
	vec4 c = texture(TEXTURE, UV);
	c.a = alpha;
	COLOR = c;
}
