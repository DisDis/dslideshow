"""Offline review of dense control frames captured at native display resolution."""
import html
import json
from pathlib import Path


def write_visual_report(root):
    records=[]
    for file in sorted(root.glob('*/attempt-*/audit/*.json')):
        try:
            audit=json.loads(file.read_text())
        except (OSError,ValueError):
            continue
        records.append((file,audit))
    if not records:
        return 0
    parts=[]
    for file,audit in records:
        attempt=file.parent.parent
        frames=[str((attempt/p).relative_to(root)) for p in audit.get('files',[]) if '--p' in Path(p).name]
        if not frames:
            continue
        label=f"{audit.get('renderer')} · {audit['case']['id']}"
        thumbnails=''.join(f'<img loading="lazy" src="{html.escape(frames[i],quote=True)}" alt="progress {i/20:.2f}">' for i in [0,5,10,15,20])
        parts.append('<article><h2>'+html.escape(label)+'</h2><p>'+html.escape(str(audit.get('status')))
            +' · distinct='+str(audit.get('distinct_frames'))+'/21 · '+html.escape(str(audit.get('issues',[])))+'</p>'
            +'<div class="strip">'+thumbnails+'</div><details><summary>21 кадр: воспроизведение / просмотр</summary>'
            +'<div class="player" data-frames="'+html.escape(json.dumps(frames),quote=True)+'">'
            +'<img src="'+html.escape(frames[0],quote=True)+'" alt="control frame"><p><button>▶</button> '
            +'<input type="range" min="0" max="20" value="0"><output>0%</output></p></div></details></article>')
    (root/'visual-report.html').write_text('''<!doctype html><html lang="ru"><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Проверка эффектов: 21 кадр</title><style>body{font:16px/1.6 system-ui;background:#16202b;color:#e8edf3;margin:24px}h2{font-size:18px}article{border-top:1px solid #607080;margin-top:24px;padding-top:12px}.strip{display:flex;overflow:auto;gap:8px}.strip img{width:240px;height:150px}.player img{width:640px;max-width:100%;image-rendering:auto}button,input{font:inherit}a{color:#9cf}</style>
<h1>Визуальная проверка всех эффектов</h1><p>21 контрольный кадр: 0, 5, …, 100%. Снимок сначала получается в нативном разрешении экрана, затем уменьшается до 320×200 для отчёта.
Исходные фото и композиция не уменьшаются. Эти неподвижные кадры снимаются вне измерений; на дисплее эта фаза явно подписана.
Воспроизведение ниже показывает последовательность контрольных кадров, а не записанную частоту кадров перехода.</p>
<p>unverified_capture означает, что захват не подтвердил изображение: например, Vulkan readback может возвращать прозрачный кадр.
Это не считается успешной визуальной проверкой. Автоматическая проверка не заменяет осмотр физического экрана.</p>'''
        +''.join(parts)+'''<script>
for(const box of document.querySelectorAll('.player')){
 const frames=JSON.parse(box.dataset.frames),image=box.querySelector('img'),range=box.querySelector('input'),button=box.querySelector('button'),output=box.querySelector('output');let timer;
 function show(i){range.value=i;image.src=frames[i];output.textContent=(i*5)+'%';}
 range.oninput=()=>show(+range.value);
 button.onclick=()=>{if(timer){clearInterval(timer);timer=null;button.textContent='▶';}else{button.textContent='⏸';timer=setInterval(()=>show((+range.value+1)%frames.length),120);}};
}
</script></html>''')
    return len(records)
