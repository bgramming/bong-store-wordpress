# 🎯 Burning Beats Store Setup Checklist

Your store is live at **https://burningbeats.store**! Let's finish the setup.

---

## ✅ **What's Already Done:**

- ✅ WordPress installed and running
- ✅ WooCommerce installed
- ✅ Domain working (burningbeats.store)
- ✅ GitHub auto-deploy configured
- ✅ Basic theme active (ScapeRock)

---

## 🚀 **What Needs to Be Done:**

### **1. Activate Age Verification Plugin**

**Option A: Run Setup Script (Easiest)**
```
Double-click: SETUP_STORE.bat
```

**Option B: Manual Activation**
1. Log into WordPress admin: https://burningbeats.store/wp-admin
2. Go to: **Plugins → Installed Plugins**
3. Find: **Age Verification for Bong Store**
4. Click: **Activate**
5. Go to: **Settings → Age Verification**
6. Set minimum age: **18**
7. Click: **Save Changes**

---

### **2. Configure WooCommerce**

**Go to:** WooCommerce → Settings

#### **General Tab:**
- Store Address: Your business address
- City: Your city
- Country: United States
- Postcode: Your ZIP code
- Currency: US Dollar ($)

#### **Products Tab:**
- Shop Page: Select "Shop"
- Weight Unit: lb
- Dimensions Unit: in

#### **Shipping Tab:**
- Add Shipping Zone: **United States**
- Shipping Methods:
  - **Flat Rate:** $5.00
  - **Free Shipping:** Minimum order $100

#### **Payments Tab:**
Enable payment methods:

**Stripe (Recommended):**
1. Install: **WooCommerce Stripe Gateway** plugin
2. Get API keys from: https://dashboard.stripe.com
3. Enter keys in WooCommerce → Settings → Payments → Stripe
4. Enable test mode first

**PayPal:**
1. Enable PayPal Standard
2. Enter your PayPal email
3. Save changes

---

### **3. Add Products**

**Go to:** Products → Add New

**Example Product:**
- **Name:** Classic Glass Bong - 12 inch
- **Price:** $89.99
- **Sale Price:** $79.99
- **Description:**
  ```
  High-quality borosilicate glass bong with ice catcher 
  and diffused downstem. Perfect for smooth, cool hits.
  
  Features:
  - Height: 12 inches
  - Borosilicate glass
  - Ice catcher
  - Diffused downstem
  - 14mm bowl included
  
  For tobacco use only.
  ```
- **Categories:** Glass Bongs
- **Product Image:** Upload image
- **Inventory:**
  - SKU: BONG-001
  - Stock: In stock
  - Quantity: 25

**Click:** Publish

**Repeat for 5-10 products minimum**

---

### **4. Create Essential Pages**

#### **About Us Page:**
1. Go to: **Pages → Add New**
2. Title: **About Us**
3. Content: Your store story
4. Publish

#### **Contact Page:**
1. Go to: **Pages → Add New**
2. Title: **Contact**
3. Install: **Contact Form 7** plugin
4. Add contact form
5. Publish

#### **Privacy Policy:**
1. Go to: **Settings → Privacy**
2. Create privacy policy page
3. Include:
   - Age requirement (18+)
   - Data collection
   - Cookie usage
   - Payment security

#### **Terms of Service:**
1. Go to: **Pages → Add New**
2. Title: **Terms of Service**
3. Include:
   - Age requirement
   - Product usage (tobacco only)
   - Shipping policy
   - Return policy
   - Liability disclaimer

---

### **5. Configure Theme**

**Go to:** Appearance → Customize

#### **Site Identity:**
- Upload logo
- Set site icon (favicon)
- Tagline: "Premium Smoking Accessories"

#### **Colors:**
- Primary Color: `#2D5016` (Deep Green)
- Secondary Color: `#D4AF37` (Gold)
- Background: `#FFFFFF` (White)

#### **Menus:**
Create main menu with:
- Home
- Shop
- About Us
- Contact
- My Account

