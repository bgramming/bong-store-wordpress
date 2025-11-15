# 🚀 HostGator Quick Start - Deploy in 10 Minutes!

Your SSH key is ready! Let's get your Bong Store live.

---

## ⚡ **FASTEST METHOD - Use Password (Recommended)**

### **What You Need:**
- ✅ Your HostGator domain name
- ✅ Your cPanel password
- ✅ 10 minutes

### **Steps:**

1. **Double-click:** `DEPLOY_NOW.bat`

2. **Choose Option 1** (Deploy with PASSWORD)

3. **Enter when prompted:**
   - Domain name (e.g., `yourdomain.com`)
   - Site title: `Bong Store`
   - Admin username: `admin` (or your choice)
   - Admin password: **Make it strong & SAVE IT!**
   - Admin email: Your email
   - Confirm URL: `yes`

4. **Enter your cPanel password** when prompted (multiple times - this is normal)

5. **Wait 5-10 minutes** while it installs

6. **Done!** Your site opens automatically 🎉

---

## 🔍 **Find Your Domain Name:**

### **Option A: HostGator Portal**
1. Go to: https://portal.hostgator.com
2. Log in
3. Look for **"Domains"** section
4. Your domain is listed there

### **Option B: cPanel**
1. Log into cPanel
2. Top right corner shows your domain

### **Option C: Welcome Email**
1. Search email for "HostGator"
2. Look for welcome/setup email
3. Domain is listed there

### **Common Formats:**
- `yourdomain.com`
- `yoursite.com`
- `burning5.hostgatorwebsite.com` (temporary)

---

## 🔑 **Find Your cPanel Password:**

### **If you know it:**
✅ Use it! It's the same as your SSH password.

### **If you forgot it:**
1. Go to: https://portal.hostgator.com
2. Click **"Forgot Password"**
3. Follow reset instructions
4. Check your email

### **If you can't reset it:**
1. Call HostGator: **1-866-96-GATOR**
2. Say: "I need to reset my cPanel password"
3. They'll help you immediately (24/7 support)

---

## 📋 **What the Script Does:**

1. ✅ Connects to your HostGator server
2. ✅ Installs WP-CLI (WordPress command-line tool)
3. ✅ Downloads and installs WordPress
4. ✅ Installs WooCommerce
5. ✅ Uploads your Age Verification plugin
6. ✅ Creates product categories
7. ✅ Configures everything
8. ✅ Opens your live site!

**Total time:** 5-10 minutes

---

## ⚠️ **If Database Error Occurs:**

The script might say: "Database doesn't exist"

**Fix it in 2 minutes:**

1. **Log into cPanel**

2. **Go to:** MySQL Databases

3. **Create Database:**
   - Name: `burning5_wpdb`
   - Click "Create Database"

4. **Create User:**
   - Username: `burning5_wpuser`
   - Password: `SecureWP2024!`
   - Click "Create User"

5. **Add User to Database:**
   - User: `burning5_wpuser`
   - Database: `burning5_wpdb`
   - Check "ALL PRIVILEGES"
   - Click "Add"

6. **Run the deployment script again**

---

## 🔒 **After Deployment - Enable SSL (5 minutes):**

1. **Log into cPanel**

2. **Go to:** SSL/TLS Status

3. **Check your domain**

4. **Click:** "Run AutoSSL"

5. **Wait 5 minutes**

6. **Done!** Your site now has HTTPS 🔒

---

## ✅ **Post-Deployment Checklist:**

After deployment completes:

- [ ] **Log into WordPress admin**
  - URL: `https://yourdomain.com/wp-admin`
  - Use the credentials you entered

- [ ] **Configure Age Verification**
  - Go to: Settings → Age Verification
  - Minimum Age: **18**
  - Message: "You must be 18 years or older to enter this site."
  - Cookie Duration: **30 days**
  - Click **Save Changes**

- [ ] **Test Age Gate**
  - Open incognito window
  - Visit your site
  - Should see age verification
  - Enter birth year (18+)
  - Should enter site

