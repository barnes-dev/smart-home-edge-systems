from pathlib import Path

base = Path(r'c:/Users/barne/Documents/HomeAssistant/Proxmox/Web Design/smart-home-edge-systems')

common_style = '''    <style>
        :root {
            --bg: #132f57;
            --body-text: #e2e8f0;
            --header-bg: #10284f;
            --card-bg: #f3f9ff;
            --card-border: #dbeafe;
            --accent: #1d4ed8;
            --footer-bg: #0f172a;
            --footer-text: #94a3b8;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background: var(--bg); color: var(--body-text); line-height: 1.6; min-height: 100vh; display: flex; flex-direction: column; }
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
        footer { background-color: var(--footer-bg); color: var(--footer-text); padding: 2rem 2rem 1.5rem; width: 100%; }
        .footer-container { max-width: 1200px; margin: 0 auto; display: flex; gap: 1rem; flex-wrap: wrap; padding-top: 1rem; }
        .footer-column { flex: 1 1 220px; min-width: 220px; font-size: 0.9rem; line-height: 1.3; }
        .footer-column h4, .footer-column h5 { color: #eaf4ff; margin-bottom: 0.5rem; font-size: 1rem; }
        .footer-column ul { list-style: none; padding: 0; margin: 0; }
        .footer-column ul li { margin-bottom: 0.2rem; }
        .footer-column a { color: var(--footer-text); }
        .footer-column a:hover { color: #ffffff; }
    </style>'''

js = '''    <script>
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
            loadComponent("header-placeholder", "../includes/header.html");
            loadComponent("menu-placeholder", "../includes/menu.html");
            loadComponent("footer-placeholder", "../includes/footer.html");
        });
    </script>'''

