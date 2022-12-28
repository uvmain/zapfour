shader_type canvas_item;

uniform sampler2D noise_texture;
uniform float speed : hint_range(0.0, 10.0) = 0.4;
uniform float noise_strength : hint_range(0.0, 1.0) = 0.0;

uniform float shift = 0.0;
// ported from https://www.shadertoy.com/view/Nt23Wh


void fragment()
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = UV.xy / TEXTURE_PIXEL_SIZE * 3.0;
	
	float time = TIME + shift;

    // Time varying pixel color
    vec3 col1 = 0.5 + 0.5*cos((time*0.5)+uv.xyx+vec3(0,2,4));
    vec3 col2 = 0.5 + 0.5*sin((time*0.5)+uv.yxy+vec3(2,4,0));
    vec3 col3 = 0.5 + 0.5*cos((time*0.5)+uv.xyx+vec3(4,0,2));
    
    float clamp1 = clamp(sin(time * 0.75) * 0.1 + 0.5, 0.0, 1.0);
    float clamp2 = clamp(cos(time * 0.25) * 0.1 + 0.5, 0.0, 1.0);

    // Output to screen
    COLOR = vec4(mix(mix(col1, col2, clamp1), col3, clamp2),1.0);
	
	vec4 noise = texture(noise_texture, UV - TIME / (1.0f/speed));
	
	noise.a = clamp(noise.r * noise.r, 0.0f, 1.0f);
	
	COLOR.a = mix(COLOR.a, noise.a, noise_strength);
}