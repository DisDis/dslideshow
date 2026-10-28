#version 460 core
#include <flutter/runtime_effect.glsl>
uniform vec2 uSize;
uniform float uProgress;
uniform vec2 uFromSize;
uniform vec2 uToSize;
uniform vec3 uFromCamera;
uniform vec2 uOrigin;
uniform float uRefractionStrength;
uniform float uWaveFrequency;
uniform float uBandWidth;
uniform sampler2D uFrom;
uniform sampler2D uTo;
out vec4 fragColor;

// Interpolating Catmull-Rom reconstruction preserves pixel centres exactly.
// The two positive middle weights share one bilinear lookup per axis.
// Nine lookups retain all sixteen Catmull-Rom contributions, including the
// negative outer lobes. No downsampled transition texture is used.
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
  vec4 wx = vec4(cubic(-1.0-f.x), cubic(-f.x), cubic(1.0-f.x), cubic(2.0-f.x));
  vec4 wy = vec4(cubic(-1.0-f.y), cubic(-f.y), cubic(1.0-f.y), cubic(2.0-f.y));
  vec3 gx = vec3(wx.x, wx.y+wx.z, wx.w);
  vec3 gy = vec3(wy.x, wy.y+wy.z, wy.w);
  vec3 px = vec3(base.x-0.5, base.x+0.5+wx.z/gx.y, base.x+2.5);
  vec3 py = vec3(base.y-0.5, base.y+0.5+wy.z/gy.y, base.y+2.5);
  vec4 color = vec4(0.0);
  for (int y = 0; y < 3; y++) {
    for (int x = 0; x < 3; x++) {
      vec2 tap = clamp(vec2(px[x], py[y]), vec2(0.5), imageSize - 0.5);
      vec4 pixel = from ? texture(uFrom, tap / imageSize) : texture(uTo, tap / imageSize);
      color += pixel * gx[x] * gy[y];
    }
  }
  // Match the black backing even when the source has transparent pixels.
  return vec4(clamp(color.rgb, 0.0, 1.0), 1.0);
}

void main() {
  vec2 xy = FlutterFragCoord().xy;
  vec2 delta = xy - uOrigin;
  float diagonalRadius = max(length(max(uOrigin, uSize-uOrigin)), 0.0001);
  float radius = length(delta) / diagonalRadius;
  float front = uProgress * 1.08 - 0.04;
  float distance = radius - front;
  float coverage = 1.0 - smoothstep(0.10*uBandWidth, 0.20*uBandWidth, abs(distance));
  if (coverage <= 0.0) {
    fragColor = vec4(0.0);
    return;
  }
  float envelope = sin(3.14159265359 * uProgress) * exp(-distance*distance / (0.008*uBandWidth*uBandWidth));
  vec2 direction = delta / max(length(delta), 0.0001);
  vec2 refraction = direction * (min(uSize.x,uSize.y) * uRefractionStrength)
      * envelope * sin(distance * uWaveFrequency - uProgress * 12.5663706144);
  vec2 fromPosition = (xy + refraction - uSize*0.5 - uFromCamera.yz)
      / uFromCamera.x + uSize*0.5;
  float reveal = 1.0 - smoothstep(front - 0.04, front + 0.04, radius);
  // Most of the refracted band is wholly on one side of the reveal. Avoid
  // reconstructing an image whose exact blend weight is zero.
  if (reveal <= 0.0) {
    fragColor = photo(true,uFromSize,fromPosition) * coverage;
  } else if (reveal >= 1.0) {
    fragColor = photo(false,uToSize,xy - refraction * 0.65) * coverage;
  } else {
    vec4 a = photo(true,uFromSize,fromPosition);
    vec4 b = photo(false,uToSize,xy - refraction * 0.65);
    fragColor = mix(a,b,reveal) * coverage;
  }
}
