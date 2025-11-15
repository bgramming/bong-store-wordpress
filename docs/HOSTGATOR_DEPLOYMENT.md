# 🚀 HostGator Deployment Guide

Complete guide to deploying your Bong Store WordPress site to HostGator.

---

## ✅ **Why HostGator is Better Than Local:**

- ⚡ **Much Faster** - Professional servers
- 🌐 **Public Access** - Real domain name
- 🔒 **Free SSL** - HTTPS included
- 💾 **Automatic Backups** - Built-in
- 📧 **Email Support** - 24/7 help
- 🎯 **cPanel** - Easy management

---

## 📋 **What You Have:**

- ✅ HostGator account (paid until 1/3/2026)
- ✅ WordPress site built locally
- ✅ WooCommerce installed
- ✅ Age verification plugin
- ✅ Sample product

---

## 🚀 **Deployment Methods:**

### **Method 1: Fresh Install on HostGator (RECOMMENDED - Easiest)**
- Install WordPress fresh on HostGator
- Manually recreate your setup
- **Time:** 30 minutes
- **Difficulty:** Easy

### **Method 2: Export/Import (Advanced)**
- Export local database
- Upload files via FTP
- Import database
- **Time:** 1-2 hours
- **Difficulty:** Medium

---

## 🎯 **Method 1: Fresh Install (RECOMMENDED)**

This is the fastest and cleanest way!

---

## **Step 1: Access HostGator cPanel**

1. **Log into HostGator:**
   - Go to: https://portal.hostgator.com
   - Enter your credentials

2. **Access cPanel:**
   - Click **"cPanel"** or **"Manage"**
   - You'll see the cPanel dashboard

---

## **Step 2: Set Up Domain**

### **If you have a domain:**
1. In cPanel, go to **"Domains"**
2. Add your domain (e.g., bongstore.com)
3. Point nameservers to HostGator

### **If you DON'T have a domain yet:**
1. You can use HostGator's temporary domain:
   - `yourusername.hostgatorwebsite.com`
2. Or buy a domain:
   - HostGator sells domains (~$15/year)
   - Or use Namecheap, GoDaddy, etc.

---

## **Step 3: Install WordPress**

1. **In cPanel, find "Softaculous Apps Installer"**
   - Look for WordPress icon
   - Or search "WordPress"

2. **Click "Install Now"**

