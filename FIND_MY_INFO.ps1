# Find Your HostGator Account Information
# This script helps determine your correct username and paths

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  FIND YOUR HOSTGATOR INFO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Let's find your correct HostGator account details!" -ForegroundColor Yellow
Write-Host ""

# Get domain
Write-Host "Enter your HostGator domain name:" -ForegroundColor Cyan
Write-Host "(e.g., yourdomain.com)" -ForegroundColor Gray
$DOMAIN = Read-Host "Domain"

if ([string]::IsNullOrWhiteSpace($DOMAIN)) {
    Write-Host ""
    Write-Host "ERROR: Domain required!" -ForegroundColor Red
    pause
    exit 1
}

Write-Host ""
Write-Host "Your login email is: bgramming@gmail.com" -ForegroundColor Cyan
Write-Host ""
Write-Host "Now let's find your SSH username..." -ForegroundColor Yellow
Write-Host ""
Write-Host "Trying to connect with: bgramming@gmail.com" -ForegroundColor Gray
Write-Host "(Enter your cPanel password when prompted)" -ForegroundColor Yellow
Write-Host ""

# Try connecting and get info
$INFO_SCRIPT = @'
#!/bin/bash
echo ""
echo "=========================================="
echo "  YOUR HOSTGATOR ACCOUNT INFO"
echo "=========================================="
echo ""
echo "SSH Username:"
whoami
echo ""
echo "Home Directory:"
echo $HOME
pwd
echo ""
echo "Home Directory Path:"
realpath ~
echo ""
echo "Public HTML Path:"
if [ -d "$HOME/public_html" ]; then
    echo "$HOME/public_html (EXISTS)"
else
    echo "$HOME/public_html (DOES NOT EXIST YET)"
fi
echo ""
echo "SSH Keys Location:"
if [ -d "$HOME/.ssh" ]; then
    echo "$HOME/.ssh (EXISTS)"
    ls -lah $HOME/.ssh
else
    echo "$HOME/.ssh (DOES NOT EXIST)"
fi
echo ""
echo "=========================================="
echo "  SUMMARY"
echo "=========================================="
echo ""
echo "Use these values in deployment scripts:"
echo ""
echo "SSH_USER: $(whoami)"
echo "HOME_PATH: $HOME"
echo "WEB_PATH: $HOME/public_html"
echo "SSH_KEY_PATH: $HOME/.ssh"
echo ""
'@

Write-Host "Connecting to: $DOMAIN" -ForegroundColor Cyan
Write-Host ""

# Try with email as username
ssh -o StrictHostKeyChecking=no "bgramming@gmail.com"@$DOMAIN "bash -s" <<< $INFO_SCRIPT

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "That didn't work. Let's try other common usernames..." -ForegroundColor Yellow
    Write-Host ""
    
    # Try common variations
    $USERNAMES = @("bgramming", "bgram", "burning5")
    
    foreach ($USER in $USERNAMES) {
        Write-Host "Trying username: $USER" -ForegroundColor Cyan
        Write-Host "(Enter password if prompted)" -ForegroundColor Gray
        Write-Host ""
        
        ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 ${USER}@$DOMAIN "bash -s" <<< $INFO_SCRIPT
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "✅ SUCCESS! Your username is: $USER" -ForegroundColor Green
            Write-Host ""
            break
        } else {
            Write-Host "❌ Username '$USER' didn't work" -ForegroundColor Red
            Write-Host ""
        }
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  NEXT STEPS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "If none of the usernames worked:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Log into HostGator cPanel" -ForegroundColor Gray
Write-Host "2. Look for 'SSH Access' or 'Terminal'" -ForegroundColor Gray
Write-Host "3. Your SSH username will be shown there" -ForegroundColor Gray
Write-Host ""
Write-Host "OR" -ForegroundColor Yellow
Write-Host ""
Write-Host "Call HostGator Support: 1-866-96-GATOR" -ForegroundColor Cyan
Write-Host "Ask: 'What is my SSH username?'" -ForegroundColor Gray
Write-Host ""
Write-Host "Once you know your username, I'll update all the scripts!" -ForegroundColor Green
Write-Host ""

pause

