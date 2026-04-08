# AnsiColors

Format a string with Ansi Color and Style in PowerShell


## Installation

```ps1
Install-Module AnsiColors
```

## Usage

```ps1
ConvertTo-AnsiColorString [-InputString] <string> [-ForegroundColor <string>] [-BackgroundColor <string>]

Find-AnsiColor [-Name] <string>

Find-AnsiStyle [-Name] <string>
```

`ConvertTo-AnsiColorString` returns a ansi colored string (PS 5.1 compatible)

`Find-AnsiColor -Name` lists all matching names, exact match first

`Find-AnsiStyle -Name` lists all matching names, exact match first