3. **Fill in Installation Details:**

   **Software Setup:**
   - Choose Protocol: `https://` (SSL will be auto-installed)
   - Choose Domain: Select your domain
   - In Directory: Leave BLANK (installs in root)

   **Site Settings:**
   - Site Name: `Bong Store`
   - Site Description: `Premium Smoking Accessories`

   **Admin Account:**
   - Admin Username: `admin` (or your choice)
   - Admin Password: **Strong password** (SAVE THIS!)
   - Admin Email: Your email

   **Choose Language:** English

   **Select Plugin(s):** Uncheck all (we'll install manually)

4. **Click "Install"**
   - Wait 2-3 minutes
   - You'll get a success message with:
     - Website URL
     - Admin URL
     - Admin credentials

5. **Save These URLs:**
   - **Frontend:** https://yourdomain.com
   - **Admin:** https://yourdomain.com/wp-admin

---

## **Step 4: Install SSL Certificate (Free)**

1. **In cPanel, go to "SSL/TLS Status"**
2. **Check your domain**
3. **Click "Run AutoSSL"**
4. **Wait 5 minutes** - SSL will be installed
5. **Your site will now have HTTPS** 🔒

---

## **Step 5: Install WooCommerce**

1. **Log into WordPress Admin:**
   - Go to: https://yourdomain.com/wp-admin
   - Enter your credentials

2. **Go to Plugins → Add New**

3. **Search "WooCommerce"**

4. **Click "Install Now"** → **"Activate"**

5. **Setup Wizard will appear:**
   - **Store Details:**
     - Address: Your business address
     - Country: United States
     - Currency: USD ($)
   - **Industry:** Other
   - **Product Types:** Physical products
   - **Business Details:** Fill as needed
   - **Theme:** Continue with active theme
   - **Jetpack:** Skip

6. **Click "Finish Setup"**

---

## **Step 6: Upload Age Verification Plugin**

### **Option A: Upload via WordPress Admin (Easiest)**

1. **Zip the plugin folder locally:**
   - Go to: `C:\Users\bgram\Programming\github-repos\bong-store-wordpress\wp-content\plugins\`
   - Right-click `age-verification` folder
   - Send to → Compressed (zipped) folder
   - Name it: `age-verification.zip`

2. **In WordPress Admin:**
   - Go to **Plugins → Add New**
   - Click **"Upload Plugin"**
   - Click **"Choose File"**
   - Select `age-verification.zip`
   - Click **"Install Now"**
   - Click **"Activate"**

3. **Configure Age Verification:**
   - Go to **Settings → Age Verification**
   - Minimum Age: **18**
   - Message: "You must be 18 years or older to enter this site."
   - Remember Duration: **30 days**
   - Click **"Save Changes"**

### **Option B: Upload via FTP (Alternative)**

1. **Get FTP Credentials from cPanel:**
   - In cPanel, go to **"FTP Accounts"**
   - Create FTP account or use main account

2. **Use FileZilla or WinSCP:**
   - Host: `ftp.yourdomain.com`
   - Username: Your FTP username
   - Password: Your FTP password
   - Port: 21

3. **Navigate to:**
   - `/public_html/wp-content/plugins/`

4. **Upload the `age-verification` folder**

5. **Activate in WordPress Admin:**
   - Go to **Plugins → Installed Plugins**
   - Find **Age Verification**
   - Click **"Activate"**

---

## **Step 7: Create Product Categories**

1. **Go to Products → Categories**

2. **Add these categories:**
   - **Glass Bongs**
     - Description: "High-quality glass bongs and water pipes"
   - **Accessories**
     - Description: "Smoking accessories and supplies"
   - **Vaporizers**
     - Description: "Electronic vaporizers and vape pens"
   - **Apparel**
     - Description: "T-shirts, hoodies, and merchandise"

---

## **Step 8: Add Your First Product**

1. **Go to Products → Add New**

2. **Product Details:**
   - **Name:** "Classic Glass Bong - 12 inch"
   - **Description:** 
     ```
     High-quality borosilicate glass bong with ice catcher and diffused downstem. 
     Perfect for smooth, cool hits. Includes 14mm bowl piece.
     
     Features:
     - Height: 12 inches
     - Borosilicate glass
     - Ice catcher
     - Diffused downstem
     - 14mm bowl included
     
     For tobacco use only.
     ```

3. **Product Data:**
   - **Regular Price:** $89.99
   - **Sale Price:** $79.99
   - **SKU:** BONG-001
   - **Stock Status:** In stock
   - **Stock Quantity:** 25

4. **Categories:**
   - Check **"Glass Bongs"**

5. **Product Image:**
   - Click **"Set product image"**
   - Upload an image (or use placeholder)

6. **Click "Publish"**

---

## **Step 9: Configure WooCommerce Settings**

### **General Settings:**
1. **Go to WooCommerce → Settings → General**
   - **Store Address:** Your business address
   - **Currency:** US Dollar ($)
   - **Currency Position:** Left ($99.99)

### **Shipping Settings:**
1. **Go to WooCommerce → Settings → Shipping**
2. **Add Shipping Zone:**
   - **Zone Name:** United States
   - **Zone Regions:** United States
   - **Shipping Methods:**
     - **Flat Rate:** $5.00
     - **Free Shipping:** Minimum order $100

### **Tax Settings:**
1. **Go to WooCommerce → Settings → Tax**
   - **Enable Taxes:** Yes
   - **Prices Entered With Tax:** No
   - **Calculate Tax Based On:** Customer shipping address
   - **Standard Rate:** 8.5% (adjust for your state)

---

## **Step 10: Set Up Payment Gateways**

### **Stripe (Recommended):**

1. **Install Stripe Plugin:**
   - Go to **Plugins → Add New**
   - Search **"WooCommerce Stripe Gateway"**
   - Install and Activate

2. **Get Stripe API Keys:**
   - Go to: https://dashboard.stripe.com/register
   - Create account (free)
   - Go to **Developers → API Keys**
   - Copy:
     - **Publishable Key:** `pk_live_xxxxx`
     - **Secret Key:** `sk_live_xxxxx`

3. **Configure Stripe:**
   - Go to **WooCommerce → Settings → Payments**
   - Click **"Stripe"**
   - Enable Stripe
   - Paste API keys
   - **Test Mode:** Enable for testing first
   - Click **"Save Changes"**

### **PayPal (Alternative):**

1. **Go to WooCommerce → Settings → Payments**
2. **Enable "PayPal Standard"**
3. **Enter your PayPal email**
4. **Click "Save Changes"**

---

## **Step 11: Customize Your Site**

### **Install a Theme (Optional):**

1. **Go to Appearance → Themes**
2. **Click "Add New"**
3. **Search for e-commerce themes:**
   - **Astra** (free, fast)
   - **OceanWP** (free, customizable)
   - **Storefront** (WooCommerce official)
4. **Install and Activate**

### **Customize Colors:**

1. **Go to Appearance → Customize**
2. **Colors:**
   - Primary Color: `#2D5016` (Deep Green)
   - Secondary Color: `#D4AF37` (Gold)
3. **Site Identity:**
   - Upload logo
   - Set site icon (favicon)
4. **Click "Publish"**

---

## **Step 12: Create Essential Pages**

### **Privacy Policy:**
1. **Go to Pages → Add New**
2. **Title:** "Privacy Policy"
3. **Content:** Use WordPress template or write your own
4. **Publish**

### **Terms of Service:**
1. **Go to Pages → Add New**
2. **Title:** "Terms of Service"
3. **Content:** Include:
   - Age requirement (18+)
   - Product usage (tobacco only)
   - Shipping policy
   - Return policy
4. **Publish**

### **About Us:**
1. **Go to Pages → Add New**
2. **Title:** "About Us"
3. **Content:** Your store story
4. **Publish**

### **Contact:**
1. **Go to Pages → Add New**
2. **Title:** "Contact"
3. **Install Contact Form 7 plugin**
4. **Add contact form**
5. **Publish**

---

## **Step 13: Test Everything**

### **Test Age Verification:**
1. Open incognito browser
2. Go to your site
3. Should see age gate
4. Enter birth year (18+)
5. Should enter site

### **Test Shopping:**
1. Browse products
2. Add to cart
3. View cart
4. Proceed to checkout
5. Fill in details
6. Test payment (use Stripe test mode)

### **Test on Mobile:**
1. Open on phone
2. Check responsiveness
3. Test checkout process

---

## **Step 14: Security & Performance**

### **Install Security Plugin:**
1. **Install Wordfence:**
   - Go to **Plugins → Add New**
   - Search **"Wordfence Security"**
   - Install and Activate
   - Run security scan
   - Enable firewall

### **Install Backup Plugin:**
1. **Install UpdraftPlus:**
   - Go to **Plugins → Add New**
   - Search **"UpdraftPlus"**
   - Install and Activate
   - Configure backups:
     - Files: Weekly
     - Database: Daily
     - Remote storage: Google Drive or Dropbox

### **Install Caching Plugin:**
1. **Install WP Super Cache:**
   - Go to **Plugins → Add New**
   - Search **"WP Super Cache"**
   - Install and Activate
   - Enable caching

### **Optimize Images:**
1. **Install Smush:**
   - Go to **Plugins → Add New**
   - Search **"Smush"**
   - Install and Activate
   - Enable auto-compression

---

## **Step 15: Launch Checklist**

Before going live:

- [ ] Age verification working
- [ ] At least 10 products added
- [ ] All product images uploaded
- [ ] Shipping zones configured
- [ ] Payment gateways tested
- [ ] Privacy policy published
- [ ] Terms of service published
- [ ] Contact page created
- [ ] SSL certificate installed (HTTPS)
- [ ] Security plugin installed
- [ ] Backup plugin configured
- [ ] Site tested on mobile
- [ ] Checkout process tested
- [ ] Email notifications working

---

## 🎯 **Performance Comparison:**

### **Local Docker (Current):**
- ⚠️ Slow loading (5-10 seconds)
- ⚠️ Only you can access
- ⚠️ Uses your computer resources

### **HostGator (After Deployment):**
- ⚡ Fast loading (1-2 seconds)
- 🌐 Public access (anyone can visit)
- 💪 Professional server resources
- 🔒 Free SSL certificate
- 📧 24/7 support

---

## 💰 **Cost Breakdown:**

- **HostGator:** Already paid (until 1/3/2026)
- **Domain:** $15/year (if you don't have one)
- **Stripe Fees:** 2.9% + $0.30 per transaction
- **PayPal Fees:** 2.9% + $0.30 per transaction

**Total Additional Cost:** $0-15/year

---

## 🆘 **Troubleshooting:**

### **Can't access cPanel:**
- Check email for HostGator welcome message
- Contact HostGator support (24/7)

### **WordPress installation failed:**
- Check disk space in cPanel
- Try manual installation
- Contact HostGator support

### **Age verification not working:**
- Clear browser cache
- Check plugin is activated
- Verify settings saved

### **Products not showing:**
- Check product is published
- Check category assigned
- Clear cache

---

## 📞 **HostGator Support:**

- **Phone:** 1-866-96-GATOR
- **Live Chat:** Available in portal
- **Email:** Through support portal
- **Hours:** 24/7/365

---

## 🚀 **Ready to Deploy?**

Follow the steps above and your site will be:
- ⚡ **Much faster**
- 🌐 **Publicly accessible**
- 🔒 **Secure with SSL**
- 💼 **Professional**

**Estimated time:** 1-2 hours for complete setup

---

**Let's get your Bong Store live on HostGator!** 🌿