- [ ] **Add Products**
  - Go to: Products → Add New
  - Add at least 5 products
  - Set prices, images, descriptions

- [ ] **Set Up Payments**
  - Go to: WooCommerce → Settings → Payments
  - Enable Stripe or PayPal
  - Add API keys
  - Test checkout

- [ ] **Configure Shipping**
  - Go to: WooCommerce → Settings → Shipping
  - Add shipping zones
  - Set rates

- [ ] **Enable SSL**
  - cPanel → SSL/TLS Status
  - Run AutoSSL

- [ ] **Test Everything**
  - Browse products
  - Add to cart
  - Complete checkout
  - Test on mobile

---

## 🎯 **Your Credentials (SAVE THESE!):**

After deployment, you'll get:

**WordPress Admin:**
```
URL: https://yourdomain.com/wp-admin
Username: [what you entered]
Password: [what you entered]
Email: [what you entered]
```

**Database:**
```
Name: burning5_wpdb
User: burning5_wpuser
Password: SecureWP2024!
Host: localhost
```

**SSH:**
```
Host: yourdomain.com
User: burning5
Password: [your cPanel password]
Path: /home4/burning5/public_html
```

---

## 🆘 **Troubleshooting:**

### **"Could not connect to server"**

**Check:**
1. Domain name is correct
2. SSH is enabled (contact HostGator if not)
3. Password is correct

**Fix:** Call HostGator: 1-866-96-GATOR

### **"Database error"**

**Fix:** Create database manually (see "If Database Error Occurs" above)

### **"Permission denied"**

**Fix:** Make sure you're using your cPanel password

### **"Plugin upload failed"**

**Fix:** Upload manually via cPanel File Manager:
1. Go to: Files → File Manager
2. Navigate to: `public_html/wp-content/plugins/`
3. Upload `age-verification.zip`
4. Extract it
5. Activate in WordPress admin

---

## 📞 **HostGator Support:**

**Available 24/7/365:**
- **Phone:** 1-866-96-GATOR (1-866-964-2867)
- **Live Chat:** In portal
- **Email:** Through support portal

**They can help with:**
- Enabling SSH access
- Creating databases
- Resetting passwords
- Enabling SSL
- Any server issues

---

## 🚀 **Ready to Deploy?**

### **Method 1: Double-Click (Easiest)**
Double-click: `DEPLOY_NOW.bat`

### **Method 2: PowerShell**
```powershell
cd C:\Users\bgram\Programming\github-repos\bong-store-wordpress
.\DEPLOY_WITH_PASSWORD.ps1
```

### **Method 3: Manual (cPanel)**
Follow the guide: `HOSTGATOR_DEPLOYMENT.md`

---

## 🎉 **After Deployment:**

Your store will be:
- ⚡ **Fast** - Professional hosting
- 🌐 **Public** - Anyone can visit
- 🔒 **Secure** - SSL certificate
- 💳 **Ready** - Accept payments
- 📱 **Mobile-friendly** - Responsive

**Start selling!** 🌿💰

---

## 💡 **Pro Tips:**

1. **Use a strong admin password** - Save it in a password manager

2. **Enable SSL immediately** - Customers trust HTTPS

3. **Add 10+ products before launching** - Make it look professional

4. **Test checkout thoroughly** - Use Stripe test mode first

5. **Take backups regularly** - Install UpdraftPlus plugin

6. **Monitor orders** - Check WooCommerce → Orders daily

7. **Respond to customers** - Good service = repeat business

---

## 🎯 **Next Steps After Going Live:**

1. **Marketing:**
   - Share on social media
   - Tell friends and family
   - Create Instagram/Facebook page

2. **SEO:**
   - Install Yoast SEO plugin
   - Add product descriptions
   - Use good images

3. **Analytics:**
   - Set up Google Analytics
   - Track visitor behavior
   - Optimize based on data

4. **Growth:**
   - Add more products
   - Run promotions
   - Build email list

---

**Ready? Let's deploy!** 🚀

Double-click `DEPLOY_NOW.bat` and follow the prompts!

