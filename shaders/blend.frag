#pragma header

//https://www.shadertoy.com/view/Md3GzX
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define iChannel1 bitmap
#define iChannel2 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main


vec3 overlay(in vec3 src, in vec3 dst)
{
    return mix(2.0 * src * dst, 1.0 - 2.0 * (1.0 - src) * (1.0-dst), step(0.5, dst));
}

// MAIN

void main()
{
	//vec2 uv = fragCoord.xy / iResolution.xy;
    
    // Blending
	int mode = int(flixel_texture2D(bitmap, vec2(0.0, 0.0)).x);
    vec3 src = flixel_texture2D(iChannel1, uv).xyz; // Top layer
    vec3 dst = flixel_texture2D(iChannel2, uv).xyz; // Bottom layer
    
    fragColor.xyz = overlay(src, dst);
}
