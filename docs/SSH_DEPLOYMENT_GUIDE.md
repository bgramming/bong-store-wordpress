# 🚀 SSH Deployment Guide - HostGator

Complete guide for deploying your Bong Store to HostGator using SSH access.

---

## ✅ **What You Have:**

- ✅ SSH access to HostGator server
- ✅ SSH key generated: `/home4/burning5/.ssh/cursor_ai`
- ✅ Username: `burning5`
- ✅ Server path: `/home4/burning5/public_html`

---

## 🔑 **Step 1: Set Up SSH Key on Your Computer**

### **Option A: Download the Private Key (Recommended)**

1. **Open PowerShell on your computer**

2. **Create SSH directory if it doesn't exist:**
```powershell
mkdir $env:USERPROFILE\.ssh -Force
```

3. **Download the private key from HostGator:**
```powershell
# You'll need to get the key file from the server
# If you have password access, use:
scp burning5@yourdomain.com:/home4/burning5/.ssh/cursor_ai $env:USERPROFILE\.ssh\hostgator_key
```

4. **Set correct permissions:**
```powershell
icacls "$env:USERPROFILE\.ssh\hostgator_key" /inheritance:r
icacls "$env:USERPROFILE\.ssh\hostgator_key" /grant:r "$env:USERNAME:(R)"
```

### **Option B: Use Password Authentication**

If you have your HostGator password, you can use that instead of the SSH key.

---

## 🚀 **Step 2: Run the Automated Deployment Script**

### **Quick Deploy (Easiest):**

1. **Navigate to your project:**
```powershell
cd C:\Users\bgram\Programming\github-repos\bong-store-wordpress
```

2. **Run the deployment script:**
```powershell
.\DEPLOY_TO_HOSTGATOR.ps1
```

3. **Follow the prompts:**
   - Enter your domain (e.g., `yourdomain.com`)
   - Enter site title (default: `Bong Store`)
   - Enter admin username (default: `admin`)
   - Enter admin password (**SAVE THIS!**)
   - Enter admin email
   - Enter site URL (e.g., `https://yourdomain.com`)

4. **Wait for deployment** (5-10 minutes)

5. **Done!** Your site will open automatically

---

## 📋 **What the Script Does:**

1. ✅ Tests SSH connection
2. ✅ Installs WP-CLI (if needed)
3. ✅ Downloads and installs WordPress
4. ✅ Creates database configuration
5. ✅ Installs WooCommerce
6. ✅ Uploads and activates Age Verification plugin
7. ✅ Configures WooCommerce settings
8. ✅ Creates product categories
9. ✅ Opens your live site!

---

## 🗄️ **Database Setup**

The script will attempt to create the database automatically. If it fails, create it manually:

### **In cPanel:**

1. **Go to cPanel → MySQL Databases**

2. **Create New Database:**
   - Name: `burning5_wpdb`
   - Click "Create Database"

3. **Create New User:**
   - Username: `burning5_wpuser`
   - Password: `SecurePassword123!` (or your choice)
   - Click "Create User"

4. **Add User to Database:**
   - Select user: `burning5_wpuser`
   - Select database: `burning5_wpdb`
   - Grant "ALL PRIVILEGES"
   - Click "Add"

5. **Re-run the deployment script**

---

## 🔒 **Enable SSL Certificate (HTTPS)**

After deployment, enable free SSL:

1. **Go to cPanel → SSL/TLS Status**

2. **Check your domain**

3. **Click "Run AutoSSL"**

4. **Wait 5-10 minutes**

5. **Update WordPress URL:**
```bash
ssh -i ~/.ssh/hostgator_key burning5@yourdomain.com
cd /home4/burning5/public_html
/home4/burning5/bin/wp option update home 'https://yourdomain.com'
/home4/burning5/bin/wp option update siteurl 'https://yourdomain.com'
```

---

## 🛠️ **Manual SSH Commands (Alternative)**

If you prefer to do it manually via SSH:

### **Connect to Server:**
```bash
ssh -i ~/.ssh/hostgator_key burning5@yourdomain.com
```

### **Install WP-CLI:**
```bash
cd /home4/burning5
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mkdir -p bin
mv wp-cli.phar bin/wp
echo 'export PATH=$PATH:/home4/burning5/bin' >> ~/.bashrc
source ~/.bashrc
```

### **Install WordPress:**
```bash
cd /home4/burning5/public_html
wp core download
wp config create --dbname=burning5_wpdb --dbuser=burning5_wpuser --dbpass=YOUR_PASSWORD --dbhost=localhost
wp core install --url='https://yourdomain.com' --title='Bong Store' --admin_user='admin' --admin_password='YOUR_PASSWORD' --admin_email='your@email.com'
```

