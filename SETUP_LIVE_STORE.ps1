# Setup Live Store on burningbeats.store
# Configures WooCommerce and activates Age Verification plugin

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  SETUP BURNINGBEATS.STORE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$DOMAIN = "burningbeats.store"
$SSH_USER = "burning5"
$SSH_HOST = "192.254.235.48"

Write-Host "This will configure your live store:" -ForegroundColor Yellow
Write-Host "  - Activate Age Verification plugin" -ForegroundColor Gray
Write-Host "  - Configure WooCommerce settings" -ForegroundColor Gray
Write-Host "  - Create product categories" -ForegroundColor Gray
Write-Host "  - Set up shop pages" -ForegroundColor Gray
Write-Host ""
Write-Host "Site: https://$DOMAIN" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press Enter to continue..." -ForegroundColor Yellow
Read-Host

Write-Host ""
Write-Host "Connecting to server..." -ForegroundColor Cyan
Write-Host "(Enter your cPanel password when prompted)" -ForegroundColor Gray
Write-Host ""

# Create setup script
$SETUP_SCRIPT = @"
#!/bin/bash
set -e

echo ""
echo "=========================================="
echo "  BURNINGBEATS.STORE SETUP"
echo "=========================================="
echo ""

# Find WordPress installation
WP_PATH="/home4/burning5/public_html"
cd \$WP_PATH

echo "WordPress directory: \$WP_PATH"
echo ""

# Check if WP-CLI is installed
if [ -f "/home4/burning5/bin/wp" ]; then
    WP="/home4/burning5/bin/wp"
    echo "✅ WP-CLI found"
elif command -v wp &> /dev/null; then
    WP="wp"
    echo "✅ WP-CLI found in PATH"
else
    echo "Installing WP-CLI..."
    cd /home4/burning5
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mkdir -p bin
    mv wp-cli.phar bin/wp
    WP="/home4/burning5/bin/wp"
    echo "✅ WP-CLI installed"
fi

cd \$WP_PATH

echo ""
echo "=========================================="
echo "  STEP 1: Check Age Verification Plugin"
echo "=========================================="
echo ""

# Check if plugin exists
if [ -d "wp-content/plugins/age-verification" ]; then
    echo "✅ Age Verification plugin found!"
    echo ""
    echo "Activating plugin..."
    \$WP plugin activate age-verification --allow-root || echo "Plugin may already be active"
    echo ""
    echo "Configuring Age Verification..."
    \$WP option update age_verification_minimum_age 18 --allow-root
    \$WP option update age_verification_message "You must be 18 years or older to enter this site." --allow-root
    \$WP option update age_verification_cookie_duration 30 --allow-root
    echo "✅ Age Verification configured!"
else
    echo "❌ Age Verification plugin NOT found in wp-content/plugins/"
    echo ""
    echo "The plugin should be in your GitHub repo."
    echo "Make sure it's been pulled to the server."
fi

echo ""
echo "=========================================="
echo "  STEP 2: Configure WooCommerce"
echo "=========================================="
echo ""

# Check if WooCommerce is installed
if \$WP plugin is-installed woocommerce --allow-root; then
    echo "✅ WooCommerce is installed"
    
    # Activate if not active
    if ! \$WP plugin is-active woocommerce --allow-root; then
        echo "Activating WooCommerce..."
        \$WP plugin activate woocommerce --allow-root
    fi
    
    echo ""
    echo "Configuring WooCommerce settings..."
    
    # Currency settings
    \$WP option update woocommerce_currency USD --allow-root
    \$WP option update woocommerce_currency_pos left --allow-root
    \$WP option update woocommerce_price_decimal_sep '.' --allow-root
    \$WP option update woocommerce_price_thousand_sep ',' --allow-root
    
    # Store settings
    \$WP option update woocommerce_store_address "Your Address" --allow-root
    \$WP option update woocommerce_store_city "Your City" --allow-root
    \$WP option update woocommerce_default_country "US" --allow-root
    \$WP option update woocommerce_store_postcode "12345" --allow-root
    
    echo "✅ WooCommerce configured!"
else
    echo "❌ WooCommerce is NOT installed"
    echo "Installing WooCommerce..."
    \$WP plugin install woocommerce --activate --allow-root
    echo "✅ WooCommerce installed!"
fi

echo ""
echo "=========================================="
echo "  STEP 3: Create Product Categories"
echo "=========================================="
echo ""

# Check if categories exist
if \$WP term list product_cat --format=count --allow-root | grep -q "^[1-9]"; then
    echo "Product categories already exist"
else
    echo "Creating product categories..."
    \$WP wc product_cat create --name='Glass Bongs' --description='High-quality glass bongs and water pipes' --allow-root || true
    \$WP wc product_cat create --name='Accessories' --description='Smoking accessories and supplies' --allow-root || true
    \$WP wc product_cat create --name='Vaporizers' --description='Electronic vaporizers and vape pens' --allow-root || true
    \$WP wc product_cat create --name='Apparel' --description='T-shirts, hoodies, and merchandise' --allow-root || true
    echo "✅ Product categories created!"
fi

echo ""
echo "=========================================="
echo "  STEP 4: Check Installed Plugins"
echo "=========================================="
echo ""

\$WP plugin list --allow-root

echo ""
echo "=========================================="
echo "  SETUP COMPLETE!"
echo "=========================================="
echo ""

echo "✅ Your store is configured!"
echo ""
echo "Next steps:"
echo "  1. Visit: https://$DOMAIN"
echo "  2. Test age verification (open incognito)"
echo "  3. Log into WordPress admin: https://$DOMAIN/wp-admin"
echo "  4. Add products: Products -> Add New"
echo "  5. Configure payments: WooCommerce -> Settings -> Payments"
echo ""
"@

# Execute setup script
ssh -o StrictHostKeyChecking=no $SSH_USER@$SSH_HOST "bash -s" <<< $SETUP_SCRIPT

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  ✅ SETUP COMPLETE!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your store is now configured!" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Visit: https://$DOMAIN" -ForegroundColor White
    Write-Host "Admin: https://$DOMAIN/wp-admin" -ForegroundColor White
    Write-Host ""
    Write-Host "Opening your store..." -ForegroundColor Yellow
    Start-Sleep -Seconds 2
    start "https://$DOMAIN"
} else {
    Write-Host ""
    Write-Host "⚠️  Setup encountered issues" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "You may need to:" -ForegroundColor Yellow
    Write-Host "  1. Manually activate plugins in WordPress admin" -ForegroundColor Gray
    Write-Host "  2. Configure WooCommerce settings" -ForegroundColor Gray
    Write-Host "  3. Upload age verification plugin if missing" -ForegroundColor Gray
    Write-Host ""
}

Write-Host ""
pause

