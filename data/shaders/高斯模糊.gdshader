shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_linear_mipmap;
uniform float blur_intensity : hint_range(0, 10) = 2.0;

void fragment() {
	COLOR.rgb=texture(screen_texture,SCREEN_UV,blur_intensity).rgb;
}