pages = {
    'home-assistant/index.html': {
        'title': 'Home Assistant Hub',
        'main': '''        <main>
            <h1 style="color: #eaf4ff; margin-bottom: 1.5rem; font-size: 2rem;">Home Assistant Hub</h1>
            <div class="grid">
                <div class="card">
                    <h3>Automation Overview</h3>
                    <p>Track your local automations, dashboards, and device health from one place.</p>
                </div>
                <div class="card">
                    <h3>Current Focus</h3>
                    <p>Use this space for Zigbee, sensors, dashboards, and your preferred automations.</p>
                </div>
                <div class="card">
                    <h3>Helpful Guide</h3>
                    <p><a href="guides/proxmox-ha-node.html">Open the Proxmox Home Assistant setup guide</a></p>
                </div>
            </div>
        </main>'''
    },
    'home-lab/index.html': {
        'title': 'Home Lab Hub',
        'main': '''        <main>
            <p style="margin-bottom: 1rem;"><a href="../index.html" style="color: #bfdbfe; font-weight: 600;">← Back to Gateway</a></p>
            <h1 style="color: #eaf4ff; margin-bottom: 1.5rem; font-size: 2rem;">Home Lab Hub</h1>
            <div class="grid">
                <div class="card">
                    <h3>Infrastructure</h3>
                    <p>Track hypervisors, networking, and local compute resources.</p>
                </div>
                <div class="card">
                    <h3>Virtual Machines</h3>
                    <p>Monitor your VM layouts, storage pools, and uptime plans.</p>
                </div>
                <div class="card">
                    <h3>Growth Plan</h3>
                    <p>Define next steps for expansion, reliability, and automation.</p>
                </div>
            </div>
        </main>'''
    },
    'media/index.html': {
        'title': 'Movies Hub',
        'main': '''        <main>
            <p style="margin-bottom: 1rem;"><a href="../index.html" style="color: #bfdbfe; font-weight: 600;">← Back to Gateway</a></p>
            <h1 style="color: #eaf4ff; margin-bottom: 1.5rem; font-size: 2rem;">Movies Hub</h1>
            <div class="grid">
                <div class="card">
                    <h3>Media Library</h3>
                    <p>Track your media services, collections, and playback setups.</p>
                </div>
                <div class="card">
                    <h3>Streaming Setup</h3>
                    <p>Document apps, devices, and local media routing.</p>
                </div>
                <div class="card">
                    <h3>Next Upgrade</h3>
                    <p>Plan new players, audio enhancements, and automation ideas.</p>
                </div>
            </div>
        </main>'''
    },
    'marketing/index.html': {
        'title': 'Marketing Hub',
        'main': '''        <main>
            <p style="margin-bottom: 1rem;"><a href="../index.html" style="color: #bfdbfe; font-weight: 600;">← Back to Gateway</a></p>
            <h1 style="color: #eaf4ff; margin-bottom: 1.5rem; font-size: 2rem;">Marketing Hub</h1>
            <div class="grid">
                <div class="card">
                    <h3>Community Outreach</h3>
                    <p>Share how the project connects with the community and your audience.</p>
                </div>
                <div class="card">
                    <h3>Content Focus</h3>
                    <p>Capture ideas for tutorials, updates, and educational content.</p>
                </div>
                <div class="card">
                    <h3>Next Campaign</h3>
                    <p>Use this page to plan launches, blog posts, and sponsor opportunities.</p>
                </div>
            </div>
        </main>'''
    },
    'storage/index.html': {
        'title': 'Storage Hub',
        'main': '''        <main>
            <p style="margin-bottom: 1rem;"><a href="../index.html" style="color: #bfdbfe; font-weight: 600;">← Back to Gateway</a></p>
            <h1 style="color: #eaf4ff; margin-bottom: 1.5rem; font-size: 2rem;">Storage Hub</h1>
            <div class="grid">
                <div class="card">
                    <h3>Storage Overview</h3>
                    <p>Keep track of your local backup, media, and archive strategy.</p>
                </div>
                <div class="card">
                    <h3>Capacity Planning</h3>
                    <p>Review drives, redundancy, and growth targets for your setup.</p>
                </div>
                <div class="card">
                    <h3>Backup Goals</h3>
                    <p>Document your recovery plan, retention policy, and maintenance routines.</p>
                </div>
            </div>
        </main>'''
    },
    'survailence/index.html': {
        'title': 'Surveillance Hub',
        'main': '''        <main>
            <p style="margin-bottom: 1rem;"><a href="../index.html" style="color: #bfdbfe; font-weight: 600;">← Back to Gateway</a></p>
            <h1 style="color: #eaf4ff; margin-bottom: 1.5rem; font-size: 2rem;">Surveillance Hub</h1>
            <div class="grid">
                <div class="card">
                    <h3>Camera Status</h3>
                    <p>Keep an eye on camera health, recording schedules, and feeds.</p>
                </div>
                <div class="card">
                    <h3>Security Notes</h3>
                    <p>Record access policies, alerts, and local storage practices.</p>
                </div>
                <div class="card">
                    <h3>Next Step</h3>
                    <p>Plan improvements for coverage, retention, and privacy controls.</p>
                </div>
            </div>
        </main>'''
    },
    'voice/index.html': {
        'title': 'Voice Assistants Hub',
        'main': '''        <main>
            <p style="margin-bottom: 1rem;"><a href="../index.html" style="color: #bfdbfe; font-weight: 600;">← Back to Gateway</a></p>
            <h1 style="color: #eaf4ff; margin-bottom: 1.5rem; font-size: 2rem;">Voice Assistants Hub</h1>
            <div class="grid">
                <div class="card">
                    <h3>Voice Setup</h3>
                    <p>Keep your speakers, satellites, and voice assistants organized in one place.</p>
                </div>
                <div class="card">
                    <h3>Local Controls</h3>
                    <p>Document privacy settings, routines, and device integrations for easy upkeep.</p>
                </div>
                <div class="card">
                    <h3>Next Improvements</h3>
                    <p>Use this page to track upgrades, wake words, and voice workflow ideas.</p>
                </div>
            </div>
        </main>'''
    },
    'r-d/index.html': {
        'title': 'Research and Development Hub',
        'main': '''        <main>
            <p style="margin-bottom: 1rem;"><a href="../index.html" style="color: #bfdbfe; font-weight: 600;">← Back to Gateway</a></p>
            <h1 style="color: #eaf4ff; margin-bottom: 1.5rem; font-size: 2rem;">Research and Development Hub</h1>
            <div class="grid">
                <div class="card">
                    <h3>Current Projects</h3>
                    <p>Capture prototypes, experiments, and ideas you are actively testing.</p>
                </div>
                <div class="card">
                    <h3>Experiment Notes</h3>
                    <p>Keep track of hardware tests, software tweaks, and performance summaries.</p>
                </div>
                <div class="card">
                    <h3>Next Milestone</h3>
                    <p>Plan improvements, builds, and research checkpoints.</p>
                </div>
            </div>
        </main>'''
    },
    '3d-printing/index.html': {
        'title': '3D Printing Hub',
        'main': '''        <main>
            <p style="margin-bottom: 1rem;"><a href="../index.html" style="color: #bfdbfe; font-weight: 600;">← Back to Gateway</a></p>
            <h1 style="color: #eaf4ff; margin-bottom: 1.5rem; font-size: 2rem;">3D Printing Hub</h1>
            <div class="grid">
                <div class="card">
                    <h3>Printer Status</h3>
                    <p>Keep track of your print farm, machine health, and active jobs.</p>
                </div>
                <div class="card">
                    <h3>Calibration Notes</h3>
                    <p>Record meshes, flow tuning, and recurring maintenance tasks.</p>
                </div>
                <div class="card">
                    <h3>Helpful Guide</h3>
                    <p><a href="guides/klipper-bed-mesh.html">Open the Klipper bed mesh guide</a></p>
                </div>
            </div>
        </main>'''
    },
    'authors/index.html': {
        'title': 'Authors Hub',
        'main': '''        <main>
            <p style="margin-bottom: 1rem;"><a href="../index.html" style="color: #bfdbfe; font-weight: 600;">← Back to Gateway</a></p>
            <h1 style="color: #eaf4ff; margin-bottom: 1.5rem; font-size: 2rem;">Authors Hub</h1>
            <div class="grid">
                <div class="card">
                    <h3>Contributor Notes</h3>
                    <p>Document authorship, team roles, and update history for this site.</p>
                </div>
                <div class="card">
                    <h3>Content Planning</h3>
                    <p>Plan articles, guides, and content drafts across the site.</p>
                </div>
                <div class="card">
                    <h3>Publishing Roadmap</h3>
                    <p>Track upcoming releases, editorial schedules, and review cycles.</p>
                </div>
            </div>
        </main>'''
    }
}

