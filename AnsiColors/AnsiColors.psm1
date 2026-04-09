. .\AnsiColors.ps1

# ConvertTo-AnsiColorString
Set-Alias -Name AnsiString -Value ConvertTo-AnsiColorString

. .\FromEscapedString.ps1

Set-Alias -Name AnsiEscString -Value ConvertFrom-AnsiEscapedString


Export-ModuleMember -Function "ConvertTo-AnsiColorString", "Find-AnsiColor", "Find-AnsiStyle", "ConvertFrom-AnsiEscapedString" -Alias 'AnsiString', 'AnsiEscString'