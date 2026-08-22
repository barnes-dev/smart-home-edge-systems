![Figure 1: Your Home in the
Clouds!](./media/media/image1.png){width="6.499997812773404in"
height="3.54545384951881in"}

# Basic Home Lab Configuration

### A Home Lab self-contained in a single mini-computer.

![](./media/media/image2.png){width="6.5in"
height="3.548338801399825in"}

#### Figure 2: Proxmox VE 9.2.3 / Minicomputer Architecture & Network Diagram

Note: If you want to use this information in an AI window -- select this
section into your chat window to reference the entire configuration.
This can be helpful if you want to ask any AI questions regarding your
Home Lab configuration. Just tell your AI client \"gemini\" to load this
config your reference in your conversation. It might be helpful to tell
your AI conversation:

> \"Please start a clean conversation, flush all buffers and caches and
> then load this config for reference.\"

+---------------------------------------------------------------------------+
| ========================================================================= |
|                                                                           |
| Barnes Home Lab Configuration                                             |
|                                                                           |
| KAMRUI HYPER H2 MINI PC (10C / 16T \| 32GB RAM / up to 4.9GHz)            |
|                                                                           |
| Proxmox VE 9.2.3 / Dedicated Ethernet / Intel Core i7-13620H              |
|                                                                           |
| Integrated GPU: Intel UHD Graphics (13th Gen) / 1TB PCIe NVMe SSD         |
|                                                                           |
| ========================================================================= |
|                                                                           |
| \[ PROXMOX VE HOST \] \-\-\-\-\-\-\-\-- Reserve 2GB RAM / 2 Threads for   |
| overhead \]                                                               |
|                                                                           |
| │ 192.168.86.250                                                          |
|                                                                           |
| ├──► \[ VM 101 \] HOME ASSISTANT OS (HAOS)                                |
|                                                                           |
| │ ├── CPU: 2 Cores (vCPUs)                                                |
|                                                                           |
| │ ├── RAM: 4 GB (Dedicated)                                               |
|                                                                           |
| │ ├── STO: 32 GB - 64 GB NVMe                                             |
|                                                                           |
| │ ├── 192.168.86.251 - Primary LAN Segment (vmbr0) eth0                   |
|                                                                           |
| │ └── 10.0.10.1/24 - Isolated Backend Segment (vmbr1 -                    |
|                                                                           |
| │ No Gateway/DNS Emulation) eth1                                          |
|                                                                           |
| ├──► \[ LXC 100 \] DNSMASQ SERVER (PiHole)                                |
|                                                                           |
| │ ├── CPU: 1 Core (vCPU)                                                  |
|                                                                           |
| │ ├── RAM: 512 MB (Ultra-lightweight)                                     |
|                                                                           |
| │ ├── STO: 2 GB NVMe                                                      |
|                                                                           |
| │ └── 192.168.86.254 (Currently .249 until production release)            |
|                                                                           |
| ├──► \[ LXC 102 \] NGINX PROXY MANAGER                                    |
|                                                                           |
| │ ├── CPU: 2 Cores (vCPUs)                                                |
|                                                                           |
| │ ├── RAM: 1 GB (Scalable)                                                |
|                                                                           |
| │ ├── STO: 8 GB (OS) + Mount point to external storage for media          |
|                                                                           |
| │ └── 192.168.86.252                                                      |
|                                                                           |
| ├──► \[ LXC 103 \] OLLAMA LLM ENGINE                                      |
|                                                                           |
| │ ├── CPU: 6 Cores (vCPUs) \-\--\> (Uses high-perf Intel P-Cores)         |
|                                                                           |
| │ ├── GPU Passthru: Vulkan0 Intel(R) Graphics (RPL-P)                     |
|                                                                           |
| │ type=iGPU total=23.3 GiB Ram                                            |
|                                                                           |
| │ ├── RAM: 16 GB (Allows up to 8B/11B parameter models)                   |
|                                                                           |
| │ ├── STO: 40 GB NVMe \-\-\-\-\-\-\--\> (Large capacity for model         |
| weights)                                                                  |
|                                                                           |
| │ ├── LAM: gemma3:4b \-\-\-\-\-\-\-\--\> Multimodal (Vision) & 128K       |
| Context Window                                                            |
|                                                                           |
| │ ├── LAM: phi4-mini:latest \--\> Logic, Intense Reasoning, & Tool        |
| Calling                                                                   |
|                                                                           |
| │ ├── LAM: qwen2.5-coder:7b \--\> Complex Automation Engineering,         |
|                                                                           |
| │ Code Sandbox, & YAML Chat                                               |
|                                                                           |
| │ ├── LAM: qwen2.5-coder:1.5b -\> Inline IDE Autocomplete Engine          |
|                                                                           |
| │ (Fed via Desktop on LAN)                                                |
|                                                                           |
| │ ├── LAM: nomic-embed-text \--\> Vector Embeddings & Local               |
|                                                                           |
| │ Document Context Parsing                                                |
|                                                                           |
| │ ├── 192.168.86.253 - Primary LAN Segment (vmbr0) eth0                   |
|                                                                           |
| │ └── 10.0.10.3/24 - Isolated Backend Segment (vmbr1 - No                 |
|                                                                           |
| │ Gateway/DNS Emulation) eth1                                             |
|                                                                           |
| ├──► \[ LXC 104 \] WYOMING-DOCKER                                         |
|                                                                           |
| │ ├── CPU: 2 Cores (vCPUs)                                                |
|                                                                           |
| │ ├── RAM: 2 GB (Scalable)                                                |
|                                                                           |
| │ ├── STO: 10 GB (OS) + Mount point to external storage for               |
|                                                                           |
| │ media                                                                   |
|                                                                           |
| │ ├── ports: 10200:10200                                                  |
|                                                                           |
| │ ├── volumes: piper-data:/data                                           |
|                                                                           |
| │ ├── 192.168.86.248 - Primary LAN Segment (vmbr0) eth0                   |
|                                                                           |
| │ └── 10.0.10.4/24 - Isolated Backend Segment (vmbr1) eth1                |
|                                                                           |
| └──► \[ LXC 105 \] TWINGATE CONNECTOR                                     |
|                                                                           |
| ├── CPU: 1 Core (vCPU)                                                    |
|                                                                           |
| ├── RAM: 512 MB (Ultra-lightweight)                                       |
|                                                                           |
| ├── STO: 2 GB NVMe (OS Only)                                              |
|                                                                           |
| └── 192.168.86.247 - Primary LAN Segment (vmbr0) eth0                     |
|                                                                           |
| (Routes 192.168.86.0/24 Securely)                                         |
+===========================================================================+