for rel_path, page in pages.items():
    path = base / rel_path
    path.parent.mkdir(parents=True, exist_ok=True)
    html = f'''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>{page['title']}</title>
{common_style}
</head>
<body>
    <div id="header-placeholder"></div>
    <div id="menu-placeholder"></div>

{page['main']}

    <div id="footer-placeholder"></div>
{js}
</body>
</html>
'''
    path.write_text(html, encoding='utf-8')

header = base / 'includes' / 'header.html'
if header.exists():
    text = header.read_text(encoding='utf-8')
    updated = text.replace('src="./media/assets/icons/main logo.jfif"', 'src="/media/assets/icons/main logo.jfif"')
    if text != updated:
        header.write_text(updated, encoding='utf-8')

menu = base / 'includes' / 'menu.html'
if menu.exists():
    text = menu.read_text(encoding='utf-8')
    old = """        if (isInSectionHub) {
            // Perspective: Locked inside the sub-section folder (e.g., /home-lab/)
            const currentSection = segments[0]; 
            
            // \"Home\" goes to the index.html of this specific hub
            document.getElementById('nav-home').href = rootPrefix + currentSection + "/index.html";
            // \"Guides\" and \"Reference\" target files inside this specific hub folder
            document.getElementById('nav-guides').href = rootPrefix + currentSection + "/guides.html";
            document.getElementById('nav-reference').href = rootPrefix + currentSection + "/reference.html";
        } else {
"""
    new = """        if (isInSectionHub) {
            // Perspective: inside a sub-section folder (e.g., /home-lab/)
            document.getElementById('nav-home').href = 'index.html';
            document.getElementById('nav-guides').href = currentSection + '/guides.html';
            document.getElementById('nav-reference').href = currentSection + '/reference.html';
        } else {
"""
    if old in text:
        text = text.replace(old, new)
        menu.write_text(text, encoding='utf-8')
