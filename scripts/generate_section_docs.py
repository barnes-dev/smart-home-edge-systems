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

gtag = '''    <!-- Google tag (gtag.js) -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-LLK7685ZGC"></script>
    <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', 'G-LLK7685ZGC');
    </script>
'''

style = '''    <style>
        :root {
            --bg: #132f57;
            --body-text: #e2e8f0;
            --header-bg: #10284f;
            --card-bg: #f3f9ff;
            --card-border: #dbeafe;
            --accent: #1d4ed8;
            --accent-2: #60a5fa;
            --footer-bg: #0f172a;
            --footer-text: #94a3b8;
        }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background: var(--bg);
            color: var(--body-text);
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        a { text-decoration: none; color: inherit; }
        header { background-color: var(--header-bg); border-bottom: 1px solid #ffffff; padding: 1rem 2rem; }
        .header-container { max-width: 1200px; margin: 0 auto; }
        .title-block { display: flex; align-items: center; justify-content: center; min-height: 96px; width: 100%; }
        .title-block h1 { font-size: 1.75rem; color: #1e293b; text-align: center; padding: 0 40px; margin: 0 auto; }
        main { max-width: 1200px; width: 100%; margin: 1rem auto; padding: 0 1.5rem; flex: 1; }
        .grid { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 1.5rem; margin-bottom: 1.5rem; }
        .card { background: var(--card-bg); color: #0f172a; padding: 1.5rem; border-radius: 8px; border: 1px solid var(--card-border); box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
        .card h3 { margin-top: 0; margin-bottom: 0.5rem; color: #0f172a; }
        .card p { color: #475569; }
        .card a { color: var(--accent); font-weight: 700; }
        .card-list { list-style: none; padding: 0; margin: 0; display: grid; gap: 0.75rem; }
        .card-list li { background: var(--card-bg); padding: 1rem; border-radius: 8px; border: 1px solid var(--card-border); }
        .card-list li a { color: var(--accent); }
        footer { background-color: var(--footer-bg); color: var(--footer-text); padding: 2rem 2rem 1.5rem; width: 100%; }
        .footer-container { max-width: 1200px; margin: 0 auto; display: flex; gap: 1rem; flex-wrap: wrap; padding-top: 1rem; }
        .footer-column { flex: 1 1 220px; min-width: 220px; font-size: 0.9rem; line-height: 1.3; }
        .footer-column h4, .footer-column h5 { color: #eaf4ff; margin-bottom: 0.5rem; font-size: 1rem; }
        .footer-column ul { list-style: none; padding: 0; margin: 0; }
        .footer-column ul li { margin-bottom: 0.2rem; }
        .footer-column a { color: var(--footer-text); }
        .footer-column a:hover { color: #ffffff; }
    </style>'''

script = '''    <script>
        function loadComponent(elementId, filePath) {
            fetch(filePath)
                .then(response => {
                    if (!response.ok) throw new Error(`Failed to load ${filePath}`);
                    return response.text();
                })
                .then(data => {
                    document.getElementById(elementId).innerHTML = data;
                })
                .catch(error => console.error(error));
        }

        document.addEventListener("DOMContentLoaded", () => {
            loadComponent("header-placeholder", "/includes/header.html");
            loadComponent("menu-placeholder", "/includes/menu.html");
            loadComponent("footer-placeholder", "/includes/footer.html");
        });
    </script>'''