#### Code 1: Barnes Home Lab Configuration

## Setting up a Domain Name

Reserve your spot now if you think you want to present an image to the
external world. Names are unique to the individual person or company.
Cost can influence your Domain Name. I have found that a .us domain
costs around \$7 US dollars per year. That is probably the cheapest you
can find. I have a reference paper that you can read in helping you
decide what extension you want. I also have found the cheapest overall
solution is to skip the middleman (can introduce unknown costs and make
the creation and decision more complicated). Read my paper called
[Choosing a Domain
Name](../../smart-home-edge-systems/home-lab/reference/choosing-your-domain-name.html).
Here are the steps, when you are ready to register your Domain Name.

1.  Create an account on [GitHub](https://github.com) if you don\'t
    already have one.

2.  Create an account on [Cloudfare.com](https://dash.cloudflare.com/)

3.  Point the connector to your GitHub account for login purposes to
    simplify authentication.

### Step 1: Register Your New Domain 

Cloudflare operates as an official domain registrar, selling domain
names at wholesale cost without added markups.

1.  Log in to your [Cloudflare Dashboard](https://dash.cloudflare.com/).

2.  On the left sidebar of your account home page, click **Domain
    Registration** \> **Register Domains**.

3.  Type the domain name you want in the search bar and press **Enter**.

4.  Check the availability list. Click **Add to cart** next to your
    preferred extension (e.g., .com, .org, .net).

5.  Click **Purchase Now**.

6.  Select your registration term length (e.g., 1 year) and fill out
    your **Contact Information** (required by ICANN for domain ownership
    logs). Cloudflare provides free WHOIS privacy, so your personal
    details will stay hidden from the public.

7.  Enter your payment details and click **Finalize Checkout**.

### Step 2: Access Your New DNS Dashboard

Because you bought the domain directly through Cloudflare, the
nameservers are already configured automatically. You do not need to
change any registrar settings to start using it.

1.  Go back to your main **Cloudflare Dashboard** home page.

2.  Click on your newly purchased domain name from your website list.

3.  In the left sidebar, navigate to **DNS** \> **Records**.

4.  From the active DNS management pane, click **Add Record** to point
    your new domain to your web host, GitHub Pages, or an email provider
    using the exact setup steps described previously.

## Setting up a Public Repository on Github

To share files and host a web page on GitHub, you need to create a
**repository**, upload your files, and activate **GitHub Pages**.

Follow this step-by-step process to get everything up and running.

### Step 1: Create a Public Repository 

GitHub Pages requires a public repository to host web pages for free.

Log in to your [GitHub account](https://github.com/).

Click the **+** (plus) icon in the top-right corner and select **New
repository**.

Configure your repository settings:

- **Repository name**: Type a name (e.g., home-lab-site).

- **Public/Private**: Select **Public**.

- **Initialize this repository with**: Check the box for **Add a README
  file**.

- Click **Create repository**.

### Step 2: Upload Your Files

Your main web page must be named exactly index.html (all lowercase, and
no spaces) for GitHub to recognize it as the homepage.

Inside your new repository

- click the **Add file** dropdown button and choose **Upload files**.

Drag and drop your website files into the box. Ensure your main page is
named index.html. You can also drop any other files (like PDFs, images,
or ZIPs) you want to share.

Scroll down to **Commit changes**

- add a short note describing your upload and click **Commit changes**.

### Step 3: Turn on GitHub Pages 

Now, tell GitHub to turn those uploaded files into a live website.

- Click the **Settings** tab at the top of your repository.

- In the left-hand sidebar menu, scroll down to the *Code and
  automation* section and click **Pages**.

- Under **Build and deployment** \> **Source**, keep it set to **Deploy
  from a branch**.

- Under **Branch**, click the dropdown that says *None*, change it to
  **main** (or *master*), leave the folder as / (root), and click
  **Save**.

- Wait about 1 to 2 minutes. Refresh the page, and a live link will
  appear at the top of the Pages section (e.g., https://github.io).

### Step 4: Share Your Files and Site

**To share the live website**: Give people the URL generated in **Step
3**.

**To share direct file downloads**: Append the exact file name to your
website URL. For example, if you uploaded a file named brochure.pdf,
your shareable download link is:\
https://github.io

## Pointing it to Git Hub

To point a custom domain managed by **Cloudflare** to a **GitHub Pages**
web page, you need to configure specific **DNS records** in Cloudflare
and input your domain inside your **GitHub repository settings**.

Follow this complete step-by-step walkthrough to link your domain.

### Step 1: Configure DNS Records in Cloudflare 

First, you need to map your root domain (e.g., example.com) and your
subdomain (e.g., www.example.com) to GitHub\'s infrastructure.

1.  Log in to your [Cloudflare Dashboard](https://dash.cloudflare.com/)
    and select your domain name.

2.  In the left-hand sidebar, navigate to **DNS** \> **Records**.

3.  Delete any existing A or CNAME records that are currently pointing
    your root (@) or www subdomains to another host.

4.  Add four separate **A records** for your root domain using GitHub's
    official IP addresses:

    - Click **Add Record**, choose Type **A**, set the Name to @,
      **Proxy status** set to **DNS Only** (grey cloud), and input the
      IPv4 address 185.199.108.153.

    - Repeat this process to add the remaining three IP addresses:

      - 185.199.109.153

      - 185.199.110.153

      - 185.199.111.153

5.  Add a **CNAME record** to handle traffic arriving via www:

    - Click **Add Record**, choose Type **CNAME**, set the Name to www,
      and set the Target to your default GitHub Pages URL (e.g.,
      yourusername.github.io).

6.  **Add MX Records (Mail Exchange**

> **You must delete any existing MX records from previous email hosts
> and add three separate Cloudflare MX records:**
>
> **Type Mail Server Priority**
>
> **MX @ route3.mx.cloudflare.net 45**
>
> **MX @ Route2.mx.cloudflare.net 19**
>
> **MX @ route1.mx.cloudflare.net 2**

7.  **Add SPF Record (Sender Policy Framework)**

> **This TXT record authorizes Cloudflare to safely forward your emails
> without major email providers (like Gmail) flagging them as spam.**
>
> **Type: TXT**
>
> **Name: @**
>
> **Value: \"v=spf1 include:\_spf.mx.cloudflare.net \~all\"**
>
> **Note: You are only allowed to have one SPF record on your root
> domain. If you already have an existing SPF record (for example, from
> Google Workspace or Microsoft 365), you must merge them together by
> inserting**
>
> **include:\_spf.mx.cloudflare.net right before the \~all or -all
> tag.**

8.  **Find the Value in Your Settings**

<!-- -->

1.  **Log in to the Cloudflare Dashboard and select your domain name.**

2.  **In the left-hand sidebar, click Compute \> Email Service \> Email
    Routing.**

3.  **Click on the Settings tab at the top of the page.**

4.  **Scroll down to the DNS records section.**

5.  **Look for the row where the record name begins with
    cf2024-1.\_domainkey.**

6.  **Click on that row to expand it, and copy the full value string
    (the long text code starting with v=DKIM1; p=).**

<!-- -->

9.  **Publish the Record to Your DNS**

> **If Cloudflare doesn\'t add it automatically, or if you prefer to
> publish it manually:**

1.  **In the left sidebar of your dashboard, click DNS \> Records.**

2.  **Click the Add record button.**

3.  **Set the Type dropdown to TXT.**

4.  **In the Name field, type exactly: cf2024-1.\_domainkey.**

5.  **In the Content (or Value) field, paste the long text string you
    just copied from your Email Routing settings.**

6.  **Leave the TTL on Auto, make sure Proxy Status is set to DNS Only
    (grey cloud), and click Save.**

<!-- -->

10. **Important Proxy Status Rule**: Ensure the **Proxy status** toggle
    for all five newly created records is set to **DNS Only** (grey
    cloud) during the initial setup. This allows GitHub to verify the
    domain ownership and successfully issue an SSL certificate. You
    should change this to *Proxied* (orange cloud) later to enforce
    Cloudflare\'s security protections.

![](./media/media/image3.png){width="6.660107174103237in"
height="3.0812729658792652in"}

#### Figure 4: Cloudflare DNS Configuration

### Step 2: Configure Your Custom Domain in GitHub 

Now, inform GitHub that your repository should accept traffic
originating from your custom domain.

1.  Log in to GitHub and open the repository hosting your web page.

2.  Click on the **Settings** tab located at the top of your repository
    navigation bar.

3.  Scroll down the left sidebar menu and click on **Pages**.

4.  Under the **Custom domain** section, type your root domain (e.g.,
    example.com) into the text box and click **Save**.

5.  GitHub will instantly create a file named CNAME in the root of your
    main repository branch.

6.  Wait a few minutes (1-15) for the **DNS check** on the GitHub page
    to clear and the Enforce HTTPS box to become available.

- The \"Enforce HTTPS\" checkbox on GitHub is grayed out for one
  specific reason: **GitHub hasn\'t finished provisioning your SSL/TLS
  security certificate yet.**

- When you change your DNS settings (like fixing that CNAME record),
  GitHub has to talk to Let\'s Encrypt to issue a secure certificate for
  your custom domain. Until that process completes, it won\'t let you
  check that box.

7.  Once it successfully clears, check the box labeled **Enforce HTTPS**
    to secure your live site.

### Step 3. Enable Email Routing

**1. Set Up** Enable Email Routing

1.  Log in to your [Cloudflare Dashboard](https://dash.cloudflare.com/).

2.  Select your **domain** from the list.

3.  On the left sidebar, click **Email** \> **Email Routing**.

4.  Click the blue **Get Started** button.

**2. Set Up Your Destination Address**

1.  Enter your **Destination address** (your personal email, like
    yourname@gmail.com).

2.  Click **Save**.

3.  Check your personal inbox for a verification email from Cloudflare
    and click the **Verify email address** link.

**3. Create a Routing Rule**

1.  Go back to the **Email Routing** page in Cloudflare.

2.  Click the **Routes** tab at the top, then click **Create address**.

3.  In the **Custom address** field, type the alias you want (e.g.,
    hello or contact).

4.  Under **Action**, select **Forward to** and choose your verified
    destination email.

5.  Click **Save**.

**4. Test It Out**

To make sure it is working seamlessly:

1.  Open a completely separate email account (like a personal email or a
    work address).

2.  Send a blank test email to your new custom domain address (e.g.,
    hello@smart-home-edge-systems.us).

3.  Check your destination inbox (the destination address you verified
    in Cloudflare earlier) to confirm the message arrives safely.

If it arrives, you are officially finished with the setup and can
completely ignore the top-left status warnings.

### Step 4. Custom Email Return Address in Gmail

**Step 1: Add Your Custom Address to Gmail**

1.  Open [Gmail](https://mail.google.com/) on your computer, click the
    **Settings gear icon (⚙️)** in the upper right, and choose **See all
    settings**.

2.  Click the **Accounts and Import** tab.

3.  Find the *Send mail as* line item and click **Add another email
    address**.

4.  A small popup window will appear:

    - **Name**: Type the display name you want recipients to see (e.g.,
      your name or business title).

    - **Email address**: Type your exact custom domain alias
      (info@smart-home-edge-systems.us).

    - **Treat as an alias**: Keep this checkbox **checked**.

5.  Click **Next Step**.

**Step 2: Configure Outbound Server Settings**

In the next section of the popup configuration panel, fill out the
settings exactly as shown below to hook into Google\'s relay pipeline:

- **SMTP Server**: smtp.gmail.com

- **Port**: 587

- **Username**: Enter your **full personal Gmail address**
  (edwin.m.barnes@gmail.com).

- **Password**: Paste the **16-character App Password** you copied
  during Step 1.

- **Secured connection choice**: Choose **Secured connection using
  TLS**.

- Click **Add Account**.

**Step 3: Verify and Lock it Down**

1.  Google will send an automated verification email with a code inside
    to your custom address.

2.  Because your Cloudflare forwarding is already live, this
    verification message will land right back in your primary Gmail
    inbox within a minute.

3.  Copy the numeric code from the body of that email, paste it into the
    open popup window validation field, and click **Verify**.

4.  Back on your Gmail **Accounts and Import** settings menu, locate the
    line beneath *Send mail as* titled *When replying to a message*.

5.  Toggle this option to **Reply from the same address the message was
    sent to**.

Now, whenever anyone fires off a message to
info@smart-home-edge-systems.us, hitting reply inside Gmail will
automatically formulate your outbound response from your professional
domain name instead of your personal address.

Would you like help setting up a **custom email signature** specifically
for your new info@ sending profile, or would you like to build an
**automated vacation auto-responder** for it?

# References

> **🌐 Cloudflare & DNS Resources**

- **Cloudflare Docs: Register a New Domain**

- [**Cloudflare Docs: Manage DNS
  Records**](https://developers.cloudflare.com/dns/manage-dns-records/)

- **[Cloudflare Docs: Domain Configuration for Email
  Service](https://developers.cloudflare.com/email-service/configuration/domains/)
  \[[1](https://developers.cloudflare.com/email-service/reference/troubleshooting/),
  [2](https://developers.cloudflare.com/email-service/configuration/domains/)\]**

> **🛠️ GitHub Pages Resources**

- [**GitHub Docs: Managing a Custom Domain for Your GitHub Pages
  Site**](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site)

- **[GitHub Docs: Configuring a Publishing Source for Your GitHub Pages
  Site](https://docs.github.com/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site)
  \[[1](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site)\]**

> **✉️ Gmail & Outbound Pipeline Resources**

- [**Gmail Help: Send Emails from an Alias or Custom
  Address**](https://support.google.com/)

- **Google Account Help: Sign in with App Passwords**

> **🐳 Self-Hosted & Environment Stack**

- [**Proxmox VE Admin Guide: Virtual Environment
  Documentation**](https://pve.proxmox.com/pve-docs/)

- [**Pi-hole Docs: Post-Install Configuration and DNS
  Rules**](https://docs.pi-hole.net/)

- [**Docker Docs: Multi-Container Orchestration via Docker
  Compose**](https://docs.docker.com/compose/)

- [**Linux/Ubuntu Manuals: Network Configuration
  Profiles**](https://ubuntu.com/server/docs)
