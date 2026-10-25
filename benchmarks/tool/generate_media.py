#!/usr/bin/env python3
"""Create deterministic local benchmark fixtures. Requires Pillow and ffmpeg."""
import argparse
import hashlib
import json
import math
from pathlib import Path
import random
import subprocess
from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=ROOT / 'assets/media')
    args = parser.parse_args()
    folder = args.output
    folder.mkdir(parents=True, exist_ok=True)
    rng = random.Random(42)
    entries = []
    for name, size, tone in [('photo_a.jpg', (4032, 3024), 0), ('photo_b.jpg', (6000, 4000), 1), ('photo_large.jpg', (8000, 6000), 0)]:
        image = Image.new('RGB', size)
        draw = ImageDraw.Draw(image)
        for y in range(size[1]):
            draw.line((0, y, size[0], y), fill=(int(30 + y / size[1] * 180), 75 + tone * 80, 190 - tone * 90))
        for _ in range(2400):
            x, y = rng.randrange(size[0]), rng.randrange(size[1])
            radius = rng.randrange(2, 50)
            color = tuple(rng.randrange(256) for _ in range(3))
            draw.ellipse((x, y, x + radius, y + radius), fill=color)
        for x in range(0, size[0], 64):
            draw.line((x, 0, x, size[1]), fill='white', width=1)
        for y in range(0, size[1], 64):
            draw.line((0, y, size[0], y), fill='white', width=1)
        draw.rectangle((size[0] // 3, size[1] // 3, size[0] * 2 // 3, size[1] * 2 // 3), outline='white', width=12)
        image.save(folder / name, quality=93, subsampling=0)
        entries.append(dict(name=name, kind='image', width=size[0], height=size[1], role=name.removesuffix('.jpg')))
    frames = []
    for i in range(24):
        frame = Image.new('RGB', (480, 270), (15, 25, 60))
        draw = ImageDraw.Draw(frame)
        for j in range(8):
            x = int(190 + 150 * math.cos((i + j * 3) / 24 * 2 * math.pi))
            y = int(110 + 70 * math.sin((i + j * 3) / 24 * 2 * math.pi))
            draw.rectangle((x, y, x + 70, y + 50), fill=(30 * j, 200 - j * 15, 150 + j * 10))
        frames.append(frame)
    frames[0].save(folder / 'animation.gif', save_all=True, append_images=frames[1:], duration=100, loop=0)
    entries.append(dict(name='animation.gif', kind='gif', width=480, height=270, frames=24))
    for name, filters in [('video_a.mp4', 'null'), ('video_b.mp4', 'hflip,hue=h=45')]:
        subprocess.run(['ffmpeg', '-hide_banner', '-loglevel', 'error', '-y', '-f', 'lavfi',
            '-i', 'testsrc2=size=1920x1080:rate=30', '-t', '8', '-vf', filters,
            '-c:v', 'libx264', '-threads', '2', '-preset', 'veryfast', '-crf', '25',
            '-pix_fmt', 'yuv420p', '-movflags', '+faststart', '-an', str(folder / name)], check=True)
        entries.append(dict(name=name, kind='video', width=1920, height=1080,
                            fps=30, duration_seconds=8, codec='h264', pixel_format='yuv420p'))
    for entry in entries:
        file = folder / entry['name']
        entry.update(bytes=file.stat().st_size, sha256=hashlib.sha256(file.read_bytes()).hexdigest())
    (folder / 'manifest.json').write_text(json.dumps(dict(seed=42, files=entries), indent=2) + '\n')
    print(json.dumps(dict(files=len(entries), total_bytes=sum(e['bytes'] for e in entries))))


if __name__ == '__main__':
    main()
