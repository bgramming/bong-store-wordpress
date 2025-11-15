# 🌿 Bong Store - WordPress E-Commerce

**Modern WordPress + WooCommerce online store for smoking accessories and glassware.**

---

## 🎯 **Project Overview**

A fully-featured e-commerce website built on WordPress and WooCommerce for selling:
- Glass bongs and water pipes
- Smoking accessories
- Vaporizers
- Grinders and storage
- Cleaning supplies
- Apparel and merchandise

---

## 🛠️ **Tech Stack**

### **Core Platform:**
- **WordPress** 6.4+ - Content Management System
- **WooCommerce** 8.0+ - E-commerce platform
- **MySQL** 8.0 - Database
- **PHP** 8.1+ - Backend language

### **Hosting:**
- **Docker** - Local development
- **Production Options:**
  - Bluehost / SiteGround (Managed WordPress)
  - DigitalOcean / AWS (VPS)
  - Cloudways (Managed Cloud)

### **Payment Processing:**
- **Stripe** - Credit/debit cards
- **PayPal** - Alternative payment
- **Cash on Delivery** - Local orders
- **Cryptocurrency** (optional) - Bitcoin/Ethereum

---

## 📁 **Project Structure**

```
bong-store-wordpress/
├── docker-compose.yml          # Local development setup
├── wp-content/                 # WordPress content
│   ├── themes/                 # Custom themes
│   │   └── bong-store-theme/  # Custom theme
│   ├── plugins/                # Custom plugins
│   │   └── age-verification/  # Age gate plugin
│   └── uploads/                # Product images
├── database/                   # Database backups
├── config/                     # Configuration files
│   ├── wp-config.php          # WordPress config
│   └── .htaccess              # Apache config
├── scripts/                    # Utility scripts
│   ├── backup.sh              # Backup script
│   └── deploy.sh              # Deployment script
└── docs/                       # Documentation
    ├── SETUP.md               # Setup guide
    ├── PRODUCTS.md            # Product catalog
    └── LEGAL.md               # Legal compliance
```

---

## 🚀 **Quick Start**

### **1. Local Development with Docker**

```bash
# Clone the repository
git clone https://github.com/bgramming/bong-store-wordpress.git
cd bong-store-wordpress

# Start Docker containers
docker-compose up -d

# Access WordPress
# - Frontend: http://localhost:8080
# - Admin: http://localhost:8080/wp-admin
# - Database: localhost:3306

# Default credentials
# Username: admin
# Password: admin_password_change_this
```

### **2. Initial WordPress Setup**

1. Visit http://localhost:8080/wp-admin
2. Complete WordPress installation
3. Install WooCommerce plugin
4. Configure store settings
5. Add products

---

## 🎨 **Theme Features**

### **Custom Bong Store Theme:**
- ✅ Modern, clean design
- ✅ Mobile-responsive
- ✅ Product filtering (by type, price, brand)
- ✅ Quick view functionality
- ✅ Image zoom on hover
- ✅ Age verification gate
- ✅ SEO optimized
- ✅ Fast loading (optimized images)

