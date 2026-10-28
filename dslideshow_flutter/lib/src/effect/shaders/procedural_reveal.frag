#version 460 core
#include <flutter/runtime_effect.glsl>
uniform vec2 uSize;
uniform float uProgress;
uniform float uSeed;
uniform float uKind;
uniform vec2 uOrigin;
uniform float uNoiseScale;
uniform float uSoftness;
uniform float uWaveAmplitude;
uniform float uWaveFrequency;
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
    vec2 p = xy / min(uSize.x, uSize.y) * uNoiseScale;
    p += vec2(uSeed * 0.03125, uSeed * 0.015625);
    float threshold = 0.65 * noise(p) + 0.35 * noise(p * 2.03 + vec2(7.2, 3.1));
    alpha = 1.0 - smoothstep(threshold - uSoftness, threshold + uSoftness,
                             uProgress * (1.0 + 2.0*uSoftness) - uSoftness);
  } else if (uKind < 1.5) {
    float radius = length(xy - uOrigin) / max(length(max(uOrigin, uSize-uOrigin)), 0.0001);
    float front = uProgress * (1.0 + 2.0*uSoftness) - uSoftness;
    float wave = uWaveAmplitude * sin(3.14159265359 * uProgress)
        * sin(uWaveFrequency * (radius - front) - 18.8495559215 * uProgress);
    alpha = smoothstep(front - uSoftness, front + uSoftness, radius + wave);
  } else {
    float radius = length(xy - uOrigin) / max(length(max(uOrigin, uSize-uOrigin)), 0.0001);
    float front = uProgress * (1.0 + 2.0*uSoftness) - uSoftness;
    alpha = smoothstep(front - uSoftness, front + uSoftness, radius);
  }
  fragColor = vec4(alpha);
}
