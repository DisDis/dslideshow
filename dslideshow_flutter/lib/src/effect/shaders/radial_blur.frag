#version 460 core
#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float uMotion;
uniform float uScale;
uniform float uAngle;
uniform vec2 uOrigin;
uniform vec2 uFromSize;
uniform vec2 uToSize;
uniform vec3 uFromCamera;
uniform sampler2D uFrom;
uniform sampler2D uTo;
out vec4 fragColor;

// Bilinear sampling of the full prepared input, with the same black backing.
// The photos normally match uSize; contain also handles a different aspect.
vec4 photo(bool from, vec2 imageSize, vec2 position) {
  float fit = min(uSize.x / imageSize.x, uSize.y / imageSize.y);
  vec2 extent = imageSize * fit;
  vec2 uv = (position - (uSize - extent) * 0.5) / extent;
  if (uv.x < 0.0 || uv.y < 0.0 || uv.x > 1.0 || uv.y > 1.0) {
    return vec4(0.0, 0.0, 0.0, 1.0);
  }
  vec2 texel = clamp(uv * imageSize, vec2(0.5), imageSize - 0.5);
  vec4 color = from ? texture(uFrom, texel / imageSize)
                    : texture(uTo, texel / imageSize);
  return vec4(color.rgb, 1.0);
}

void main() {
  vec2 xy = FlutterFragCoord().xy;
  vec2 center = uSize * 0.5;
  vec4 accumulated = vec4(0.0);
  if (uScale == 0.0) {
    fragColor = accumulated;
    return;
  }
  // A prepared photo pair normally shares the full viewport and identity camera.
  // Keep the original general sampling path for other dimensions/cameras.
  bool samePhotoUv = all(equal(uFromSize, uSize)) && all(equal(uToSize, uSize)) &&
      all(equal(uFromCamera, vec3(1.0, 0.0, 0.0)));
  for (int i = 0; i < 9; i++) {
    float angle = float(i - 4) / 4.0 * uAngle;
    float c = cos(angle);
    float s = sin(angle);
    vec2 delta = xy - uOrigin;
    // Invert outer rotation around the selected origin, then inner scale
    // around the viewport centre. Transform.scale keeps its default centre.
    vec2 unrotated = uOrigin + vec2(c * delta.x + s * delta.y,
                                  -s * delta.x + c * delta.y);
    vec2 position = (unrotated - center) / uScale + center;
    vec4 sampleColor = vec4(0.0);
    if (position.x >= 0.0 && position.y >= 0.0 &&
        position.x <= uSize.x && position.y <= uSize.y) {
      vec2 fromPosition = (position - center - uFromCamera.yz)
          / uFromCamera.x + center;
      if (samePhotoUv) {
        vec2 uv = clamp(position, vec2(0.5), uSize - 0.5) / uSize;
        vec3 color = mix(texture(uFrom, uv).rgb, texture(uTo, uv).rgb, uMotion);
        sampleColor = vec4(color, 1.0);
      } else {
        sampleColor = mix(photo(true, uFromSize, fromPosition),
                          photo(false, uToSize, position), uMotion);
      }
    }
    // The original stack uses 1, 1/2, ... 1/9 source-over opacity. With opaque
    // covered rays this is the equal nine-ray average. Keep source-over for
    // any uncovered edge, without modelling separate 8-bit layer rounding.
    float opacity = 1.0 / float(i + 1);
    accumulated = sampleColor * opacity
        + accumulated * (1.0 - sampleColor.a * opacity);
  }
  fragColor = accumulated;
}
