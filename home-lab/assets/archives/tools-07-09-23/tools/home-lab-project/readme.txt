
Conversation with Gemini
Can you please cleanupo this readme fgile to clarify my instructions Step 1: Create your Template File (template.html)

  open VSCode - The template file is allready created you may view it here if you wish

  Make sure you have a good msword doc - IE tables and the TOC is all updated.  The more work you do here the less you will have to do editing html.  Also you may want to view the html output and update your word docx - then rerun so that you have a master to go from



  Please make sure the file name for your docx and your html is all lowercase - use dashes if desired for readability.





Step 2: Execute the PowerShell script file.

     cd "C:\Users\me\Documents\Proxmox\Published Documents\home-lab-project") or what ever your path is.

This script will execute 2 major commands using the tool called pandoc.

  first the PowerShell Command will build the Markdown file

  Example PowerShell, Command 1: Convert Word to Markdown (For you to edit in VS Code)



    PowerShell

      pandoc input.docx -f docx -t markdown --wrap=none --extract-media=./images -o output.md

  Take your time here to open output.md in VS Code, clean up your code blocks, tweak text, or organize sections.



  secone the PowerShell Command to build the index.html file:

  Example PowerShell, Command 2: Compile Markdown + Template into the Final Web Page

  Once your Markdown is perfect, run this command to build the final HTML file:



    PowerShell

    pandoc output.md -f markdown -t html5 --template=template.html --toc --toc-depth=3 --standalone --id-prefix="nav-" -o index.html

      

  Breaking down the magic parameters:

    --template=template.html: Tells Pandoc to use the wrapper layout you made in Step 1.

    --toc: Tells Pandoc to automatically scan your Markdown headings (#, ##, ###) and generate a fully linked Table of Contents, inserting it exactly where $toc$ is in your template.

    --toc-depth=3: Controls how deep the TOC goes (H1, H2, and H3 headings).

    --metadata title="...": Dynamically replaces the $title$ tag in your HTML header.



  Pro-Tip for CSS

    Because Pandoc generates the TOC automatically as a nested list (<ul> and <li>), update your styles.css file from earlier to ensure the generated links look clean:



    CSS

    /* Style the automatically generated Pandoc TOC */

    .toc ul {

        list-style-type: none;

        padding-left: 15px;

    }

    .toc > ul {

        padding-left: 0; /* Remove padding for the outermost list */

    }

    .toc a {

        text-decoration: none;

        color: #3498db;

        display: block;

        padding: 4px 0;

    }

    .toc a:hover {

        text-decoration: underline;

    }

  Now, whenever you update your Markdown file, css, or main Word.docx, you just hit the up arrow in PowerShell, rerun The PowerShell script, and your website instantly updates!



  Your Local Folder Structure (Before running the command)

  Keep everything in one project folder on your computer while you work:



Plaintext

📂 my-web-project/      (I cxalled it home-lab-project)

├── 📄 input.docx       (Your original Word file) if needed save your docm as tha docx to remove garbage

├── 📄 output.md        (The Markdown file you can edit in VS Code) 

                         I recommend editing your Word doc instead.  If you must edit this file then 

                         ask Continue Chat how you can fix these tools to get what you desire without 

                         editing the markdown.

├── 📄 template.html    (The layout wrapper file)

├── 📄 styles.css       (Your stylesheet)

└── 📂 images/          (Extracted figures/images)

        web-images       (folder to contain your MS Word Image sources)

        web-snipets      (folder to contain your MS Word text sources)

        web-scripts      ((folder to contain your MS Word code scripts)

        

What Actually Goes on the Web Server



  Once Pandoc generates your index.html, it will move your finished assets needed to display the page.



  Your production web server structure will look like this:



  Plaintext



  📂 public_html/         (or your working repository) - This path is defined inside the PowerSehell script

  ├── 📄 index.html       (The final generated page from Pandoc) rename this to your origional name during the copy

  └── 📂 images/          (Your figures and images)



  💡 Note: template.html and output.md stay safely on your hard drive. If you ever need to change the header text or update your document's content in the future, you just edit those local files, re-run the PowerShell command to generate a new index.html, and upload the updated index.html to your server.

  

  

  My Final directory under web top level

📁 smart-home-edge-systems/           (Your Root Directory)

│

├── 📄 404.html

├── 📄 CNAME                          (Custom domain pointer)

├── 📄 .gitignore

├── 📄 index.html                     (Main Landing Page)

├── 📄 robots.txt

├── 📄 sitemap.xml

│

├── 📁 .github/

│   └── 📁 workflows/                 (CI/CD Automation)

│

├── 📁 assets/                        (GLOBAL Assets)

│   ├── 📁 figures/

│   │   └── 📷 [Global site banners]

│   └── 📁 icons/

│       └── 📷 main-logo.jfif         (Main site logo)

│

├── 📁 authors/

│   └── 📄 index.html

│

├── 📁 includes/

│   └── 📄 [Your moved sample header, menu, and footer .html files]

│

├── 📁 scripts/                       (GLOBAL Scripts)

│   └── 📄 component-loader.js        (Dynamic navbar/footer loader)

│

├── 📁 styles/                        (GLOBAL Styles)

│   └── 📄 global.css                 (Your master stylesheet)

│

└── 📁 home-lab/                      (Example Documentation Category)

    ├── 📄 index.html                 (Main category landing page)

    │

    ├── 📁 assets/                    (LOCAL Assets - Unique to home-lab)

    │   ├── 📁 figures/

    │   │   └── 📷 [Proxmox/Network diagrams]

    │   └── 📁 icons/

    │       └── 📷 [Hardware/LXC node icons]

    │

    ├── 📁 guides/                    (LOCAL Guides Subfolder)

    │   └── 📄 index.html             (Guides index file)

    │

    └── 📁 reference/                 (LOCAL Reference Subfolder)

        └── 📄 index.html             (Reference index file)





Part 1: How to Set the Title Inside Word (.docx)

  Open your master file in Microsoft Word.

  Make sure all Titles are set to Heading 1

  Make sure all first level of indentation is set to Heading 2

  Make sure all second level of indentation is set to Heading 3

  Make sure all captions and subtitles are set to Heading 4



Save and close your file.

Rerun the PowerShell script.

Here is a cleaned-up, professionally formatted version of your README file. I fixed the typos, structured the workflows clearly, and ensured that the folder hierarchies are easy to read.

Technical Documentation Workflow: Word to HTML via Pandoc
This guide outlines the workflow for converting Microsoft Word documentation (.docx) into clean, standalone HTML pages using Pandoc and PowerShell, complete with automated Table of Contents (TOC) generation and a structured local-to-production deployment model.

Part 1: Preparing Your Microsoft Word Document
Before running any scripts, ensure your master Word document is properly formatted. Proper formatting in Word minimizes manual HTML or Markdown editing later.

Heading Hierarchy: * Set the main document title and major section headers to Heading 1.

Set the first level of sub-sections to Heading 2.

Set the second level of sub-sections to Heading 3.

Set captions, sub-sections, or minor labels to Heading 4.

Elements: Verify that all Word tables are clean and the built-in Table of Contents is fully updated.

File Naming: Ensure the file names for your .docx and target .html files are entirely lowercase. Use dashes (-) instead of spaces for readability (e.g., my-home-lab-guide.docx).

Clean File Type: If working from a macro-enabled document (.docm), save it as a clean .docx file to strip out unnecessary background metadata.

💡 Pro-Tip: If you see rendering issues in the final HTML output, it is usually faster to update your master Word doc and rerun the script than it is to manually hack the HTML code.

Step 1: Set Up Your Local Workspace
Open Visual Studio Code. Your layout template (template.html) should already be created and present in your working directory.

Keep your local project folder organized on your computer using the following layout during development:

Plaintext
📂 home-lab-project/            (Local working directory)
├── 📄 input.docx               (Your master Word file)
├── 📄 template.html            (The layout wrapper file used by Pandoc)
├── 📄 styles.css               (Your development stylesheet)
├── 📄 output.md                (Intermediate Markdown file; generated by Step 2)
├── 📂 images/                  (Automatically extracted figures and images)
├── 📂 web-images/              (Backup/source folder for your MS Word image sources)
├── 📂 web-snippets/            (Text source fragments)
└── 📂 web-scripts/             (Custom scripts and code snippets)
Step 2: Execute the PowerShell Conversion Script
Open PowerShell and navigate to your project directory:

PowerShell
cd "C:\Users\me\Documents\Proxmox\Published Documents\home-lab-project"
The automation workflow executes two major Pandoc operations behind the scenes:

Command 1: Convert Word to Markdown
This extracts your media and builds a clean Markdown file for verification.

PowerShell
pandoc input.docx -f docx -t markdown --wrap=none --extract-media=./images -o output.md
(Optional: Open output.md in VS Code to review code blocks, tweak text layout, or verify sections.)

Command 2: Compile Markdown and Template into the Final Web Page
Once the source content is ready, run this command to compile everything into your final, styled HTML production file:

PowerShell
pandoc output.md -f markdown -t html5 --template=template.html --toc --toc-depth=3 --standalone --id-prefix="nav-" -o index.html
Breaking Down the Magic Parameters:
--template=template.html: Instructs Pandoc to use your custom wrapper layout.

--toc: Automatically scans your Markdown headings (#, ##, ###) to generate a fully linked Table of Contents, placing it exactly where the $toc$ variable sits in your template.

--toc-depth=3: Restricts the automated TOC depth to H1, H2, and H3 headings.

--id-prefix="nav-": Prefixes generated IDs to avoid styling conflicts with global CSS files.

Pro-Tip for TOC Styling
Because Pandoc generates the Table of Contents automatically as a nested list (<ul> and <li>), add or update these rules in your stylesheet to ensure clean navigation links:

CSS
/* Style the automatically generated Pandoc TOC */
.toc ul {
    list-style-type: none;
    padding-left: 15px;
}

.toc > ul {
    padding-left: 0; /* Remove padding for the outermost list */
}

.toc a {
    text-decoration: none;
    color: #3498db;
    display: block;
    padding: 4px 0;
}

.toc a:hover {
    text-decoration: underline;
}
Now, whenever you update your Markdown file, CSS, or master Word document, simply hit the Up Arrow in your PowerShell terminal, re-run the build sequence, and your page updates instantly!

Production Deployment Structure
What Goes on the Web Server
Once Pandoc generates your local assets, the production ready files are synchronized to your working repository path (defined within your deployment script). Local files like template.html and output.md stay safely on your local hard drive.

A typical target web directory structure looks like this:

Plaintext
📂 public_html/                 (Target deployment folder defined in script)
├── 📄 index.html               (The final generated page, renamed to match production)
└── 📂 images/                  (Extracted figures and graphics referenced by the page)
Production Server Architecture (smart-home-edge-systems)
Below is the master layout of the web server, showing where your individual project assets merge into the broader ecosystem:

Plaintext
📁 smart-home-edge-systems/           (Production Root Directory)
│
├── 📄 index.html                     (Main Landing Page)
├── 📄 404.html                       (Error Page)
├── 📄 CNAME                          (Custom domain pointer)
├── 📄 .gitignore
├── 📄 robots.txt
├── 📄 sitemap.xml
│
├── 📁 .github/
│   └── 📁 workflows/                 (CI/CD Automation Scripts)
│
├── 📁 assets/                        (GLOBAL Assets)
│   ├── 📁 figures/                   (Global site banners)
│   └── 📁 icons/
│       └── 📷 main-logo.jfif         (Main site logo)
│
├── 📁 authors/
│   └── 📄 index.html
│
├── 📁 includes/                      (Global components: header, menu, footer fragments)
│   └── 📄 [Global sample navigation, header, and footer .html files]
│
├── 📁 scripts/                       (GLOBAL Scripts)
│   └── 📄 component-loader.js        (Dynamic navbar/footer loader script)
│
├── 📁 styles/                        (GLOBAL Styles)
│   └── 📄 global.css                 (Master site stylesheet)
│
└── 📁 home-lab/                      (Documentation Category - Example Target Location)
    ├── 📄 index.html                 (Main category landing page)
    │
    ├── 📁 assets/                    (LOCAL Assets - Unique to home-lab)
    │   ├── 📁 figures/               (Proxmox topologies & network diagrams)
    │   └── 📁 icons/                 (Hardware icons & LXC/VM node styling)
    │
    ├── 📁 guides/                    (LOCAL Guides Subfolder)
    │   └── 📄 index.html             (Guides sub-index file)
    │
    └── 📁 reference/                 (LOCAL Reference Subfolder)
        └── 📄 index.html             (Reference sub-index file)
can you convert this to a text file using 4 spaces as tabs

Python
readme_text = """# Technical Documentation Workflow: Word to HTML via Pandoc

This guide outlines the workflow for converting Microsoft Word documentation (`.docx`) into clean, standalone HTML pages using **Pandoc** and **PowerShell**, complete with automated Table of Contents (TOC) generation and a structured local-to-production deployment model.

---

## Part 1: Preparing Your Microsoft Word Document

Before running any scripts, ensure your master Word document is properly formatted. Proper formatting in Word minimizes manual HTML or Markdown editing later.

1. **Heading Hierarchy:**
    * Set the main document title and major section headers to **Heading 1**.
    * Set the first level of sub-sections to **Heading 2**.
    * Set the second level of sub-sections to **Heading 3**.
    * Set captions, sub-sections, or minor labels to **Heading 4**.
2. **Elements:** Verify that all Word tables are clean and the built-in Table of Contents is fully updated. 
3. **File Naming:** Ensure the file names for your `.docx` and target `.html` files are entirely **lowercase**. Use dashes (`-`) instead of spaces for readability (e.g., `my-home-lab-guide.docx`).
4. **Clean File Type:** If working from a macro-enabled document (`.docm`), save it as a clean `.docx` file to strip out unnecessary background metadata.

> 💡 **Pro-Tip:** If you see rendering issues in the final HTML output, it is usually faster to update your master Word doc and rerun the script than it is to manually hack the HTML code.

---

## Step 1: Set Up Your Local Workspace

Open **Visual Studio Code**. Your layout template (`template.html`) should already be created and present in your working directory. 

Keep your local project folder organized on your computer using the following layout during development:

Code output
File saved successfully as README.txt

```text
📂 home-lab-project/            (Local working directory)
├── 📄 input.docx               (Your master Word file)
├── 📄 template.html            (The layout wrapper file used by Pandoc)
├── 📄 styles.css               (Your development stylesheet)
├── 📄 output.md                (Intermediate Markdown file; generated by Step 2)
├── 📂 images/                  (Automatically extracted figures and images)
├── 📂 web-images/              (Backup/source folder for your MS Word image sources)
├── 📂 web-snippets/            (Text source fragments)
└── 📂 web-scripts/             (Custom scripts and code snippets)
Step 2: Execute the PowerShell Conversion Script
Open PowerShell and navigate to your project directory:

PowerShell
cd "C:\\Users\\me\\Documents\\Proxmox\\Published Documents\\home-lab-project"
The automation workflow executes two major Pandoc operations behind the scenes:

Command 1: Convert Word to Markdown
This extracts your media and builds a clean Markdown file for verification.

PowerShell
pandoc input.docx -f docx -t markdown --wrap=none --extract-media=./images -o output.md
(Optional: Open output.md in VS Code to review code blocks, tweak text layout, or verify sections.)

Command 2: Compile Markdown and Template into the Final Web Page
Once the source content is ready, run this command to compile everything into your final, styled HTML production file:

PowerShell
pandoc output.md -f markdown -t html5 --template=template.html --toc --toc-depth=3 --standalone --id-prefix="nav-" -o index.html
Breaking Down the Magic Parameters:
--template=template.html: Instructs Pandoc to use your custom wrapper layout.

--toc: Automatically scans your Markdown headings (#, ##, ###) to generate a fully linked Table of Contents, placing it exactly where the $toc$ variable sits in your template.

--toc-depth=3: Restricts the automated TOC depth to H1, H2, and H3 headings.

--id-prefix="nav-": Prefixes generated IDs to avoid styling conflicts with global CSS files.

Pro-Tip for TOC Styling
Because Pandoc generates the Table of Contents automatically as a nested list (<ul> and <li>), add or update these rules in your stylesheet to ensure clean navigation links:

CSS
/* Style the automatically generated Pandoc TOC */
.toc ul {
    list-style-type: none;
    padding-left: 15px;
}

.toc > ul {
    padding-left: 0; /* Remove padding for the outermost list */
}

.toc a {
    text-decoration: none;
    color: #3498db;
    display: block;
    padding: 4px 0;
}

.toc a:hover {
    text-decoration: underline;
}
Now, whenever you update your Markdown file, CSS, or master Word document, simply hit the Up Arrow in your PowerShell terminal, re-run the build sequence, and your page updates instantly!

Production Deployment Structure
What Goes on the Web Server
Once Pandoc generates your local assets, the production ready files are synchronized to your working repository path (defined within your deployment script). Local files like template.html and output.md stay safely on your local hard drive.

A typical target web directory structure looks like this:

Plaintext
📂 public_html/                 (Target deployment folder defined in script)
├── 📄 index.html               (The final generated page, renamed to match production)
└── 📂 images/                  (Extracted figures and graphics referenced by the page)
Production Server Architecture (smart-home-edge-systems)
Below is the master layout of the web server, showing where your individual project assets merge into the broader ecosystem:

Plaintext
📁 smart-home-edge-systems/           (Production Root Directory)
│
├── 📄 index.html                     (Main Landing Page)
├── 📄 404.html                       (Error Page)
├── 📄 CNAME                          (Custom domain pointer)
├── 📄 .gitignore
├── 📄 robots.txt
├── 📄 sitemap.xml
│
├── 📁 .github/
│   └── 📁 workflows/                 (CI/CD Automation Scripts)
│
├── 📁 assets/                        (GLOBAL Assets)
│   ├── 📁 figures/                   (Global site banners)
│   └── 📁 icons/
│       └── 📷 main-logo.jfif         (Main site logo)
│
├── 📁 authors/
│   └── 📄 index.html
│
├── 📁 includes/                      (Global components: header, menu, footer fragments)
│   └── 📄 [Global sample navigation, header, and footer .html files]
│
├── 📁 scripts/                       (GLOBAL Scripts)
│   └── 📄 component-loader.js        (Dynamic navbar/footer loader script)
│
├── 📁 styles/                        (GLOBAL Styles)
│   └── 📄 global.css                 (Master site stylesheet)
│
└── 📁 home-lab/                      (Documentation Category - Example Target Location)
    ├── 📄 index.html                 (Main category landing page)
    │
    ├── 📁 assets/                    (LOCAL Assets - Unique to home-lab)
    │   ├── 📁 figures/               (Proxmox topologies & network diagrams)
    │   └── 📁 icons/                 (Hardware icons & LXC/VM node styling)
    │
    ├── 📁 guides/                    (LOCAL Guides Subfolder)
    │   └── 📄 index.html             (Guides sub-index file)
    │
    └── 📁 reference/                 (LOCAL Reference Subfolder)
        └── 📄 index.html             (Reference sub-index file)
```"""

# Standardize any tabs to 4 spaces
cleaned_text = readme_text.replace('\t', '    ')

filename = "README.txt"
with open(filename, "w", encoding="utf-8") as f:
    f.write(cleaned_text)
print(f"File saved successfully as {filename}")


Your TXT file is ready
TXT icon
README
 TXT 
Open

I have saved the cleaned-up workflow instructions as README.txt, ensuring that all tab characters and spacing are uniformly aligned using 4 spaces per indentation level. You can use this file directly in your local home-lab-project folder or push it to your repository.




Gemini is AI and can make mistakes.

# Technical Documentation Workflow: Word to HTML via Pandoc

This guide outlines the workflow for converting Microsoft Word documentation (`.docx`) into clean, standalone HTML pages using **Pandoc** and **PowerShell**, complete with automated Table of Contents (TOC) generation and a structured local-to-production deployment model.

---

## Part 1: Preparing Your Microsoft Word Document

Before running any scripts, ensure your master Word document is properly formatted. Proper formatting in Word minimizes manual HTML or Markdown editing later.

1. **Heading Hierarchy:**
    * Set the main document title and major section headers to **Heading 1**.
    * Set the first level of sub-sections to **Heading 2**.
    * Set the second level of sub-sections to **Heading 3**.
    * Set captions, sub-sections, or minor labels to **Heading 4**.
2. **Elements:** Verify that all Word tables are clean and the built-in Table of Contents is fully updated. 
3. **File Naming:** Ensure the file names for your `.docx` and target `.html` files are entirely **lowercase**. Use dashes (`-`) instead of spaces for readability (e.g., `my-home-lab-guide.docx`).
4. **Clean File Type:** If working from a macro-enabled document (`.docm`), save it as a clean `.docx` file to strip out unnecessary background metadata.

> 💡 **Pro-Tip:** If you see rendering issues in the final HTML output, it is usually faster to update your master Word doc and rerun the script than it is to manually hack the HTML code.

---

## Step 1: Set Up Your Local Workspace

Open **Visual Studio Code**. Your layout template (`template.html`) should already be created and present in your working directory. 

Keep your local project folder organized on your computer using the following layout during development:

```text
📂 home-lab-project/            (Local working directory)
├── 📄 input.docx               (Your master Word file)
├── 📄 template.html            (The layout wrapper file used by Pandoc)
├── 📄 styles.css               (Your development stylesheet)
├── 📄 output.md                (Intermediate Markdown file; generated by Step 2)
├── 📂 images/                  (Automatically extracted figures and images)
├── 📂 web-images/              (Backup/source folder for your MS Word image sources)
├── 📂 web-snippets/            (Text source fragments)
└── 📂 web-scripts/             (Custom scripts and code snippets)
```

---

## Step 2: Execute the PowerShell Conversion Script

Open PowerShell and navigate to your project directory:

```powershell
cd "C:\Users\me\Documents\Proxmox\Published Documents\home-lab-project"
```

The automation workflow executes two major Pandoc operations behind the scenes:

### Command 1: Convert Word to Markdown
This extracts your media and builds a clean Markdown file for verification.
```powershell
pandoc input.docx -f docx -t markdown --wrap=none --extract-media=./images -o output.md
```
*(Optional: Open `output.md` in VS Code to review code blocks, tweak text layout, or verify sections.)*

### Command 2: Compile Markdown and Template into the Final Web Page
Once the source content is ready, run this command to compile everything into your final, styled HTML production file:
```powershell
pandoc output.md -f markdown -t html5 --template=template.html --toc --toc-depth=3 --standalone --id-prefix="nav-" -o index.html
```

### Breaking Down the Magic Parameters:
* `--template=template.html`: Instructs Pandoc to use your custom wrapper layout.
* `--toc`: Automatically scans your Markdown headings (`#`, `##`, `###`) to generate a fully linked Table of Contents, placing it exactly where the `$toc$` variable sits in your template.
* `--toc-depth=3`: Restricts the automated TOC depth to H1, H2, and H3 headings.
* `--id-prefix="nav-"`: Prefixes generated IDs to avoid styling conflicts with global CSS files.

---

## Pro-Tip for TOC Styling

Because Pandoc generates the Table of Contents automatically as a nested list (`<ul>` and `<li>`), add or update these rules in your stylesheet to ensure clean navigation links:

```css
/* Style the automatically generated Pandoc TOC */
.toc ul {
    list-style-type: none;
    padding-left: 15px;
}

.toc > ul {
    padding-left: 0; /* Remove padding for the outermost list */
}

.toc a {
    text-decoration: none;
    color: #3498db;
    display: block;
    padding: 4px 0;
}

.toc a:hover {
    text-decoration: underline;
}
```

Now, whenever you update your Markdown file, CSS, or master Word document, simply hit the **Up Arrow** in your PowerShell terminal, re-run the build sequence, and your page updates instantly!

---

## Production Deployment Structure

### What Goes on the Web Server
Once Pandoc generates your local assets, the production ready files are synchronized to your working repository path (defined within your deployment script). Local files like `template.html` and `output.md` stay safely on your local hard drive.

A typical target web directory structure looks like this:

```text
📂 public_html/                 (Target deployment folder defined in script)
├── 📄 index.html               (The final generated page, renamed to match production)
└── 📂 images/                  (Extracted figures and graphics referenced by the page)
```

### Production Server Architecture (`smart-home-edge-systems`)
Below is the master layout of the web server, showing where your individual project assets merge into the broader ecosystem:

```text
📁 smart-home-edge-systems/           (Production Root Directory)
│
├── 📄 index.html                     (Main Landing Page)
├── 📄 404.html                       (Error Page)
├── 📄 CNAME                          (Custom domain pointer)
├── 📄 .gitignore
├── 📄 robots.txt
├── 📄 sitemap.xml
│
├── 📁 .github/
│   └── 📁 workflows/                 (CI/CD Automation Scripts)
│
├── 📁 assets/                        (GLOBAL Assets)
│   ├── 📁 figures/                   (Global site banners)
│   └── 📁 icons/
│       └── 📷 main-logo.jfif         (Main site logo)
│
├── 📁 authors/
│   └── 📄 index.html
│
├── 📁 includes/                      (Global components: header, menu, footer fragments)
│   └── 📄 [Global sample navigation, header, and footer .html files]
│
├── 📁 scripts/                       (GLOBAL Scripts)
│   └── 📄 component-loader.js        (Dynamic navbar/footer loader script)
│
├── 📁 styles/                        (GLOBAL Styles)
│   └── 📄 global.css                 (Master site stylesheet)
│
└── 📁 home-lab/                      (Documentation Category - Example Target Location)
    ├── 📄 index.html                 (Main category landing page)
    │
    ├── 📁 assets/                    (LOCAL Assets - Unique to home-lab)
    │   ├── 📁 figures/               (Proxmox topologies & network diagrams)
    │   └── 📁 icons/                 (Hardware icons & LXC/VM node styling)
    │
    ├── 📁 guides/                    (LOCAL Guides Subfolder)
    │   └── 📄 index.html             (Guides sub-index file)
    │
    └── 📁 reference/                 (LOCAL Reference Subfolder)
        └── 📄 index.html             (Reference sub-index file)
