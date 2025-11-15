# 🏠 Synology NAS Deployment Guide

Complete guide to hosting Bong Store WordPress on Synology NAS with Cloudflare security.

---

## ⚠️ **Before You Start**

### **Important Considerations:**

**Pros of Synology Hosting:**
- ✅ Full control over your data
- ✅ No monthly hosting fees
- ✅ Use existing hardware
- ✅ Learn server management

**Cons of Synology Hosting:**
- ⚠️ You're responsible for security
- ⚠️ You're responsible for uptime
- ⚠️ You're responsible for backups
- ⚠️ Your home IP is exposed (use Cloudflare!)
- ⚠️ ISP may block port 80/443
- ⚠️ Slower than dedicated hosting

**Recommendation:** 
- **Development/Testing:** ✅ Perfect for Synology
- **Production/Real Store:** ⚠️ Consider managed hosting (Cloudways, SiteGround)

---

## 🛡️ **Security Architecture**

```
Customer
    ↓
Cloudflare CDN (DDoS Protection, SSL, WAF)
    ↓
Your Domain (bongstore.com)
    ↓
Your Router (Port Forward 80, 443)
    ↓
Synology NAS (Docker + WordPress)
    ↓
Stripe/PayPal (Payment Processing - OFF your server)
```

---

## 📋 **Prerequisites**

### **Hardware Requirements:**
- **Synology Model:** DS218+, DS920+, or better
- **RAM:** 4GB minimum, 8GB+ recommended
- **Storage:** 50GB+ free space
- **CPU:** Intel processor (for Docker)

### **Network Requirements:**
- **Static IP:** From ISP (or Dynamic DNS)
- **Port Forwarding:** Access to router settings
- **Upload Speed:** 10+ Mbps recommended
- **Domain Name:** Registered domain

### **Software Requirements:**
- **DSM:** 7.0 or newer
- **Docker Package:** Installed
- **Domain Name:** Purchased and configured

---

## 🚀 **Step 1: Synology Setup**

### **1.1: Install Docker**
1. Open **Package Center**
2. Search for **"Docker"**
3. Click **Install**
4. Wait for installation

### **1.2: Enable SSH (Optional)**
1. Go to **Control Panel > Terminal & SNMP**
2. Enable **SSH service**
3. Port: **22** (or custom)
4. Click **Apply**

### **1.3: Create Shared Folder**
1. Go to **Control Panel > Shared Folder**
2. Click **Create**
3. Name: **wordpress**
4. Click **OK**