### **Install WooCommerce:**
```bash
cd /home4/burning5/public_html
wp plugin install woocommerce --activate
```

### **Upload Age Verification Plugin:**
```bash
# On your local computer:
cd C:\Users\bgram\Programming\github-repos\bong-store-wordpress
Compress-Archive -Path wp-content\plugins\age-verification -DestinationPath age-verification.zip
scp -i ~/.ssh/hostgator_key age-verification.zip burning5@yourdomain.com:/home4/burning5/

# On the server:
cd /home4/burning5/public_html/wp-content/plugins
unzip /home4/burning5/age-verification.zip
cd /home4/burning5/public_html
wp plugin activate age-verification
```

---

## 🎯 **Post-Deployment Checklist:**

After deployment, complete these steps:

- [ ] Log into WordPress admin (`yourdomain.com/wp-admin`)
- [ ] Go to **Settings → Age Verification**
  - Set minimum age: **18**
  - Set message: "You must be 18 years or older to enter this site."
  - Set cookie duration: **30 days**
  - Click **Save Changes**
- [ ] Go to **WooCommerce → Settings → Payments**
  - Enable **Stripe** or **PayPal**
  - Add API keys
- [ ] Go to **WooCommerce → Settings → Shipping**
  - Set up shipping zones
  - Add shipping rates
- [ ] Go to **Products → Add New**
  - Add your products
  - Set prices, images, descriptions
- [ ] Enable SSL in cPanel
- [ ] Test age verification (open incognito window)
- [ ] Test checkout process
- [ ] Test on mobile

---

## 🔧 **Troubleshooting:**

### **SSH Connection Failed:**

**Check if SSH is enabled:**
1. Log into cPanel
2. Go to **Security → SSH Access**
3. Click **Manage SSH Keys**
4. Ensure your key is authorized

**Check if your IP is whitelisted:**
1. Some hosts require IP whitelisting
2. Contact HostGator support if needed

### **Database Creation Failed:**

**Create manually in cPanel:**
1. Go to **Databases → MySQL Databases**
2. Follow the steps in "Database Setup" section above

### **Plugin Upload Failed:**

**Upload via cPanel File Manager:**
1. Go to **Files → File Manager**
2. Navigate to `public_html/wp-content/plugins/`
3. Click **Upload**
4. Upload `age-verification.zip`
5. Right-click → Extract
6. Activate in WordPress admin

### **WP-CLI Not Found:**

**Install manually:**
```bash
ssh burning5@yourdomain.com
cd /home4/burning5
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mkdir -p bin
mv wp-cli.phar bin/wp
```

---

## 📞 **Need Help?**

### **HostGator Support:**
- **Phone:** 1-866-96-GATOR (1-866-964-2867)
- **Live Chat:** Available in portal
- **Hours:** 24/7/365

### **Common Questions:**

**Q: What's my domain?**
A: Check your HostGator welcome email or cPanel

**Q: How do I get my SSH password?**
A: It's the same as your cPanel password

**Q: Can I use a subdomain?**
A: Yes! Use `https://store.yourdomain.com` as the URL

**Q: How do I add more products?**
A: Log into WordPress admin → Products → Add New

**Q: How do I accept payments?**
A: WooCommerce → Settings → Payments → Enable Stripe/PayPal

---

## 🚀 **Performance Tips:**

After deployment, optimize your site:

### **Install Caching Plugin:**
```bash
wp plugin install wp-super-cache --activate
```

### **Install Security Plugin:**
```bash
wp plugin install wordfence --activate
```

### **Install Backup Plugin:**
```bash
wp plugin install updraftplus --activate
```

### **Optimize Images:**
```bash
wp plugin install smush --activate
```

---

## 🎉 **You're Live!**

Your Bong Store is now:
- ⚡ **Fast** - Professional hosting
- 🌐 **Public** - Anyone can visit
- 🔒 **Secure** - SSL certificate
- 💳 **Ready** - Accept payments
- 📱 **Mobile-friendly** - Responsive design

**Start selling!** 🌿💰

---

## 📝 **Save Your Credentials:**

**WordPress Admin:**
- URL: `https://yourdomain.com/wp-admin`
- Username: `[YOUR_ADMIN_USERNAME]`
- Password: `[YOUR_ADMIN_PASSWORD]`

**Database:**
- Name: `burning5_wpdb`
- User: `burning5_wpuser`
- Password: `[YOUR_DB_PASSWORD]`
- Host: `localhost`

**SSH:**
- Host: `yourdomain.com`
- User: `burning5`
- Key: `~/.ssh/hostgator_key`
- Path: `/home4/burning5/public_html`

---

**Ready to deploy?** Run `.\DEPLOY_TO_HOSTGATOR.ps1` and go live in minutes! 🚀