section_data = {
    '3d-printing': {'title': '3D Printing', 'guide_items': [
        ('Klipper Bed Mesh', 'guides/klipper-bed-mesh.html'),
        ('Printer Setup Notes', '#'),
        ('Tuning and Calibration', '#'),
    ], 'reference_items': [
        ('Printer Profiles', '#'),
        ('Material Settings', '#'),
        ('Filament Inventory', '#'),
    ]},
    'home-assistant': {'title': 'Home Assistant', 'guide_items': [
        ('Proxmox HA Node', 'guides/proxmox-ha-node.html'),
        ('Automation Setup', '#'),
        ('Dashboard Layout', '#'),
    ], 'reference_items': [
        ('Integrations', '#'),
        ('Entities', '#'),
        ('Automation Templates', '#'),
    ]},
    'home-lab': {'title': 'Home Lab', 'guide_items': [
        ('Hypervisor Setup', '#'),
        ('Network Design', '#'),
        ('Backup Strategy', '#'),
    ], 'reference_items': [
        ('Hardware Inventory', '#'),
        ('VM Templates', '#'),
        ('Storage Layout', '#'),
    ]},
    'marketing': {'title': 'Marketing', 'guide_items': [
        ('Brand Resources', '#'),
        ('Content Calendar', '#'),
        ('Campaign Plans', '#'),
    ], 'reference_items': [
        ('Style Guide', '#'),
        ('Audience Notes', '#'),
        ('Platform Assets', '#'),
    ]},
    'r-d': {'title': 'Research & Development', 'guide_items': [
        ('Project Roadmap', '#'),
        ('Experiment Logs', '#'),
        ('Prototype Results', '#'),
    ], 'reference_items': [
        ('Component Specs', '#'),
        ('Testing Checklists', '#'),
        ('Research Notes', '#'),
    ]},
    'storage': {'title': 'Storage', 'guide_items': [
        ('Backup Plans', '#'),
        ('RAID Configuration', '#'),
        ('Retention Policy', '#'),
    ], 'reference_items': [
        ('Drive Inventory', '#'),
        ('Pool Layout', '#'),
        ('Snapshot Schedule', '#'),
    ]},
    'voice': {'title': 'Voice Assistants', 'guide_items': [
        ('Voice Workflow Setup', '#'),
        ('Privacy Controls', '#'),
        ('Device Pairing', '#'),
    ], 'reference_items': [
        ('Service Endpoints', '#'),
        ('Routine Definitions', '#'),
        ('Voice Devices', '#'),
    ]},
    'survailence': {'title': 'Surveillance', 'guide_items': [
        ('Camera Coverage', '#'),
        ('Recording Policies', '#'),
        ('Alert Setup', '#'),
    ], 'reference_items': [
        ('Device Inventory', '#'),
        ('Storage Config', '#'),
        ('Security Rules', '#'),
    ]},
}


def build_html(title, page_type, items):
    item_html = '\n'.join([f'                <li><a href="{href}">{label}</a></li>' for label, href in items])
    return f'''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>{title} {page_type}</title>
{gtag}{style}
</head>
<body>
    <div id="header-placeholder"></div>
    <div id="menu-placeholder"></div>

    <main>
        <p style="margin-bottom: 1rem;"><a href="../index.html" style="color: #bfdbfe; font-weight: 600;">← Back to {title} Hub</a></p>
        <h1 style="color: #eaf4ff; margin-bottom: 1.5rem; font-size: 2rem;">{title} {page_type}</h1>
        <ul class="card-list">
{item_html}
        </ul>
    </main>

    <div id="footer-placeholder"></div>
{script}
</body>
</html>
'''


def rewrite_index(path):
    text = path.read_text(encoding='utf-8')
    if gtag.strip() not in text:
        if '<meta name="viewport" content="width=device-width, initial-scale=1.0" />' in text:
            text = text.replace(
                '<meta name="viewport" content="width=device-width, initial-scale=1.0" />',
                '<meta name="viewport" content="width=device-width, initial-scale=1.0" />\n' + gtag.strip()
            )
        elif '<meta name="viewport" content="width=device-width, initial-scale=1.0">' in text:
            text = text.replace(
                '<meta name="viewport" content="width=device-width, initial-scale=1.0">',
                '<meta name="viewport" content="width=device-width, initial-scale=1.0">\n' + gtag.strip()
            )
        else:
            print(f'Could not insert gtag into {path}')
    text = text.replace('"../includes/header.html"', '"/includes/header.html"')
    text = text.replace('"../includes/menu.html"', '"/includes/menu.html"')
    text = text.replace('"../includes/footer.html"', '"/includes/footer.html"')
    text = text.replace('"./includes/header.html"', '"/includes/header.html"')
    text = text.replace('"./includes/menu.html"', '"/includes/menu.html"')
    text = text.replace('"./includes/footer.html"', '"/includes/footer.html"')
    text = text.replace('loadComponent("header-placeholder", "/includes/header.html")', 'loadComponent("header-placeholder", "/includes/header.html")')
    path.write_text(text, encoding='utf-8')


def create_page(path, content):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding='utf-8')


for section in sections:
    section_info = section_data[section]
    # update existing section index.html
    index_path = base / section / 'index.html'
    if index_path.exists():
        rewrite_index(index_path)

    # create guides/index.html
    guides_content = build_html(section_info['title'], 'Guides', section_info['guide_items'])
    create_page(base / section / 'guides' / 'index.html', guides_content)

    # create reference/index.html
    reference_content = build_html(section_info['title'], 'Reference', section_info['reference_items'])
    create_page(base / section / 'reference' / 'index.html', reference_content)

print('Completed section guide and reference generation.')
