# 🚀 Bong Store WordPress - Setup Guide

Complete setup instructions for local development and production deployment.

---

## 📋 **Prerequisites**

### **Required Software:**
- **Docker Desktop** - https://www.docker.com/products/docker-desktop
- **Git** - https://git-scm.com/downloads
- **Code Editor** - VS Code, Sublime, or PHPStorm

### **System Requirements:**
- **RAM:** 4GB minimum, 8GB recommended
- **Disk Space:** 10GB free space
- **OS:** Windows 10/11, macOS, or Linux

---

## 🏁 **Quick Start (5 Minutes)**

### **Step 1: Clone Repository**
```bash
git clone https://github.com/bgramming/bong-store-wordpress.git
cd bong-store-wordpress
```

### **Step 2: Start Docker Containers**
```bash
docker-compose up -d
```

Wait 2-3 minutes for containers to start.

### **Step 3: Access WordPress**
Open your browser:
- **Frontend:** http://localhost:8080
- **Admin:** http://localhost:8080/wp-admin
- **phpMyAdmin:** http://localhost:8081

### **Step 4: Complete WordPress Installation**
1. Select language: **English**
2. Site Title: **Bong Store**
3. Username: **admin** (change this!)
4. Password: **Strong password**
5. Email: **your-email@example.com**
6. Click **Install WordPress**

---

## 🛒 **WooCommerce Setup**

### **Step 1: Install WooCommerce**
```bash
# Using WP-CLI
docker exec bong-store-wpcli wp plugin install woocommerce --activate
```

Or manually:
1. Go to **Plugins > Add New**
2. Search **"WooCommerce"**
3. Click **Install Now**
4. Click **Activate**

### **Step 2: Run WooCommerce Setup Wizard**
1. Go to **WooCommerce > Home**
2. Click **Run Setup Wizard**
3. **Store Details:**
   - Address: Your business address
   - Country: United States
   - Currency: USD ($)
4. **Industry:** Other
5. **Product Types:** Physical products
6. **Business Details:**
   - Selling: Yes
   - Revenue: Choose range
