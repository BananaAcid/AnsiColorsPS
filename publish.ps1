# Fix for -> Write-Error: Failed to generate the compressed file for module 'Cannot index into a null array.'.
$env:DOTNET_CLI_UI_LANGUAGE="en_US"


Test-ModuleManifest -Path ".\AnsiColors\AnsiColors.psd1"

Test-ModuleManifest -Path ".\AnsiColors\AnsiColors.psd1" | Select-Object -expandproperty exportedcommands | format-table

pause
Publish-Module -Path ".\AnsiColors" -NuGetApiKey $env:NUGET_API_KEY -Verbose

<#
# find module
Find-Module AnsiColors

# install test
Install-Module AnsiColors -Scope CurrentUser

# Import test
Import-Module AnsiColors
#>



<# 
New-ModuleManifest -Path ".\AnsiColors\AnsiColors.psd1" `
    -RootModule "AnsiColors.psm1" `
    -Author "Nabil Redmann (BananaAcid)" `
    -Description "AnsiColor handling in PowerShell" `
    -CompanyName "Nabil Redmann" `
    -ModuleVersion "1.0.0" `
    -FunctionsToExport "*" `
    -PowerShellVersion "5.1"
#>