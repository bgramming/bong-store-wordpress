# 🔑 Get Your SSH Key from HostGator

Your SSH key is ready on the server! Now we need to download it to your computer.

---

## 📋 **What You Need:**

- ✅ SSH key generated on server: `/home4/burning5/.ssh/cursor_ai`
- ✅ Your HostGator cPanel password
- ❌ SSH key on your computer (we'll get this now)

---

## 🚀 **Quick Setup - 3 Options:**

---

## **Option 1: Download via cPanel File Manager (EASIEST)**

### **Step 1: Access cPanel File Manager**

1. **Log into HostGator:**
   - Go to: https://portal.hostgator.com
   - Click **"cPanel"**

2. **Open File Manager:**
   - Find **"Files"** section
   - Click **"File Manager"**

3. **Show Hidden Files:**
   - Click **"Settings"** (top right)
   - Check **"Show Hidden Files (dotfiles)"**
   - Click **"Save"**

### **Step 2: Download the Private Key**

1. **Navigate to SSH folder:**
   - In the left sidebar, click **"home4"**
   - Click **"burning5"**
   - Click **".ssh"** folder

2. **Download the key:**
   - Find the file: **`cursor_ai`** (no extension)
   - Right-click → **"Download"**
   - Save to your Downloads folder

### **Step 3: Move Key to SSH Folder**

1. **Open PowerShell as Administrator**

2. **Run these commands:**
```powershell
# Create SSH directory
mkdir $env:USERPROFILE\.ssh -Force

# Move the downloaded key
Move-Item "$env:USERPROFILE\Downloads\cursor_ai" "$env:USERPROFILE\.ssh\hostgator_key" -Force

# Set correct permissions
icacls "$env:USERPROFILE\.ssh\hostgator_key" /inheritance:r
icacls "$env:USERPROFILE\.ssh\hostgator_key" /grant:r "$env:USERNAME:(R)"
```

3. **Test the connection:**
```powershell
ssh -i $env:USERPROFILE\.ssh\hostgator_key burning5@yourdomain.com
```

**✅ If you see a command prompt, you're connected!**

---

## **Option 2: Use Password Authentication (NO KEY NEEDED)**

If you don't want to deal with SSH keys, just use your password!

### **Step 1: Find Your SSH Password**

Your SSH password is the **same as your cPanel password**.

If you don't know it:
1. Go to HostGator portal
2. Click **"Reset Password"**
3. Follow the instructions

### **Step 2: Test Connection**

```powershell
ssh burning5@yourdomain.com
```

When prompted, enter your cPanel password.

**✅ If you see a command prompt, you're connected!**

### **Step 3: Modify Deployment Script**

I'll create a password-based version of the deployment script for you.

---

## **Option 3: Use SCP Command (ADVANCED)**

If you have your cPanel password, download the key directly:

```powershell
# Create SSH directory
mkdir $env:USERPROFILE\.ssh -Force

# Download the key (will prompt for password)
scp burning5@yourdomain.com:/home4/burning5/.ssh/cursor_ai $env:USERPROFILE\.ssh\hostgator_key

# Set permissions
icacls "$env:USERPROFILE\.ssh\hostgator_key" /inheritance:r
icacls "$env:USERPROFILE\.ssh\hostgator_key" /grant:r "$env:USERNAME:(R)"

# Test connection
ssh -i $env:USERPROFILE\.ssh\hostgator_key burning5@yourdomain.com
```

---

## 🎯 **What's Your Domain?**

Before we deploy, I need to know your domain name. It's one of these:

### **Check Your Domain:**

1. **In HostGator Portal:**
   - Go to: https://portal.hostgator.com
   - Look for **"Domains"** section
   - Your domain will be listed there

2. **In cPanel:**
   - Top right corner shows your primary domain

3. **Common formats:**
   - `yourdomain.com`
   - `yoursite.com`
   - `yourusername.hostgatorwebsite.com` (temporary domain)

---

## 🚀 **Ready to Deploy?**

Once you have:
- ✅ SSH key downloaded (or using password)
- ✅ Your domain name

**Run this:**

```powershell
cd C:\Users\bgram\Programming\github-repos\bong-store-wordpress
.\DEPLOY_TO_HOSTGATOR.ps1
```

---

## 🆘 **Troubleshooting:**

### **"Permission denied (publickey)"**

**Solution:** Use password authentication instead:
```powershell
ssh burning5@yourdomain.com
# Enter your cPanel password when prompted
```

### **"Could not resolve hostname"**

**Solution:** Replace `yourdomain.com` with your actual domain name.

### **"Connection refused"**

**Solution:** SSH might not be enabled. Contact HostGator support:
- Phone: 1-866-96-GATOR
- Say: "I need SSH access enabled for my account"

### **"File not found: cursor_ai"**

**Solution:** The key might be named differently. Check in cPanel File Manager:
1. Go to `/home4/burning5/.ssh/`
2. Look for files like `id_rsa`, `id_ed25519`, or `cursor_ai`
3. Download the one without `.pub` extension

---

## 📞 **Need Help?**

**HostGator Support:**
- **Phone:** 1-866-96-GATOR (1-866-964-2867)
- **Live Chat:** Available in portal
- **Hours:** 24/7/365

**What to ask:**
- "Can you help me enable SSH access?"
- "What's my domain name?"
- "How do I download my SSH private key?"

---

## 🎉 **Next Steps:**

1. ✅ Download SSH key (or use password)
2. ✅ Find your domain name
3. ✅ Run deployment script
4. ✅ Your store goes live!

**Let me know when you're ready and I'll help you deploy!** 🚀

