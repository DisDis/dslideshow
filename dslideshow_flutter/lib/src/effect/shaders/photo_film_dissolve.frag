#version 460 core
#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform vec2 uFromSize;
uniform vec2 uToSize;
uniform vec3 uFromCamera;
uniform float uBlend;
uniform sampler2D uFrom;
uniform sampler2D uTo;
out vec4 fragColor;

vec3 photo(bool from, vec2 imageSize, vec2 position) {
  float fit = min(uSize.x / imageSize.x, uSize.y / imageSize.y);
  vec2 extent = imageSize * fit;
  vec2 uv = (position - (uSize - extent) * .5) / extent;
  if (uv.x < 0.0 || uv.y < 0.0 || uv.x > 1.0 || uv.y > 1.0) return vec3(0.0);
  vec2 tap = clamp(uv*imageSize, vec2(.5), imageSize-.5);
  // At the normal 1:1 prepared viewport mapping, this reads the original pixel
  // centre. A different aspect retains contain geometry and bilinear sampling.
  vec4 color = from ? texture(uFrom, tap/imageSize) : texture(uTo, tap/imageSize);
  return color.rgb; // premultiplied source over the original opaque black backing
}

vec3 toLinear(vec3 color) {
  return mix(pow((color+.055)/1.055, vec3(2.4)), color/12.92,
             lessThanEqual(color, vec3(.04045)));
}

vec3 toSrgb(vec3 color) {
  return mix(1.055*pow(color, vec3(1.0/2.4))-.055, color*12.92,
             lessThanEqual(color, vec3(.0031308)));
}

void main() {
  vec2 xy = FlutterFragCoord().xy;
  vec2 fromPosition = (xy-uSize*.5-uFromCamera.yz)/uFromCamera.x + uSize*.5;
  vec3 a = toLinear(photo(true, uFromSize, fromPosition));
  vec3 b = toLinear(photo(false, uToSize, xy));
  fragColor = vec4(toSrgb(mix(a, b, uBlend)), 1.0);
}
