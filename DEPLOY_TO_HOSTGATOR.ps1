# HostGator Deployment Script
# Deploys Bong Store WordPress to HostGator via SSH

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  BONG STORE - HOSTGATOR DEPLOYMENT" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Configuration
$SSH_USER = "burning5"
$SSH_HOST = Read-Host "Enter your HostGator domain or IP (e.g., yourdomain.com or server IP)"
$SSH_KEY = "$env:USERPROFILE\.ssh\hostgator_key"
$REMOTE_PATH = "/home4/burning5/public_html"
$LOCAL_PATH = $PSScriptRoot

Write-Host ""
Write-Host "Configuration:" -ForegroundColor Yellow
Write-Host "  SSH User: $SSH_USER" -ForegroundColor Gray
Write-Host "  SSH Host: $SSH_HOST" -ForegroundColor Gray
Write-Host "  Remote Path: $REMOTE_PATH" -ForegroundColor Gray
Write-Host "  Local Path: $LOCAL_PATH" -ForegroundColor Gray
Write-Host ""

# Check if SSH key exists
if (-not (Test-Path $SSH_KEY)) {
    Write-Host "SSH key not found at: $SSH_KEY" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please copy your SSH private key to:" -ForegroundColor Yellow
    Write-Host "  $SSH_KEY" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "The private key is located on the server at:" -ForegroundColor Yellow
    Write-Host "  /home4/burning5/.ssh/cursor_ai" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "You can download it using:" -ForegroundColor Yellow
    Write-Host "  scp burning5@$SSH_HOST:/home4/burning5/.ssh/cursor_ai $SSH_KEY" -ForegroundColor Cyan
    Write-Host ""
    pause
    exit 1
}

Write-Host "Step 1: Testing SSH connection..." -ForegroundColor Cyan
ssh -i $SSH_KEY -o StrictHostKeyChecking=no ${SSH_USER}@${SSH_HOST} "echo 'SSH connection successful!'"

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Could not connect to HostGator via SSH" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please verify:" -ForegroundColor Yellow
    Write-Host "  1. SSH key is correct" -ForegroundColor Gray
    Write-Host "  2. SSH access is enabled in cPanel" -ForegroundColor Gray
    Write-Host "  3. Your IP is whitelisted (if required)" -ForegroundColor Gray
    Write-Host ""
    pause
    exit 1
}

Write-Host ""
Write-Host "Step 2: Checking if WordPress is already installed..." -ForegroundColor Cyan
$WP_EXISTS = ssh -i $SSH_KEY ${SSH_USER}@${SSH_HOST} "test -f $REMOTE_PATH/wp-config.php && echo 'yes' || echo 'no'"

if ($WP_EXISTS -eq "yes") {
    Write-Host ""
    Write-Host "WordPress is already installed!" -ForegroundColor Green
    Write-Host ""
    $OVERWRITE = Read-Host "Do you want to overwrite the existing installation? (yes/no)"
    
    if ($OVERWRITE -ne "yes") {
        Write-Host ""
        Write-Host "Deployment cancelled." -ForegroundColor Yellow
        Write-Host ""
        pause
        exit 0
    }
    
    Write-Host ""
    Write-Host "Creating backup of existing installation..." -ForegroundColor Yellow
    ssh -i $SSH_KEY ${SSH_USER}@${SSH_HOST} "cd /home4/burning5 && tar -czf wordpress_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss').tar.gz public_html/"
    Write-Host "Backup created!" -ForegroundColor Green
}

Write-Host ""
Write-Host "Step 3: Installing WordPress via WP-CLI..." -ForegroundColor Cyan

# Check if WP-CLI is installed
$WP_CLI_EXISTS = ssh -i $SSH_KEY ${SSH_USER}@${SSH_HOST} "command -v wp &> /dev/null && echo 'yes' || echo 'no'"

if ($WP_CLI_EXISTS -eq "no") {
    Write-Host "Installing WP-CLI..." -ForegroundColor Yellow
    ssh -i $SSH_KEY ${SSH_USER}@${SSH_HOST} @"
cd /home4/burning5
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mkdir -p bin
mv wp-cli.phar bin/wp
echo 'export PATH=\$PATH:/home4/burning5/bin' >> ~/.bashrc
"@
    Write-Host "WP-CLI installed!" -ForegroundColor Green
}

Write-Host ""
$WP_TITLE = Read-Host "Enter site title (default: Bong Store)"
if ([string]::IsNullOrWhiteSpace($WP_TITLE)) { $WP_TITLE = "Bong Store" }

$WP_ADMIN_USER = Read-Host "Enter admin username (default: admin)"
if ([string]::IsNullOrWhiteSpace($WP_ADMIN_USER)) { $WP_ADMIN_USER = "admin" }

$WP_ADMIN_PASSWORD = Read-Host "Enter admin password (SAVE THIS!)"
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

$WP_URL = Read-Host "Enter site URL (e.g., https://yourdomain.com)"
if ([string]::IsNullOrWhiteSpace($WP_URL)) {
    Write-Host "URL cannot be empty!" -ForegroundColor Red
    pause
    exit 1
}

Write-Host ""
Write-Host "Downloading and installing WordPress..." -ForegroundColor Cyan

