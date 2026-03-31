# Akshvi Website — Complete Deployment Guide

## What You Have

Your website is a **single static HTML file** — all CSS, JavaScript, and SVGs are self-contained inside `index.html`. No server, no database, no backend needed. Hostinger's web server handles everything.

---

## PHASE 1: Create a GitHub Repository

1. Go to **https://github.com/new**
2. Repository name: `akshvi-website`
3. Set it to **Public** (easiest with Hostinger) or Private (requires deploy key — see below)
4. Do NOT add README or .gitignore (we already have them)
5. Click **Create repository**
6. Copy the HTTPS URL — it looks like: `https://github.com/YOUR_USERNAME/akshvi-website.git`

---

## PHASE 2: Push Code Using Claude Code (Terminal)

Open your terminal in the project folder and run:

```bash
# Navigate to your project folder
cd akshvi-website

# Initialize git and push
git init
git branch -M main
git add -A
git commit -m "Initial deploy: Akshvi website"

# Connect to your GitHub repo (replace with YOUR URL)
git remote add origin https://github.com/YOUR_USERNAME/akshvi-website.git
git push -u origin main
```

Or simply run the deployment script:

```bash
bash deploy.sh
```

---

## PHASE 3: Connect GitHub to Hostinger

1. Log in to **hPanel** at https://hpanel.hostinger.com
2. Go to **Websites** → find your site → click **Manage**
3. In the left sidebar, scroll to **Advanced** → click **Git**
4. In **"Create a New Repository"**:
   - **Repository URL**: `https://github.com/YOUR_USERNAME/akshvi-website.git`
   - **Branch**: `main`
   - **Directory**: leave empty (deploys to `/public_html` root)
5. Click **Create**

### Enable Auto-Deployment (Webhook)

After creating the repo connection:

1. In the **Manage Repositories** section, click **Auto Deployment**
2. Copy the **Webhook URL** Hostinger gives you
3. Go to your GitHub repo → **Settings** → **Webhooks** → **Add webhook**
4. Paste the Webhook URL into **Payload URL**
5. Content type: `application/x-www-form-urlencoded`
6. Select **Just the push event**
7. Check **Active**
8. Click **Add webhook**

Now every `git push` will auto-deploy your site.

### If Your Repo is Private

You'll also need to:

1. Copy the **SSH key** that Hostinger generated (shown in the Git section)
2. Go to your GitHub repo → **Settings** → **Deploy keys** → **Add deploy key**
3. Paste the SSH key, title it "Hostinger", leave "Allow write access" unchecked
4. Click **Add key**

---

## PHASE 4: Connect Your Domain

1. In hPanel, go to **Domains** → click your domain
2. If your domain was bought on Hostinger, it should auto-connect
3. If bought elsewhere, update your domain's **nameservers** to Hostinger's:
   - `ns1.dns-parking.com`
   - `ns2.dns-parking.com`
   - (Check hPanel for your exact nameservers — they may differ)

### Enable SSL (HTTPS)

1. In hPanel → your website → **Security** → **SSL**
2. Click **Install SSL** (Hostinger provides free Let's Encrypt certificates)
3. Wait a few minutes for it to activate

---

## PHASE 5: Future Updates

After the initial setup, updating your website is just:

```bash
# Edit your index.html
# Then run:
bash deploy.sh
```

Or manually:

```bash
git add -A
git commit -m "Update: description of changes"
git push
```

The webhook triggers Hostinger to pull the latest code automatically.

---

## Troubleshooting

**Site shows Hostinger default page?**
→ Make sure the Git directory field was left empty and `/public_html` has no other `index.html`

**Webhook not working?**
→ Check GitHub → Settings → Webhooks → look for green checkmark. Red X means delivery failed — verify the URL

**Domain not resolving?**
→ DNS propagation takes up to 48 hours. Use https://dnschecker.org to verify

**SSL not working?**
→ Wait 10–15 minutes after installation. Force HTTPS in hPanel settings

---

## Project Structure

```
akshvi-website/
├── index.html      ← Your complete website (all CSS/JS embedded)
├── deploy.sh       ← One-command deployment script
├── .gitignore      ← Ignores OS/IDE junk files
└── DEPLOY_GUIDE.md ← This guide
```