7. **Theme:** Skip (we'll use custom theme)
8. **Jetpack:** Skip
9. Click **Continue**

### **Step 3: Configure Store Settings**

#### **General Settings:**
```
WooCommerce > Settings > General
- Store Address: [Your address]
- Selling Location: Sell to all countries
- Shipping Location: Ship to all countries you sell to
- Currency: US Dollar ($)
```

#### **Product Settings:**
```
WooCommerce > Settings > Products
- Shop Page: Select "Shop"
- Weight Unit: oz
- Dimensions Unit: in
```

#### **Shipping Settings:**
```
WooCommerce > Settings > Shipping
- Add Shipping Zone: United States
  - Flat Rate: $5.00
  - Free Shipping: Orders over $100
- Add Shipping Zone: International
  - Flat Rate: $25.00
```

#### **Tax Settings:**
```
WooCommerce > Settings > Tax
- Enable Taxes: Yes
- Prices Entered With Tax: No
- Calculate Tax Based On: Customer shipping address
- Standard Rate: 8.5% (adjust for your state)
```

---

## 🔌 **Essential Plugins**

### **Install Core Plugins:**
```bash
# Using WP-CLI
docker exec bong-store-wpcli wp plugin install \
  woocommerce-gateway-stripe \
  woocommerce-paypal-payments \
  yith-woocommerce-wishlist \
  mailchimp-for-woocommerce \
  wordfence \
  updraftplus \
  --activate
```

### **Manual Installation:**
1. **Age Verification** (Custom - already included)
2. **Stripe Payment Gateway**
3. **PayPal Payments**
4. **YITH Wishlist**
5. **MailChimp Integration**
6. **Wordfence Security**
7. **UpdraftPlus Backup**

---

## 🎨 **Theme Setup**

### **Activate Custom Theme:**
```bash
# Using WP-CLI
docker exec bong-store-wpcli wp theme activate bong-store-theme
```

Or manually:
1. Go to **Appearance > Themes**
2. Find **Bong Store Theme**
3. Click **Activate**

### **Customize Theme:**
1. Go to **Appearance > Customize**
2. **Site Identity:**
   - Upload logo
   - Set site icon (favicon)
3. **Colors:**
   - Primary: #2D5016 (Deep Green)
   - Secondary: #D4AF37 (Gold)
4. **Menus:**
   - Create main menu
   - Add pages: Home, Shop, About, Contact
5. **Widgets:**
   - Add sidebar widgets
   - Add footer widgets
6. Click **Publish**

---

## 📦 **Adding Products**

### **Product Categories:**
```bash
# Create categories using WP-CLI
docker exec bong-store-wpcli wp term create product_cat "Glass Bongs"
docker exec bong-store-wpcli wp term create product_cat "Water Pipes"
docker exec bong-store-wpcli wp term create product_cat "Vaporizers"
docker exec bong-store-wpcli wp term create product_cat "Accessories"
docker exec bong-store-wpcli wp term create product_cat "Apparel"
```

### **Add Sample Product:**
1. Go to **Products > Add New**
2. **Product Name:** "Classic Beaker Bong - 12 inch"
3. **Description:** Detailed product description
4. **Product Data:**
   - Regular Price: $89.99
   - Sale Price: $79.99 (optional)
5. **Inventory:**
   - SKU: BONG-001
   - Stock: 25
6. **Shipping:**
   - Weight: 2 lbs
   - Dimensions: 12 x 4 x 4 inches
7. **Product Categories:** Glass Bongs
8. **Product Image:** Upload high-quality image
9. **Gallery:** Add 3-5 images
10. Click **Publish**

---

## 💳 **Payment Gateway Setup**

### **Stripe Configuration:**
1. Go to **WooCommerce > Settings > Payments**
2. Click **Stripe**
3. Enable Stripe
4. **API Keys:**
   - Get from https://dashboard.stripe.com/apikeys
   - Publishable Key: `pk_live_xxxxx`
   - Secret Key: `sk_live_xxxxx`
5. **Webhook:**
   - URL: `https://yoursite.com/wc-api/wc_stripe`
   - Events: Select all
6. Click **Save Changes**

### **PayPal Configuration:**
1. Go to **WooCommerce > Settings > Payments**
2. Click **PayPal**
3. Enable PayPal
4. **API Credentials:**
   - Get from https://developer.paypal.com
   - Client ID: `xxxxx`
   - Secret Key: `xxxxx`
5. Click **Save Changes**

---

## 🔒 **Age Verification Setup**

The custom Age Verification plugin is already included.

### **Configure Age Gate:**
1. Go to **Settings > Age Verification**
2. **Minimum Age:** 18 (or 21 depending on state)
3. **Message:** "You must be 18+ to enter this site"
4. **Remember Duration:** 30 days
5. **Redirect URL:** (leave blank to block access)
6. Click **Save Changes**

---

## 📧 **Email Configuration**

### **SMTP Setup (Recommended):**
```bash
# Install WP Mail SMTP
docker exec bong-store-wpcli wp plugin install wp-mail-smtp --activate
```

Configure:
1. Go to **WP Mail SMTP > Settings**
2. **From Email:** noreply@bongstore.com
3. **From Name:** Bong Store
4. **Mailer:** Gmail / SendGrid / Mailgun
5. Enter API credentials
6. Send test email
7. Click **Save Settings**

---

## 📊 **Analytics Setup**

### **Google Analytics:**
1. Create account at https://analytics.google.com
2. Get Measurement ID (G-XXXXXXXXXX)
3. Install plugin:
```bash
docker exec bong-store-wpcli wp plugin install google-analytics-for-wordpress --activate
```
4. Enter Measurement ID
5. Enable e-commerce tracking

### **Facebook Pixel:**
1. Create pixel at https://business.facebook.com
2. Get Pixel ID
3. Install plugin:
```bash
docker exec bong-store-wpcli wp plugin install pixelyoursite --activate
```
4. Enter Pixel ID
5. Enable e-commerce events

---

## 🔐 **Security Hardening**

### **Wordfence Configuration:**
1. Go to **Wordfence > Dashboard**
2. Run security scan
3. Enable firewall (Learning Mode first)
4. Enable two-factor authentication
5. Set up email alerts

### **Security Checklist:**
- [ ] Change default admin username
- [ ] Use strong passwords (20+ characters)
- [ ] Enable two-factor authentication
- [ ] Install SSL certificate (HTTPS)
- [ ] Disable file editing
- [ ] Limit login attempts
- [ ] Hide WordPress version
- [ ] Regular backups
- [ ] Keep everything updated

---

## 💾 **Backup Configuration**

### **UpdraftPlus Setup:**
1. Go to **Settings > UpdraftPlus Backups**
2. **Backup Schedule:**
   - Files: Weekly
   - Database: Daily
3. **Remote Storage:**
   - Choose: Dropbox / Google Drive / S3
   - Connect account
4. **Retention:** Keep 30 backups
5. Click **Save Changes**
6. Click **Backup Now** to test

---

## 🚀 **Performance Optimization**

### **Install Caching Plugin:**
```bash
docker exec bong-store-wpcli wp plugin install w3-total-cache --activate
```

### **W3 Total Cache Settings:**
1. Go to **Performance > General Settings**
2. Enable:
   - Page Cache
   - Minify (HTML, CSS, JS)
   - Browser Cache
   - Object Cache
3. Click **Save Settings**

### **Image Optimization:**
```bash
docker exec bong-store-wpcli wp plugin install smush --activate
```

Configure Smush:
- Auto-compress on upload
- Strip EXIF data
- Lazy loading

---

## 🌐 **Production Deployment**

### **Pre-Deployment Checklist:**
- [ ] Test all functionality locally
- [ ] Backup database
- [ ] Export products
- [ ] Test payment gateways
- [ ] Verify email sending
- [ ] Check mobile responsiveness
- [ ] Run security scan
- [ ] Optimize images
- [ ] Test checkout process
- [ ] Review legal pages

### **Deployment Steps:**
1. **Choose Hosting:**
   - Recommended: Bluehost, SiteGround, or Cloudways
   - Requirements: PHP 8.1+, MySQL 8.0+, SSL

2. **Install WordPress:**
   - Use hosting's one-click installer
   - Or manual installation

3. **Import Database:**
```bash
# Export local database
docker exec bong-store-db mysqldump -u wordpress -p bong_store > database/backups/export.sql

# Import to production
mysql -h production-host -u username -p database_name < export.sql
```

4. **Upload Files:**
```bash
# Sync wp-content folder
rsync -avz wp-content/ user@server:/var/www/html/wp-content/
```

5. **Update wp-config.php:**
   - Database credentials
   - Site URL
   - Security keys (generate new ones)

6. **Search & Replace URLs:**
```bash
wp search-replace 'http://localhost:8080' 'https://bongstore.com' --all-tables
```

7. **Test Everything:**
   - Homepage loads
   - Products display
   - Cart works
   - Checkout works
   - Payments process
   - Emails send

---

## 🆘 **Troubleshooting**

### **Docker Issues:**
```bash
# Restart containers
docker-compose restart

# View logs
docker-compose logs wordpress
docker-compose logs db

# Reset everything
docker-compose down -v
docker-compose up -d
```

### **WordPress Issues:**
```bash
# Reset admin password
docker exec bong-store-wpcli wp user update admin --user_pass=newpassword

# Clear cache
docker exec bong-store-wpcli wp cache flush

# Repair database
docker exec bong-store-wpcli wp db repair
```

### **Common Problems:**
1. **Can't access site:**
   - Check Docker is running
   - Verify port 8080 is not in use
   - Check firewall settings

2. **Database connection error:**
   - Wait for MySQL to fully start (2-3 minutes)
   - Check database credentials in wp-config.php

3. **Images not uploading:**
   - Check uploads.ini file
   - Verify wp-content/uploads permissions

---

## 📞 **Support**

Need help? Contact the development team:
- **Email:** dev@bongstore.com
- **Documentation:** Check docs/ folder
- **Issues:** Create GitHub issue

---

**Setup complete! Start building your store! 🌿**

