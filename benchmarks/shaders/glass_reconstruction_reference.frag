#version 460 core
#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform vec2 uFromSize;
uniform vec2 uToSize;
uniform vec3 uFromCamera;
uniform float uBlend;
uniform float uEnvelope;
uniform float uPaneCount;
uniform float uRefractionStrength;
uniform float uGlintStrength;
uniform float uHorizontal;
uniform sampler2D uFrom;
uniform sampler2D uTo;
out vec4 fragColor;

// B=C=1/3 is Flutter/Skia's FilterQuality.high Mitchell reconstruction.
// Combining the two positive middle weights keeps all sixteen contributions
// in nine bilinear lookups. Both original prepared images stay full-size.
float cubic(float x) {
  x = abs(x);
  if (x < 1.0) return (7.0*x*x*x - 12.0*x*x + 16.0/3.0) / 6.0;
  if (x < 2.0) return (-7.0/3.0*x*x*x + 12.0*x*x - 20.0*x + 32.0/3.0) / 6.0;
  return 0.0;
}

vec3 photo(bool from, vec2 imageSize, vec2 position) {
  float fit = min(uSize.x / imageSize.x, uSize.y / imageSize.y);
  vec2 extent = imageSize * fit;
  vec2 uv = (position - (uSize - extent) * 0.5) / extent;
  if (uv.x < 0.0 || uv.y < 0.0 || uv.x > 1.0 || uv.y > 1.0) return vec3(0.0);
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
  // Samples are premultiplied. The original pane puts the photo over black.
  return clamp(color.rgb, 0.0, 1.0);
}

vec4 glint(float x) {
  vec4 a = vec4(1.0, 1.0, 1.0, clamp(.25*uEnvelope*uGlintStrength, 0.0, 1.0));
  vec4 b = vec4(224.0/255.0, 247.0/255.0, 1.0, 0.0);
  vec4 c = vec4(3.0/255.0, 38.0/255.0, 61.0/255.0,
                clamp(.14*uEnvelope*uGlintStrength, 0.0, 1.0));
  vec4 d = vec4(1.0, 1.0, 1.0, clamp(.1*uEnvelope*uGlintStrength, 0.0, 1.0));
  if (x < .1) return mix(a, b, x/.1);
  if (x < .9) return mix(b, c, (x-.1)/.8);
  return mix(c, d, (x-.9)/.1);
}

void main() {
  vec2 xy = FlutterFragCoord().xy;
  bool horizontal = uHorizontal > .5;
  // DirectedEffect(up) rotates the glass coordinate system clockwise, while
  // rotating each media view back. Reproduce both mappings, without rotating
  // the borrowed prepared bitmap or the caller's outgoing camera.
  vec2 extent = horizontal ? uSize.yx : uSize;
  vec2 local = horizontal ? vec2(xy.y, uSize.x-xy.x) : xy;
  // Match the closing pane when a pixel centre lies exactly on its ClipRect
  // boundary. Away from exact ties this is the ordinary floor-based pane ID.
  float pane = clamp(ceil(local.x * uPaneCount / extent.x)-1.0, 0.0, uPaneCount-1.0);
  vec2 shift = vec2(sin(pane*2.4+.7)*extent.x*.018,
                    cos(pane*1.7)*extent.y*.012) * uEnvelope*uRefractionStrength;
  float scale = 1.0 + .05*uEnvelope*uRefractionStrength;
  vec2 position = (local-shift-extent*.5)/scale + extent*.5;
  if (horizontal) position = vec2(uSize.x-position.y, position.x);
  vec3 color = vec3(0.0);
  if (position.x >= 0.0 && position.y >= 0.0 &&
      position.x <= uSize.x && position.y <= uSize.y) {
    vec2 fromPosition = (position-uSize*.5-uFromCamera.yz)/uFromCamera.x + uSize*.5;
    color = mix(photo(true, uFromSize, fromPosition),
                photo(false, uToSize, position), uBlend);
  }
  float acrossPane = clamp(local.x*uPaneCount/extent.x-pane, 0.0, 1.0);
  vec4 overlay = glint(acrossPane);
  color = overlay.rgb*overlay.a + color*(1.0-overlay.a);
  fragColor = vec4(color, 1.0);
}
