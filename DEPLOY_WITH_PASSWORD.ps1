# HostGator Deployment Script (Password Authentication)
# Deploys Bong Store WordPress to HostGator using password instead of SSH key

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  BONG STORE - HOSTGATOR DEPLOYMENT" -ForegroundColor Cyan
Write-Host "  (Password Authentication)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Configuration
$SSH_USER = "burning5"
Write-Host "Enter your HostGator domain (e.g., yourdomain.com):" -ForegroundColor Yellow
$SSH_HOST = Read-Host "Domain"

if ([string]::IsNullOrWhiteSpace($SSH_HOST)) {
    Write-Host ""
    Write-Host "ERROR: Domain cannot be empty!" -ForegroundColor Red
    Write-Host ""
    Write-Host "You can find your domain in:" -ForegroundColor Yellow
    Write-Host "  - HostGator Portal -> Domains" -ForegroundColor Gray
    Write-Host "  - cPanel (top right corner)" -ForegroundColor Gray
    Write-Host ""
    pause
    exit 1
}

$REMOTE_PATH = "/home4/burning5/public_html"
$LOCAL_PATH = $PSScriptRoot

Write-Host ""
Write-Host "Configuration:" -ForegroundColor Yellow
Write-Host "  SSH User: $SSH_USER" -ForegroundColor Gray
Write-Host "  SSH Host: $SSH_HOST" -ForegroundColor Gray
Write-Host "  Remote Path: $REMOTE_PATH" -ForegroundColor Gray
Write-Host ""
Write-Host "You will be prompted for your cPanel password multiple times." -ForegroundColor Yellow
Write-Host "This is normal - SSH doesn't cache passwords." -ForegroundColor Gray
Write-Host ""

Write-Host "Press Enter to continue..." -ForegroundColor Cyan
Read-Host

Write-Host ""
Write-Host "Step 1: Testing SSH connection..." -ForegroundColor Cyan
Write-Host "(Enter your cPanel password when prompted)" -ForegroundColor Yellow
Write-Host ""

$TEST_CMD = "echo 'SSH connection successful!'"
ssh -o StrictHostKeyChecking=no ${SSH_USER}@${SSH_HOST} $TEST_CMD

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Could not connect to HostGator via SSH" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please verify:" -ForegroundColor Yellow
    Write-Host "  1. Domain name is correct: $SSH_HOST" -ForegroundColor Gray
    Write-Host "  2. SSH access is enabled in cPanel" -ForegroundColor Gray
    Write-Host "  3. Password is correct (same as cPanel password)" -ForegroundColor Gray
    Write-Host ""
    Write-Host "To enable SSH:" -ForegroundColor Yellow
    Write-Host "  - Contact HostGator support: 1-866-96-GATOR" -ForegroundColor Gray
    Write-Host "  - Or use cPanel method (see HOSTGATOR_DEPLOYMENT.md)" -ForegroundColor Gray
    Write-Host ""
    pause
    exit 1
}

Write-Host ""
Write-Host "✅ Connection successful!" -ForegroundColor Green
Write-Host ""

# Get WordPress details
Write-Host "WordPress Configuration:" -ForegroundColor Cyan
Write-Host ""

$WP_TITLE = Read-Host "Enter site title (default: Bong Store)"
if ([string]::IsNullOrWhiteSpace($WP_TITLE)) { $WP_TITLE = "Bong Store" }

$WP_ADMIN_USER = Read-Host "Enter admin username (default: admin)"
if ([string]::IsNullOrWhiteSpace($WP_ADMIN_USER)) { $WP_ADMIN_USER = "admin" }

Write-Host ""
Write-Host "IMPORTANT: Save this password somewhere safe!" -ForegroundColor Yellow
$WP_ADMIN_PASSWORD = Read-Host "Enter admin password"
if ([string]::IsNullOrWhiteSpace($WP_ADMIN_PASSWORD)) {
    Write-Host "Password cannot be empty!" -ForegroundColor Red
    pause
    exit 1
}

$WP_ADMIN_EMAIL = Read-Host "Enter admin email"
if ([string]::IsNullOrWhiteSpace($WP_ADMIN_EMAIL)) {
    Write-Host "Email cannot be empty!" -ForegroundColor Red
    pause
    exit 1
}

# Determine URL
$WP_URL = "https://$SSH_HOST"
Write-Host ""
Write-Host "Your site URL will be: $WP_URL" -ForegroundColor Cyan
$CONFIRM_URL = Read-Host "Is this correct? (yes/no)"

