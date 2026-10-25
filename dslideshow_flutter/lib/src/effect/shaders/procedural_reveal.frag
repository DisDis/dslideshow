#version 460 core
#include <flutter/runtime_effect.glsl>
uniform vec2 uSize;
uniform float uProgress;
uniform float uSeed;
uniform float uKind;
out vec4 fragColor;

float hash(vec2 p) {
  vec3 v = fract(vec3(p.xyx) * 0.1031);
  v += dot(v, v.yzx + 33.33);
  return fract((v.x + v.y) * v.z);
}

float noise(vec2 p) {
  vec2 i = floor(p);
  vec2 f = fract(p);
  f = f * f * (3.0 - 2.0 * f);
  return mix(mix(hash(i), hash(i + vec2(1.0, 0.0)), f.x),
             mix(hash(i + vec2(0.0, 1.0)), hash(i + vec2(1.0)), f.x), f.y);
}

void main() {
  vec2 xy = FlutterFragCoord().xy;
  float alpha;
  if (uKind < 0.5) {
    vec2 p = xy / min(uSize.x, uSize.y) * 28.0;
    p += vec2(uSeed * 0.03125, uSeed * 0.015625);
    float threshold = 0.65 * noise(p) + 0.35 * noise(p * 2.03 + vec2(7.2, 3.1));
    alpha = 1.0 - smoothstep(threshold - 0.08, threshold + 0.08,
                             uProgress * 1.16 - 0.08);
  } else if (uKind < 1.5) {
    float radius = length(xy - uSize * 0.5) / (length(uSize) * 0.5);
    float front = uProgress * 1.05 - 0.025;
    float wave = 0.045 * sin(3.14159265359 * uProgress)
        * sin(82.0 * (radius - front) - 18.8495559215 * uProgress);
    alpha = smoothstep(front - 0.025, front + 0.025, radius + wave);
  } else {
    float radius = length(xy - uSize * 0.5) / (length(uSize) * 0.5);
    float front = uProgress * 1.08 - 0.04;
    alpha = smoothstep(front - 0.04, front + 0.04, radius);
  }
  fragColor = vec4(alpha);
}