#### **Homepage Settings:**
- Set homepage to: Custom page or Shop page
- Set posts page to: Blog

---

### **6. Install Essential Plugins**

**Security:**
- **Wordfence Security** - Firewall & malware scanner
  - Go to: Plugins → Add New
  - Search: "Wordfence"
  - Install & Activate
  - Run security scan

**Backups:**
- **UpdraftPlus** - Automated backups
  - Install & Activate
  - Configure:
    - Files: Weekly
    - Database: Daily
    - Remote storage: Google Drive or Dropbox

**Performance:**
- **WP Super Cache** - Speed optimization
  - Install & Activate
  - Enable caching

**Images:**
- **Smush** - Image compression
  - Install & Activate
  - Enable auto-compression

**SEO:**
- **Yoast SEO** - Search engine optimization
  - Install & Activate
  - Run configuration wizard

---

### **7. Enable SSL Certificate**

1. **Log into cPanel**
2. **Go to:** SSL/TLS Status
3. **Find:** burningbeats.store
4. **Click:** Run AutoSSL
5. **Wait:** 5-10 minutes
6. **Update WordPress URLs:**
   - Go to: Settings → General
   - WordPress Address: `https://burningbeats.store`
   - Site Address: `https://burningbeats.store`
   - Save Changes

---

### **8. Test Everything**

#### **Test Age Verification:**
1. Open incognito window
2. Visit: https://burningbeats.store
3. Should see age gate
4. Enter birth year (18+)
5. Should enter site

#### **Test Shopping:**
1. Browse products
2. Add to cart
3. View cart
4. Proceed to checkout
5. Fill in details
6. Test payment (use Stripe test mode)

#### **Test on Mobile:**
1. Open on phone
2. Check responsiveness
3. Test checkout process
4. Test age verification

---

### **9. Configure Email Notifications**

**Go to:** WooCommerce → Settings → Emails

Enable and customize:
- **New Order** - Notification to you
- **Order Confirmation** - Customer receipt
- **Order Complete** - Fulfillment confirmation

**Test emails:**
- Place test order
- Check if emails arrive
- Verify formatting

---

### **10. Set Up Analytics**

**Google Analytics:**
1. Create account: https://analytics.google.com
2. Get tracking ID
3. Install: **MonsterInsights** plugin
4. Connect Google Analytics
5. Enable e-commerce tracking

---

## 📋 **Final Checklist:**

Before launching:

- [ ] Age verification working
- [ ] At least 10 products added
- [ ] All product images uploaded
- [ ] Shipping zones configured
- [ ] Payment gateways tested
- [ ] Privacy policy published
- [ ] Terms of service published
- [ ] Contact page created
- [ ] About page created
- [ ] SSL certificate installed (HTTPS)
- [ ] Security plugin installed
- [ ] Backup plugin configured
- [ ] Site tested on mobile
- [ ] Checkout process tested
- [ ] Email notifications working
- [ ] Analytics configured

---

## 🎯 **Quick Setup (Automated):**

**Run this to configure everything automatically:**

```
Double-click: SETUP_STORE.bat
```

This will:
- ✅ Activate Age Verification plugin
- ✅ Configure WooCommerce settings
- ✅ Create product categories
- ✅ Set up shop pages

**Then manually:**
- Add products
- Configure payments
- Enable SSL
- Install security plugins

---

## 📞 **Need Help?**

### **WordPress Admin:**
- URL: https://burningbeats.store/wp-admin
- Username: [your admin username]
- Password: [your admin password]

### **HostGator Support:**
- Phone: 1-866-96-GATOR
- Live Chat: Available in portal
- Hours: 24/7/365

### **Payment Gateway Support:**
- **Stripe:** https://stripe.com/docs
- **PayPal:** https://developer.paypal.com

---

## 🚀 **Ready to Launch?**

**Run:** `SETUP_STORE.bat`

Then follow this checklist to complete your store setup!

**Your store will be ready to accept orders in 2-3 hours!** 🌿💰

