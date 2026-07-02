from pathlib import Path
import re

base = Path(r'c:/Users/barne/Documents/HomeAssistant/Proxmox/Web Design/smart-home-edge-systems')
sections = [
    '3d-printing',
    'home-assistant',
    'home-lab',
    'marketing',
    'r-d',
    'storage',
    'voice',
    'survailence',
]
link_html = '  <link rel="stylesheet" href="/css/global.css">'
script_html = '  <script src="/scripts/component-loader.js"></script>'

for section in sections:
    for page_type in ['guides', 'reference']:
        path = base / section / page_type / 'index.html'
        if not path.exists():
            print(f'MISSING: {path}')
            continue
        text = path.read_text(encoding='utf-8')
        original = text

        # remove inline style block
        text = re.sub(r'<style>.*?</style>\s*', '', text, flags=re.S)

        # remove inline component loader script block
        text = re.sub(r'<script>\s*function loadComponent[\s\S]*?</script>\s*', '', text, flags=re.S)

        # add root stylesheet link inside head if missing
        if '/css/global.css' not in text:
            text = re.sub(r'(</head>)', link_html + '\n\1', text, count=1)

        # add external script before closing body if missing
        if '/scripts/component-loader.js' not in text:
            text = re.sub(r'(</body>)', script_html + '\n\1', text, count=1)

        if text != original:
            path.write_text(text, encoding='utf-8')
            print(f'UPDATED: {path}')
        else:
            print(f'NO CHANGE: {path}')
