#version 460 core
#include <flutter/runtime_effect.glsl>
uniform vec2 uSize;
uniform float uGridSize;
uniform float uProgress;
uniform float uFadeFraction;
uniform sampler2D uSchedule;
out vec4 fragColor;
void main() {
  // Use the same boundary tie-break as the nearest-neighbor Canvas mask.
  vec2 cell = clamp(floor(FlutterFragCoord().xy / uSize * uGridSize + 0.0001), vec2(0.0), vec2(uGridSize - 1.0));
  vec3 encoded = texture(uSchedule, (cell + 0.5) / uGridSize).rgb;
  float start = dot(encoded, vec3(16711680.0, 65280.0, 255.0)) / 16777215.0;
  float alpha = uFadeFraction <= 0.0
    ? 1.0 - step(start, uProgress)
    : clamp(1.0 - (uProgress - start) / uFadeFraction, 0.0, 1.0);
  // Match the existing 8-bit opacity schedule, including the Canvas fallback.
  alpha = floor(alpha * 255.0 + 0.5) / 255.0;
  fragColor = vec4(alpha);
}
