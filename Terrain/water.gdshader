shader_type spatial;
render_mode diffuse_toon;

uniform sampler2D noise1 : repeat_enable;
uniform sampler2D noise2 : repeat_enable;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float frequency : hint_range(0,10) = .01;
uniform float xAmplitude : hint_range(0,50) = 10;
uniform float yAmplitude : hint_range(0,50) = 10;
uniform vec2 scroll[2];
uniform float distortion_strength : hint_range(-1, 1) = .02;
uniform vec3 tone_color : source_color;
uniform vec3 top_color : source_color;
uniform float light_start : hint_range(0.0, 1.0) = .275;
uniform float light_end : hint_range(0.0, 1.0) = .4;


void vertex() {
	VERTEX.y += cos((VERTEX.x + VERTEX.y * TIME) * frequency) * -xAmplitude;
	VERTEX.y += sin((VERTEX.z + TIME/3.0) * frequency) * yAmplitude;
}

void fragment() {
	float depth = texture(noise1, UV + scroll[0] * TIME).r * 
		texture(noise2, UV + scroll[1] * TIME).r;
	vec4 screen_col = texture(SCREEN_TEXTURE,
		SCREEN_UV + distortion_strength * vec2(depth));
	vec3 top_light = smoothstep(light_start, light_end, depth) * top_color;
	ALBEDO = vec3(screen_col[0], screen_col[1], 1) * tone_color + top_light;
}

