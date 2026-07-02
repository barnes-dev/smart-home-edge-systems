from pathlib import Path

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

new_cards = '''                <div class="card">
                    <h3>Guides</h3>
                    <p>Open the section guides and tutorials for this hub.</p>
                    <a href="guides/index.html">Open Guides →</a>
                </div>
                <div class="card">
                    <h3>Reference</h3>
                    <p>View reference resources and documentation for this section.</p>
                    <a href="reference/index.html">Open Reference →</a>
                </div>'''

for section in sections:
    path = base / section / 'index.html'
    if not path.exists():
        print(f'SKIPPED missing: {path}')
        continue
    text = path.read_text(encoding='utf-8')
    if 'href="guides/index.html"' in text or 'href="reference/index.html"' in text:
        print(f'ALREADY UPDATED: {path}')
        continue
    marker = '            </div>\n        </main>'
    if marker not in text:
        print(f'UNEXPECTED STRUCTURE: {path}')
        continue
    new_text = text.replace(marker, new_cards + '\n            </div>\n        </main>')
    path.write_text(new_text, encoding='utf-8')
    print(f'UPDATED: {path}')