### **Color Scheme:**
- Primary: Deep Green (#2D5016)
- Secondary: Gold (#D4AF37)
- Accent: White (#FFFFFF)
- Background: Light Gray (#F5F5F5)

---

## 🛒 **WooCommerce Configuration**

### **Essential Plugins:**

1. **WooCommerce** - Core e-commerce
2. **Age Verification** - 18+ gate (custom plugin)
3. **WooCommerce Stripe Gateway** - Payment processing
4. **WooCommerce PayPal Payments** - Alternative payment
5. **YITH WooCommerce Wishlist** - Customer wishlists
6. **WooCommerce Product Add-Ons** - Custom options
7. **WooCommerce PDF Invoices** - Order invoices
8. **MailChimp for WooCommerce** - Email marketing

### **Optional Enhancements:**
- **WooCommerce Subscriptions** - Recurring orders
- **WooCommerce Memberships** - VIP customers
- **WooCommerce Bookings** - Appointments
- **Advanced Custom Fields** - Custom product fields
- **Smush** - Image optimization
- **Yoast SEO** - Search optimization

---

## 📦 **Product Categories**

### **Main Categories:**
1. **Glass Bongs** ($50-$500)
   - Beaker bongs
   - Straight tube bongs
   - Percolator bongs
   - Recycler bongs

2. **Water Pipes** ($30-$300)
   - Bubblers
   - Dab rigs
   - Silicone pipes
   - Mini bongs

3. **Vaporizers** ($80-$400)
   - Dry herb vaporizers
   - Concentrate vaporizers
   - Desktop vaporizers
   - Portable vaporizers

4. **Accessories** ($5-$100)
   - Grinders
   - Rolling papers
   - Lighters
   - Storage containers
   - Cleaning supplies

5. **Apparel** ($20-$60)
   - T-shirts
   - Hoodies
   - Hats
   - Stickers

---

## ⚖️ **Legal Compliance**

### **Age Verification:**
- 18+ age gate on homepage
- Age verification at checkout
- "For tobacco use only" disclaimers
- Terms of service acceptance

### **Shipping Restrictions:**
- State-by-state compliance
- International shipping rules
- Discreet packaging options
- Tracking for all orders

### **Privacy & Security:**
- GDPR compliance
- SSL certificate (HTTPS)
- Secure payment processing
- Privacy policy
- Cookie consent

---

## 💳 **Payment Setup**

### **Stripe Configuration:**
```php
// In WooCommerce > Settings > Payments
Enable Stripe
API Keys:
- Publishable Key: pk_live_xxxxx
- Secret Key: sk_live_xxxxx
- Webhook Secret: whsec_xxxxx
```

### **PayPal Configuration:**
```php
// In WooCommerce > Settings > Payments
Enable PayPal
- Client ID: xxxxx
- Secret Key: xxxxx
- Sandbox Mode: Disabled (for production)
```

---

## 📧 **Email Marketing**

### **MailChimp Integration:**
- Abandoned cart emails
- New product announcements
- Sale notifications
- Customer loyalty program
- Birthday discounts

### **Email Templates:**
- Order confirmation
- Shipping notification
- Delivery confirmation
- Review request
- Promotional emails

---

## 📊 **Analytics & Tracking**

### **Google Analytics:**
```javascript
// Add to header.php
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
```

### **Facebook Pixel:**
```javascript
// Add to header.php
<script>
  !function(f,b,e,v,n,t,s)
  {if(f.fbq)return;n=f.fbq=function(){...};
</script>
```

### **Metrics to Track:**
- Conversion rate
- Average order value
- Cart abandonment rate
- Product views
- Customer lifetime value

---

## 🔒 **Security Best Practices**

### **Essential Security:**
1. **Wordfence Security** - Firewall & malware scanner
2. **iThemes Security** - Hardening & monitoring
3. **UpdraftPlus** - Automated backups
4. **SSL Certificate** - HTTPS encryption
5. **Two-Factor Authentication** - Admin login security

### **Security Checklist:**
- [ ] Change default admin username
- [ ] Use strong passwords
- [ ] Limit login attempts
- [ ] Hide WordPress version
- [ ] Disable file editing
- [ ] Regular backups
- [ ] Keep plugins updated
- [ ] Use security headers

---

## 🚀 **Deployment**

### **Production Deployment:**

```bash
# 1. Export database
wp db export database/backup.sql

# 2. Sync files to server
rsync -avz wp-content/ user@server:/var/www/html/wp-content/

# 3. Update wp-config.php
# - Database credentials
# - Site URL
# - Security keys

# 4. Set permissions
chmod 755 /var/www/html
chmod 644 wp-config.php

# 5. Test site
curl -I https://bongstore.com
```

---

## 📈 **Marketing Strategy**

### **SEO Optimization:**
- Keyword-rich product titles
- Detailed product descriptions
- Alt text for images
- Schema markup for products
- Blog content (how-tos, guides)

### **Social Media:**
- Instagram (product photos)
- Facebook (community)
- Twitter (updates)
- YouTube (product reviews)
- TikTok (viral content)

### **Paid Advertising:**
- Google Shopping ads
- Facebook/Instagram ads
- Influencer partnerships
- Affiliate program

---

## 🛠️ **Development Workflow**

### **Local Development:**
```bash
# Start development environment
docker-compose up -d

# Make changes to theme/plugins
# Test locally

# Commit changes
git add .
git commit -m "Add new feature"
git push origin main
```

### **Staging Environment:**
```bash
# Deploy to staging
./scripts/deploy.sh staging

# Test on staging
# - Functionality
# - Performance
# - Security
```

### **Production Deployment:**
```bash
# Deploy to production
./scripts/deploy.sh production

# Monitor for issues
# - Error logs
# - Performance metrics
# - User feedback
```

---

## 📚 **Documentation**

- **[Setup Guide](docs/SETUP.md)** - Complete setup instructions
- **[Product Catalog](docs/PRODUCTS.md)** - Product management guide
- **[Legal Compliance](docs/LEGAL.md)** - Legal requirements
- **[Marketing Guide](docs/MARKETING.md)** - Marketing strategies
- **[API Documentation](docs/API.md)** - WooCommerce REST API

---

## 🎯 **Roadmap**

### **Phase 1: MVP (Weeks 1-2)**
- [x] Docker setup
- [ ] WordPress installation
- [ ] WooCommerce configuration
- [ ] Basic theme setup
- [ ] Age verification
- [ ] 10 products added

### **Phase 2: Core Features (Weeks 3-4)**
- [ ] Custom theme development
- [ ] Payment gateway integration
- [ ] Shipping configuration
- [ ] Email templates
- [ ] 50+ products added

### **Phase 3: Enhancement (Weeks 5-6)**
- [ ] SEO optimization
- [ ] Analytics setup
- [ ] Email marketing
- [ ] Social media integration
- [ ] Blog content

### **Phase 4: Launch (Week 7)**
- [ ] Security audit
- [ ] Performance optimization
- [ ] Staging deployment
- [ ] Production deployment
- [ ] Marketing campaign

---

## 💰 **Revenue Projections**

### **Year 1 Goals:**
- **Month 1-3:** $5,000/month (break-even)
- **Month 4-6:** $10,000/month
- **Month 7-9:** $20,000/month
- **Month 10-12:** $30,000/month

### **Key Metrics:**
- Average Order Value: $75
- Conversion Rate: 2-3%
- Customer Acquisition Cost: $25
- Customer Lifetime Value: $300

---

## 🤝 **Contributing**

This is a private commercial project. For questions or support, contact the development team.

---

## 📝 **License**

Proprietary - All Rights Reserved

---

## 📞 **Support**

- **Email:** support@bongstore.com
- **Phone:** (555) 420-BONG
- **Hours:** Mon-Fri 9am-5pm PST

---

**Built with ❤️ and 🌿 by bgramming**