### **1.4: File Station Setup**
1. Open **File Station**
2. Navigate to **docker** folder (create if doesn't exist)
3. Create folder: **bong-store**
4. Upload your project files here

---

## 🔐 **Step 2: Cloudflare Setup**

### **2.1: Register Domain**
1. Buy domain from Namecheap, GoDaddy, etc.
2. Example: **bongstore.com**

### **2.2: Add Site to Cloudflare**
1. Go to https://dash.cloudflare.com
2. Click **Add a Site**
3. Enter your domain: **bongstore.com**
4. Select **Free Plan**
5. Click **Add Site**

### **2.3: Update Nameservers**
1. Cloudflare will show you nameservers:
   - `ns1.cloudflare.com`
   - `ns2.cloudflare.com`
2. Go to your domain registrar
3. Update nameservers to Cloudflare's
4. Wait 24 hours for propagation

### **2.4: Configure DNS**
1. In Cloudflare, go to **DNS**
2. Add **A Record:**
   - Type: **A**
   - Name: **@** (root domain)
   - IPv4: **Your home IP** (get from whatismyip.com)
   - Proxy: **Enabled** (orange cloud)
3. Add **CNAME Record:**
   - Type: **CNAME**
   - Name: **www**
   - Target: **bongstore.com**
   - Proxy: **Enabled**

### **2.5: SSL/TLS Settings**
1. Go to **SSL/TLS**
2. Set mode to: **Full (Strict)**
3. Enable **Always Use HTTPS**
4. Enable **Automatic HTTPS Rewrites**
5. Minimum TLS Version: **TLS 1.2**

### **2.6: Security Settings**
1. Go to **Security > WAF**
2. Set Security Level: **Medium** or **High**
3. Enable **Bot Fight Mode**
4. Go to **Security > Bots**
5. Enable **Super Bot Fight Mode** (if available)

### **2.7: Firewall Rules**
1. Go to **Security > WAF > Firewall Rules**
2. Create rule to block bad bots:
```
(cf.client.bot) or (cf.threat_score gt 10)
Action: Challenge
```

### **2.8: Rate Limiting**
1. Go to **Security > WAF > Rate Limiting Rules**
2. Create rule:
   - If: **All incoming requests**
   - Requests: **100 per minute**
   - Action: **Block**
   - Duration: **10 minutes**

---

## 🌐 **Step 3: Router Configuration**

### **3.1: Find Synology IP**
1. On Synology, go to **Control Panel > Network**
2. Note your **LAN IP** (e.g., 192.168.1.100)

### **3.2: Port Forwarding**
1. Log into your router (usually 192.168.1.1)
2. Find **Port Forwarding** section
3. Add rules:

**HTTP:**
- External Port: **80**
- Internal IP: **192.168.1.100** (your Synology)
- Internal Port: **80**
- Protocol: **TCP**

**HTTPS:**
- External Port: **443**
- Internal IP: **192.168.1.100**
- Internal Port: **443**
- Protocol: **TCP**

### **3.3: Test Port Forwarding**
1. Go to https://www.yougetsignal.com/tools/open-ports/
2. Enter your public IP
3. Test port **80** and **443**
4. Should show **Open**

---

## 🐳 **Step 4: Docker Deployment**

### **4.1: Upload Project Files**
1. Open **File Station**
2. Navigate to **docker/bong-store**
3. Upload:
   - `docker-compose.yml`
   - `uploads.ini`
   - `wp-content/` folder

### **4.2: Modify docker-compose.yml**
Update ports to avoid conflicts:
```yaml
services:
  wordpress:
    ports:
      - "80:80"  # Changed from 8080
      - "443:443"  # Add HTTPS
```

### **4.3: SSH into Synology**
```bash
ssh admin@192.168.1.100
```

### **4.4: Navigate to Project**
```bash
cd /volume1/docker/bong-store
```

### **4.5: Start Containers**
```bash
sudo docker-compose up -d
```

### **4.6: Check Status**
```bash
sudo docker-compose ps
```

---

## 🔒 **Step 5: SSL Certificate**

### **Option A: Cloudflare Origin Certificate (Recommended)**

1. In Cloudflare, go to **SSL/TLS > Origin Server**
2. Click **Create Certificate**
3. Select:
   - Key Type: **RSA (2048)**
   - Hostnames: **bongstore.com, *.bongstore.com**
   - Validity: **15 years**
4. Click **Create**
5. Copy **Origin Certificate** and **Private Key**

6. On Synology:
   - Go to **Control Panel > Security > Certificate**
   - Click **Add**
   - Select **Add a new certificate**
   - Paste certificate and key
   - Click **OK**

### **Option B: Let's Encrypt (Free)**

1. On Synology:
   - Go to **Control Panel > Security > Certificate**
   - Click **Add**
   - Select **Add a new certificate**
   - Choose **Get a certificate from Let's Encrypt**
   - Enter domain: **bongstore.com**
   - Enter email
   - Click **OK**

---

## 🛡️ **Step 6: Synology Security Hardening**

### **6.1: Firewall**
1. Go to **Control Panel > Security > Firewall**
2. Enable firewall
3. Create rules:
   - **Allow:** Port 80 (HTTP)
   - **Allow:** Port 443 (HTTPS)
   - **Allow:** Port 22 (SSH) - from specific IPs only
   - **Deny:** All other ports

### **6.2: Auto Block**
1. Go to **Control Panel > Security > Account**
2. Enable **Auto block**
3. Settings:
   - Login attempts: **5**
   - Within: **5 minutes**
   - Block for: **30 minutes**

### **6.3: Two-Factor Authentication**
1. Go to **Control Panel > Security > Account**
2. Enable **2-step verification**
3. Set up with Google Authenticator

### **6.4: Security Advisor**
1. Go to **Control Panel > Security Advisor**
2. Click **Scan**
3. Fix all **High** and **Medium** issues

### **6.5: Disable Default Admin**
1. Create new admin user
2. Disable **admin** account
3. Use new account only

---

## 💾 **Step 7: Backup Strategy**

### **7.1: Synology Hyper Backup**
1. Install **Hyper Backup** from Package Center
2. Create backup task:
   - Source: **docker/bong-store**
   - Destination: **External USB drive** or **Cloud**
   - Schedule: **Daily at 2 AM**
   - Retention: **30 versions**

### **7.2: WordPress Backup**
Use **UpdraftPlus** plugin:
1. Install UpdraftPlus
2. Configure:
   - Files: **Weekly**
   - Database: **Daily**
   - Remote: **Dropbox/Google Drive**
   - Retention: **30 backups**

### **7.3: Database Backup**
```bash
# Manual backup script
docker exec bong-store-db mysqldump -u wordpress -p bong_store > backup.sql
```

---

## 📊 **Step 8: Monitoring**

### **8.1: Synology Resource Monitor**
1. Open **Resource Monitor**
2. Monitor:
   - CPU usage
   - RAM usage
   - Network traffic
   - Disk usage

### **8.2: Cloudflare Analytics**
1. Go to Cloudflare dashboard
2. Check **Analytics** tab
3. Monitor:
   - Traffic
   - Threats blocked
   - Bandwidth saved

### **8.3: WordPress Monitoring**
Install **Wordfence**:
1. Real-time traffic monitoring
2. Failed login attempts
3. Malware scans
4. Email alerts

---

## ⚡ **Step 9: Performance Optimization**

### **9.1: Cloudflare Caching**
1. Go to **Caching**
2. Set **Caching Level:** Standard
3. Set **Browser Cache TTL:** 4 hours
4. Enable **Always Online**

### **9.2: WordPress Caching**
Install **W3 Total Cache**:
- Page caching
- Object caching
- Browser caching
- Minification

### **9.3: Image Optimization**
Install **Smush**:
- Auto-compress uploads
- Lazy loading
- WebP conversion

---

## 🧪 **Step 10: Testing**

### **10.1: Security Test**
1. **SSL Test:** https://www.ssllabs.com/ssltest/
   - Should get **A** rating
2. **Security Headers:** https://securityheaders.com
   - Should get **A** or **B** rating
3. **Malware Scan:** Run Wordfence scan

### **10.2: Performance Test**
1. **Speed Test:** https://gtmetrix.com
   - Should load in < 3 seconds
2. **Mobile Test:** https://search.google.com/test/mobile-friendly
   - Should be mobile-friendly

### **10.3: Functionality Test**
- [ ] Homepage loads
- [ ] Products display
- [ ] Add to cart works
- [ ] Checkout works
- [ ] Payment processes (test mode)
- [ ] Emails send
- [ ] Age verification works

---

## ⚠️ **Important Security Notes**

### **Payment Processing:**
**NEVER store payment data on your Synology!**

Use **Stripe** or **PayPal** with:
- **Stripe Elements** - Payment form hosted by Stripe
- **PayPal Standard** - Redirect to PayPal

This keeps all payment data OFF your server.

### **PCI Compliance:**
If you use Stripe/PayPal properly, you're **SAQ A** compliant (easiest level).

### **Legal Requirements:**
- **Privacy Policy** - Required
- **Terms of Service** - Required
- **Cookie Consent** - Required (GDPR)
- **Age Verification** - Required (18+)
- **Shipping Policy** - Required

---

## 🆘 **Troubleshooting**

### **Can't Access Site:**
1. Check Cloudflare DNS is proxied (orange cloud)
2. Check port forwarding is correct
3. Check Synology firewall allows ports 80, 443
4. Check Docker containers are running

### **SSL Errors:**
1. Verify Cloudflare SSL mode is **Full (Strict)**
2. Check certificate is installed on Synology
3. Clear browser cache

### **Slow Performance:**
1. Enable Cloudflare caching
2. Install WordPress caching plugin
3. Optimize images
4. Check Synology CPU/RAM usage

---

## 💰 **Cost Breakdown**

### **One-Time Costs:**
- Domain Name: **$10-15/year**
- Synology NAS: **Already owned**

### **Monthly Costs:**
- Cloudflare: **$0** (Free plan)
- Electricity: **~$5-10/month**
- ISP: **Existing internet**

**Total:** ~$10-15/year + electricity

### **Compare to Managed Hosting:**
- Bluehost: **$30/month** = $360/year
- SiteGround: **$40/month** = $480/year
- Cloudways: **$25/month** = $300/year

**Savings:** $300-480/year by self-hosting!

---

## 🎯 **Final Recommendation**

### **For Development/Testing:**
✅ **Synology is PERFECT**
- Learn WordPress
- Test features
- No hosting costs

### **For Production Store:**
⚠️ **Consider Both Options:**

**Synology Pros:**
- Full control
- No monthly fees
- Learn server management

**Synology Cons:**
- You're responsible for everything
- Downtime = lost sales
- Security is on you

**Managed Hosting Pros:**
- 99.9% uptime guarantee
- Professional support
- Automatic backups
- Better performance

**My Advice:**
1. **Start on Synology** - Build and test
2. **Use Cloudflare** - Essential security
3. **Monitor closely** - First 3 months
4. **If successful** - Consider migrating to managed hosting

---

## 📞 **Support Resources**

- **Synology Community:** https://community.synology.com
- **Cloudflare Docs:** https://developers.cloudflare.com
- **WordPress Support:** https://wordpress.org/support
- **WooCommerce Docs:** https://woocommerce.com/documentation

---

**You CAN host on Synology safely with proper security!** 🛡️

**But always have a backup plan for production stores.** 💼