ssh -i $SSH_KEY ${SSH_USER}@${SSH_HOST} @"
cd $REMOTE_PATH
/home4/burning5/bin/wp core download --force
/home4/burning5/bin/wp config create --dbname=burning5_wpdb --dbuser=burning5_wpuser --dbpass=SecurePassword123! --dbhost=localhost --force
/home4/burning5/bin/wp core install --url='$WP_URL' --title='$WP_TITLE' --admin_user='$WP_ADMIN_USER' --admin_password='$WP_ADMIN_PASSWORD' --admin_email='$WP_ADMIN_EMAIL'
"@

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: WordPress installation failed" -ForegroundColor Red
    Write-Host ""
    Write-Host "You may need to create the database manually in cPanel:" -ForegroundColor Yellow
    Write-Host "  1. Go to cPanel -> MySQL Databases" -ForegroundColor Gray
    Write-Host "  2. Create database: burning5_wpdb" -ForegroundColor Gray
    Write-Host "  3. Create user: burning5_wpuser" -ForegroundColor Gray
    Write-Host "  4. Grant all privileges" -ForegroundColor Gray
    Write-Host ""
    pause
    exit 1
}

Write-Host ""
Write-Host "Step 4: Installing WooCommerce..." -ForegroundColor Cyan
ssh -i $SSH_KEY ${SSH_USER}@${SSH_HOST} @"
cd $REMOTE_PATH
/home4/burning5/bin/wp plugin install woocommerce --activate
"@

Write-Host ""
Write-Host "Step 5: Uploading Age Verification Plugin..." -ForegroundColor Cyan

# Create zip of age verification plugin
Write-Host "Creating plugin zip..." -ForegroundColor Yellow
$PLUGIN_PATH = Join-Path $LOCAL_PATH "wp-content\plugins\age-verification"
$ZIP_PATH = Join-Path $LOCAL_PATH "age-verification.zip"

if (Test-Path $ZIP_PATH) {
    Remove-Item $ZIP_PATH -Force
}

Compress-Archive -Path $PLUGIN_PATH -DestinationPath $ZIP_PATH

# Upload plugin via SCP
Write-Host "Uploading plugin..." -ForegroundColor Yellow
scp -i $SSH_KEY $ZIP_PATH ${SSH_USER}@${SSH_HOST}:/home4/burning5/age-verification.zip

# Extract and activate plugin
ssh -i $SSH_KEY ${SSH_USER}@${SSH_HOST} @"
cd $REMOTE_PATH/wp-content/plugins
unzip -o /home4/burning5/age-verification.zip
rm /home4/burning5/age-verification.zip
cd $REMOTE_PATH
/home4/burning5/bin/wp plugin activate age-verification
"@

Write-Host ""
Write-Host "Step 6: Configuring WooCommerce..." -ForegroundColor Cyan
ssh -i $SSH_KEY ${SSH_USER}@${SSH_HOST} @"
cd $REMOTE_PATH
/home4/burning5/bin/wp option update woocommerce_currency USD
/home4/burning5/bin/wp option update woocommerce_currency_pos left
/home4/burning5/bin/wp option update woocommerce_price_decimal_sep '.'
/home4/burning5/bin/wp option update woocommerce_price_thousand_sep ','
"@

Write-Host ""
Write-Host "Step 7: Creating product categories..." -ForegroundColor Cyan
ssh -i $SSH_KEY ${SSH_USER}@${SSH_HOST} @"
cd $REMOTE_PATH
/home4/burning5/bin/wp wc product_cat create --name='Glass Bongs' --description='High-quality glass bongs and water pipes' --user=$WP_ADMIN_USER
/home4/burning5/bin/wp wc product_cat create --name='Accessories' --description='Smoking accessories and supplies' --user=$WP_ADMIN_USER
/home4/burning5/bin/wp wc product_cat create --name='Vaporizers' --description='Electronic vaporizers and vape pens' --user=$WP_ADMIN_USER
/home4/burning5/bin/wp wc product_cat create --name='Apparel' --description='T-shirts, hoodies, and merchandise' --user=$WP_ADMIN_USER
"@

Write-Host ""
Write-Host "Step 8: Setting up SSL (if available)..." -ForegroundColor Cyan
Write-Host "Note: You may need to enable SSL in cPanel -> SSL/TLS Status" -ForegroundColor Yellow

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  DEPLOYMENT COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Your Bong Store is now live at:" -ForegroundColor Cyan
Write-Host "  $WP_URL" -ForegroundColor White
Write-Host ""
Write-Host "Admin Login:" -ForegroundColor Cyan
Write-Host "  URL: $WP_URL/wp-admin" -ForegroundColor White
Write-Host "  Username: $WP_ADMIN_USER" -ForegroundColor White
Write-Host "  Password: $WP_ADMIN_PASSWORD" -ForegroundColor White
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Log into WordPress admin" -ForegroundColor Gray
Write-Host "  2. Go to Settings -> Age Verification" -ForegroundColor Gray
Write-Host "  3. Configure age gate settings" -ForegroundColor Gray
Write-Host "  4. Add products (Products -> Add New)" -ForegroundColor Gray
Write-Host "  5. Set up payment gateway (WooCommerce -> Settings -> Payments)" -ForegroundColor Gray
Write-Host "  6. Enable SSL in cPanel (SSL/TLS Status)" -ForegroundColor Gray
Write-Host ""
Write-Host "Opening your site..." -ForegroundColor Cyan
Start-Sleep -Seconds 2
start $WP_URL

Write-Host ""
pause

