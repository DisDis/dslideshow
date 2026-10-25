#version 460 core
#include <flutter/runtime_effect.glsl>
uniform vec2 uSize;
uniform float uProgress;
uniform vec2 uFromSize;
uniform vec2 uToSize;
uniform vec3 uFromCamera;
uniform sampler2D uFrom;
uniform sampler2D uTo;
out vec4 fragColor;

// Interpolating Catmull-Rom reconstruction preserves pixel centres exactly.
// All 16 taps are retained; no downsampled transition texture is used.
float cubic(float x) {
  x = abs(x);
  if (x < 1.0) return 1.5*x*x*x - 2.5*x*x + 1.0;
  if (x < 2.0) return -0.5*x*x*x + 2.5*x*x - 4.0*x + 2.0;
  return 0.0;
}

vec4 photo(bool from, vec2 imageSize, vec2 position) {
  position = clamp(position, vec2(0.5), uSize - 0.5);
  float fit = min(uSize.x / imageSize.x, uSize.y / imageSize.y);
  vec2 extent = imageSize * fit;
  vec2 origin = (uSize - extent) * 0.5;
  vec2 uv = (position - origin) / extent;
  if (uv.x < 0.0 || uv.y < 0.0 || uv.x > 1.0 || uv.y > 1.0) return vec4(0.0,0.0,0.0,1.0);
  vec2 p = uv * imageSize - 0.5;
  vec2 base = floor(p);
  vec2 f = p - base;
  vec4 color = vec4(0.0);
  for (int y = -1; y <= 2; y++) {
    for (int x = -1; x <= 2; x++) {
      vec2 tap = clamp(base + vec2(float(x), float(y)) + 0.5, vec2(0.5), imageSize - 0.5);
      vec4 pixel = from ? texture(uFrom, tap / imageSize) : texture(uTo, tap / imageSize);
      color += pixel * cubic(float(x)-f.x) * cubic(float(y)-f.y);
    }
  }
  // Match the black backing even when the source has transparent pixels.
  return vec4(clamp(color.rgb, 0.0, 1.0), 1.0);
}

void main() {
  vec2 xy = FlutterFragCoord().xy;
  vec2 delta = xy - uSize * 0.5;
  float diagonalRadius = length(uSize) * 0.5;
  float radius = length(delta) / diagonalRadius;
  float front = uProgress * 1.08 - 0.04;
  float distance = radius - front;
  float coverage = 1.0 - smoothstep(0.10, 0.20, abs(distance));
  if (coverage <= 0.0) {
    fragColor = vec4(0.0);
    return;
  }
  float envelope = sin(3.14159265359 * uProgress) * exp(-distance*distance / 0.008);
  vec2 direction = delta / max(length(delta), 0.0001);
  vec2 refraction = direction * (min(uSize.x,uSize.y) * 0.012)
      * envelope * sin(distance * 92.0 - uProgress * 12.5663706144);
  vec2 fromPosition = (xy + refraction - uSize*0.5 - uFromCamera.yz)
      / uFromCamera.x + uSize*0.5;
  vec4 a = photo(true,uFromSize,fromPosition);
  vec4 b = photo(false,uToSize,xy - refraction * 0.65);
  float reveal = 1.0 - smoothstep(front - 0.04, front + 0.04, radius);
  fragColor = mix(a,b,reveal) * coverage;
}
