# Function to check for admin permissions
function CheckAdmin {
    $currentIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $currentPrincipal = New-Object System.Security.Principal.WindowsPrincipal($currentIdentity)
    return $currentPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Check if the script is running with admin privileges
if (-not (CheckAdmin)) {
    Write-Host "You must run this script as an administrator!" -ForegroundColor Red
    return
}