if ($CONFIRM_URL -ne "yes") {
    $WP_URL = Read-Host "Enter the correct URL (e.g., https://yourdomain.com)"
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "  DEPLOYMENT SUMMARY" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "Site Title: $WP_TITLE" -ForegroundColor Gray
Write-Host "Site URL: $WP_URL" -ForegroundColor Gray
Write-Host "Admin User: $WP_ADMIN_USER" -ForegroundColor Gray
Write-Host "Admin Email: $WP_ADMIN_EMAIL" -ForegroundColor Gray
Write-Host ""
Write-Host "Ready to deploy?" -ForegroundColor Cyan
$CONFIRM = Read-Host "Type 'yes' to continue"

if ($CONFIRM -ne "yes") {
    Write-Host "Deployment cancelled." -ForegroundColor Yellow
    pause
    exit 0
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  STARTING DEPLOYMENT" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Note: You'll be prompted for your password several times." -ForegroundColor Yellow
Write-Host "This is normal for SSH without key authentication." -ForegroundColor Gray
Write-Host ""

# Create deployment script on server
Write-Host "Step 2: Creating deployment script on server..." -ForegroundColor Cyan

$DEPLOY_SCRIPT = @"
#!/bin/bash
set -e

echo ""
echo "=========================================="
echo "  WORDPRESS INSTALLATION"
echo "=========================================="
echo ""

# Check if WP-CLI exists
if ! command -v /home4/burning5/bin/wp &> /dev/null; then
    echo "Installing WP-CLI..."
    cd /home4/burning5
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mkdir -p bin
    mv wp-cli.phar bin/wp
    echo "WP-CLI installed!"
fi

# Set alias for convenience
WP="/home4/burning5/bin/wp"

# Check if WordPress already exists
if [ -f "$REMOTE_PATH/wp-config.php" ]; then
    echo ""
    echo "⚠️  WordPress is already installed!"
    echo "Creating backup..."
    cd /home4/burning5
    tar -czf wordpress_backup_\$(date +%Y%m%d_%H%M%S).tar.gz public_html/
    echo "✅ Backup created!"
fi

# Download WordPress
echo ""
echo "Downloading WordPress..."
cd $REMOTE_PATH
\$WP core download --force

# Create wp-config.php
echo "Creating configuration..."
\$WP config create --dbname=burning5_wpdb --dbuser=burning5_wpuser --dbpass=SecureWP2024! --dbhost=localhost --force

# Install WordPress
echo "Installing WordPress..."
\$WP core install --url='$WP_URL' --title='$WP_TITLE' --admin_user='$WP_ADMIN_USER' --admin_password='$WP_ADMIN_PASSWORD' --admin_email='$WP_ADMIN_EMAIL'

# Install WooCommerce
echo ""
echo "Installing WooCommerce..."
\$WP plugin install woocommerce --activate

# Configure WooCommerce
echo "Configuring WooCommerce..."
\$WP option update woocommerce_currency USD
\$WP option update woocommerce_currency_pos left
\$WP option update woocommerce_price_decimal_sep '.'
\$WP option update woocommerce_price_thousand_sep ','

# Create product categories
echo "Creating product categories..."
\$WP wc product_cat create --name='Glass Bongs' --description='High-quality glass bongs and water pipes' --user=$WP_ADMIN_USER
\$WP wc product_cat create --name='Accessories' --description='Smoking accessories and supplies' --user=$WP_ADMIN_USER
\$WP wc product_cat create --name='Vaporizers' --description='Electronic vaporizers and vape pens' --user=$WP_ADMIN_USER
\$WP wc product_cat create --name='Apparel' --description='T-shirts, hoodies, and merchandise' --user=$WP_ADMIN_USER

echo ""
echo "✅ WordPress and WooCommerce installed successfully!"
echo ""
"@

# Write script to temp file
$TEMP_SCRIPT = Join-Path $env:TEMP "deploy_wp.sh"
$DEPLOY_SCRIPT | Out-File -FilePath $TEMP_SCRIPT -Encoding ASCII -NoNewline

# Upload script to server
Write-Host "Uploading deployment script..." -ForegroundColor Yellow
Write-Host "(Enter password)" -ForegroundColor Gray
scp $TEMP_SCRIPT ${SSH_USER}@${SSH_HOST}:/home4/burning5/deploy_wp.sh

# Make script executable and run it
Write-Host ""
Write-Host "Step 3: Running deployment on server..." -ForegroundColor Cyan
Write-Host "(This may take 5-10 minutes)" -ForegroundColor Yellow
Write-Host "(Enter password)" -ForegroundColor Gray
Write-Host ""

ssh ${SSH_USER}@${SSH_HOST} "chmod +x /home4/burning5/deploy_wp.sh && /home4/burning5/deploy_wp.sh"

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "⚠️  Deployment encountered an issue." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "This might be because:" -ForegroundColor Yellow
    Write-Host "  1. Database doesn't exist yet" -ForegroundColor Gray
    Write-Host "  2. WP-CLI needs manual installation" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Please create the database manually:" -ForegroundColor Cyan
    Write-Host "  1. Go to cPanel -> MySQL Databases" -ForegroundColor Gray
    Write-Host "  2. Create database: burning5_wpdb" -ForegroundColor Gray
    Write-Host "  3. Create user: burning5_wpuser" -ForegroundColor Gray
    Write-Host "  4. Password: SecureWP2024!" -ForegroundColor Gray
    Write-Host "  5. Grant ALL PRIVILEGES" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Then run this script again." -ForegroundColor Cyan
    Write-Host ""
    pause
    exit 1
}

Write-Host ""
Write-Host "Step 4: Uploading Age Verification Plugin..." -ForegroundColor Cyan

# Create plugin zip
$PLUGIN_PATH = Join-Path $LOCAL_PATH "wp-content\plugins\age-verification"
$ZIP_PATH = Join-Path $env:TEMP "age-verification.zip"

if (Test-Path $ZIP_PATH) {
    Remove-Item $ZIP_PATH -Force
}

Write-Host "Creating plugin archive..." -ForegroundColor Yellow
Compress-Archive -Path $PLUGIN_PATH -DestinationPath $ZIP_PATH -Force

# Upload plugin
Write-Host "Uploading plugin..." -ForegroundColor Yellow
Write-Host "(Enter password)" -ForegroundColor Gray
scp $ZIP_PATH ${SSH_USER}@${SSH_HOST}:/home4/burning5/age-verification.zip

# Install plugin
Write-Host "Installing plugin..." -ForegroundColor Yellow
Write-Host "(Enter password)" -ForegroundColor Gray
ssh ${SSH_USER}@${SSH_HOST} @"
cd $REMOTE_PATH/wp-content/plugins
unzip -o /home4/burning5/age-verification.zip
rm /home4/burning5/age-verification.zip
cd $REMOTE_PATH
/home4/burning5/bin/wp plugin activate age-verification
"@

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  🎉 DEPLOYMENT COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Your Bong Store is now LIVE! 🌿" -ForegroundColor Cyan
Write-Host ""
Write-Host "Site URL:" -ForegroundColor Cyan
Write-Host "  $WP_URL" -ForegroundColor White
Write-Host ""
Write-Host "WordPress Admin:" -ForegroundColor Cyan
Write-Host "  URL: $WP_URL/wp-admin" -ForegroundColor White
Write-Host "  Username: $WP_ADMIN_USER" -ForegroundColor White
Write-Host "  Password: $WP_ADMIN_PASSWORD" -ForegroundColor White
Write-Host "  Email: $WP_ADMIN_EMAIL" -ForegroundColor White
Write-Host ""
Write-Host "Database Info:" -ForegroundColor Cyan
Write-Host "  Name: burning5_wpdb" -ForegroundColor White
Write-Host "  User: burning5_wpuser" -ForegroundColor White
Write-Host "  Password: SecureWP2024!" -ForegroundColor White
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "  1. ✅ Log into WordPress admin" -ForegroundColor Gray
Write-Host "  2. ✅ Configure Age Verification (Settings -> Age Verification)" -ForegroundColor Gray
Write-Host "  3. ✅ Add products (Products -> Add New)" -ForegroundColor Gray
Write-Host "  4. ✅ Set up payments (WooCommerce -> Settings -> Payments)" -ForegroundColor Gray
Write-Host "  5. ✅ Enable SSL in cPanel (SSL/TLS Status -> Run AutoSSL)" -ForegroundColor Gray
Write-Host ""
Write-Host "Opening your site..." -ForegroundColor Cyan
Start-Sleep -Seconds 2
start $WP_URL

Write-Host ""
Write-Host "🎉 Congratulations! Your store is live!" -ForegroundColor Green
Write-Host ""
pause

