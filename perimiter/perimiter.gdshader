shader_type canvas_item;

uniform sampler2D color_gradient;
uniform sampler2D noiseTexture;
uniform float speed: hint_range (0.0,5.0);
uniform float variation: hint_range (0.0,1.0);
uniform float width: hint_range (0.0,1.0);

void fragment(){
	vec2 fake_UV = vec2(abs(0.5 - UV.y), COLOR.a + speed);
	vec2 noise_uv = vec2(fake_UV.x+TIME*speed, fake_UV.y-TIME*speed);
	float noise_sample = texture(noiseTexture, noise_uv).r;
	float x_offset = noise_sample*variation - variation/2.0;
	COLOR = texture(color_gradient, vec2((fake_UV.x-0.5)/width + 0.5 + x_offset/width, fake_UV.y));
}