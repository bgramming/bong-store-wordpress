# Check HostGator Server Files via SSH
# This script connects to your HostGator server and shows what's there

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  CHECK HOSTGATOR SERVER FILES" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Get domain
Write-Host "Enter your HostGator domain name:" -ForegroundColor Yellow
Write-Host "(e.g., yourdomain.com, yoursite.com, or burning5.hostgatorwebsite.com)" -ForegroundColor Gray
Write-Host ""
$DOMAIN = Read-Host "Domain"

if ([string]::IsNullOrWhiteSpace($DOMAIN)) {
    Write-Host ""
    Write-Host "ERROR: Domain cannot be empty!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Find your domain in:" -ForegroundColor Yellow
    Write-Host "  - HostGator Portal -> Domains" -ForegroundColor Gray
    Write-Host "  - cPanel (top right corner)" -ForegroundColor Gray
    Write-Host ""
    pause
    exit 1
}

Write-Host ""
Write-Host "Connecting to: burning5@$DOMAIN" -ForegroundColor Cyan
Write-Host ""
Write-Host "You'll be prompted for your cPanel password." -ForegroundColor Yellow
Write-Host ""
Write-Host "Press Enter to continue..." -ForegroundColor Cyan
Read-Host

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  CHECKING SERVER..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Create a script to run on the server
$CHECK_SCRIPT = @'
#!/bin/bash

echo ""
echo "=========================================="
echo "  SERVER INFORMATION"
echo "=========================================="
echo ""
echo "Current Directory:"
pwd
echo ""
echo "Username:"
whoami
echo ""
echo "Home Directory:"
echo $HOME
echo ""

echo "=========================================="
echo "  HOME DIRECTORY CONTENTS"
echo "=========================================="
echo ""
ls -lah /home4/burning5 | head -20
echo ""

echo "=========================================="
echo "  PUBLIC_HTML DIRECTORY"
echo "=========================================="
echo ""
if [ -d "/home4/burning5/public_html" ]; then
    echo "✅ public_html exists!"
    echo ""
    echo "Contents:"
    ls -lah /home4/burning5/public_html | head -20
    echo ""
    
    # Check if WordPress is installed
    if [ -f "/home4/burning5/public_html/wp-config.php" ]; then
        echo "✅ WordPress is installed!"
        echo ""
        echo "WordPress files:"
        ls -lah /home4/burning5/public_html | grep wp-
    else
        echo "❌ WordPress is NOT installed yet"
    fi
else
    echo "❌ public_html does NOT exist yet"
    echo ""
    echo "This is normal if you haven't deployed anything yet."
fi
echo ""

echo "=========================================="
echo "  SSH KEYS"
echo "=========================================="
echo ""
if [ -d "/home4/burning5/.ssh" ]; then
    echo "✅ .ssh directory exists!"
    echo ""
    ls -lah /home4/burning5/.ssh
    echo ""
    
    if [ -f "/home4/burning5/.ssh/cursor_ai" ]; then
        echo "✅ SSH key 'cursor_ai' found!"
        echo ""
        echo "Key fingerprint:"
        ssh-keygen -lf /home4/burning5/.ssh/cursor_ai.pub 2>/dev/null || echo "Public key not found"
    else
        echo "❌ SSH key 'cursor_ai' not found"
    fi
else
    echo "❌ .ssh directory does not exist"
fi
echo ""

echo "=========================================="
echo "  DISK USAGE"
echo "=========================================="
echo ""
echo "Top 10 largest directories/files:"
du -sh /home4/burning5/* 2>/dev/null | sort -rh | head -10
echo ""

echo "=========================================="
echo "  AVAILABLE TOOLS"
echo "=========================================="
echo ""
echo "Checking for installed tools..."
echo ""

# Check for WP-CLI
if command -v wp &> /dev/null; then
    echo "✅ WP-CLI: $(wp --version 2>/dev/null)"
elif [ -f "/home4/burning5/bin/wp" ]; then
    echo "✅ WP-CLI: $(/home4/burning5/bin/wp --version 2>/dev/null)"
else
    echo "❌ WP-CLI: Not installed"
fi

# Check for PHP
if command -v php &> /dev/null; then
    echo "✅ PHP: $(php -v | head -1)"
else
    echo "❌ PHP: Not found in PATH"
fi

# Check for MySQL
if command -v mysql &> /dev/null; then
    echo "✅ MySQL: Available"
else
    echo "❌ MySQL: Not found in PATH"
fi

# Check for Git
if command -v git &> /dev/null; then
    echo "✅ Git: $(git --version)"
else
    echo "❌ Git: Not installed"
fi

echo ""
echo "=========================================="
echo "  DATABASES"
echo "=========================================="
echo ""
echo "Checking for databases..."
echo ""

# Try to list databases (may require password)
mysql -u burning5 -e "SHOW DATABASES;" 2>/dev/null | grep burning5 || echo "Cannot list databases (password required or no access)"

echo ""
echo "=========================================="
echo "  SUMMARY"
echo "=========================================="
echo ""

if [ -f "/home4/burning5/public_html/wp-config.php" ]; then
    echo "✅ WordPress is INSTALLED and ready!"
    echo ""
    echo "Next steps:"
    echo "  1. Visit your site to complete setup"
    echo "  2. Log into WordPress admin"
    echo "  3. Install WooCommerce"
    echo "  4. Upload Age Verification plugin"
else
    echo "❌ WordPress is NOT installed yet"
    echo ""
    echo "Next steps:"
    echo "  1. Run DEPLOY_NOW.bat to install WordPress"
    echo "  2. Or manually install via cPanel"
fi

echo ""
'@

# Execute the check script on the server
Write-Host "Running diagnostics on server..." -ForegroundColor Yellow
Write-Host ""

ssh -o StrictHostKeyChecking=no burning5@$DOMAIN "bash -s" <<< $CHECK_SCRIPT

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  CHECK COMPLETE!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "  CONNECTION FAILED" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Possible issues:" -ForegroundColor Yellow
    Write-Host "  1. Domain name is incorrect" -ForegroundColor Gray
    Write-Host "  2. SSH is not enabled (contact HostGator)" -ForegroundColor Gray
    Write-Host "  3. Password is incorrect" -ForegroundColor Gray
    Write-Host "  4. Firewall blocking connection" -ForegroundColor Gray
    Write-Host ""
    Write-Host "HostGator Support: 1-866-96-GATOR" -ForegroundColor Cyan
    Write-Host ""
}

pause

