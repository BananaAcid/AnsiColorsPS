# AnsiColors

Format a string with Ansi Color and Style in PowerShell


## Installation

```ps1
Install-Module AnsiColors
```

## Usage

```ps1
ConvertTo-AnsiColorString [-InputString] <String> [-ForegroundColor <String>] [-BackgroundColor <String>] [-Styles <String[]>] [-NoEnd] [-EscMode <"joined"|"separate">] [-FixColorEOL <Boolean>]
ConvertTo-AnsiColorString [-InputString] <String> [-ForegroundRgbColor <String>] [-BackgroundRgbColor <String>] [-Styles <String[]>] [-NoEnd] [-EscMode <"joined"|"separate">] [-FixColorEOL <Boolean>]
ConvertTo-AnsiColorString [-InputString] <String> [-End] [-FixColorEOL <Boolean>]

Find-AnsiColor [-Name] <string|"*">

Find-AnsiStyle [-Name] <string|"*">

ConvertFrom-AnsiEscapedString [-InputString] <String>
```

## Find-AnsiColor

Lists all matching names (see [ColorPalette](https://hexdocs.pm/color_palette/color_groups.html)), exact match first

Using `-Name *` lists all

## Find-AnsiStyle

Lists all matching names, exact match first

Using `-Name *` lists all

## ConvertFrom-AnsiEscapedString

(Alias `AnsiEscString`) Converts from Linux escaped ansi sequence string to string with Ansi Color and Style in PowerShell,

Strings containing ansi escape sequences with `\033[...m`, `\\e[...m` or `\x1b[...m` or `\x1B[...m` or `\\u001b[...m`

## ConvertTo-AnsiColorString

( Alias `AnsiString`),  returns a ansi colored and styled string (PS 5.1 compatible)

| Parameter | Type | Description |
| --- | --- | --- |
| `InputString` | `String` | The string to format |
| `ForegroundColor` | `String` | The foreground color to use. To get all color names, use `Find-AnsiColor -Name *` |
| `BackgroundColor` | `String` | The background color to use. To get all color names, use `Find-AnsiColor -Name *` |
| `ForegroundRgbColor` | `String` | The foreground color to use. Format `"R;G;B"`, values `0-255`, e.g. `"255;0;0"` |
| `BackgroundRgbColor` | `String` | The background color to use. Format `"R;G;B"`, values `0-255`, e.g. `"0;0;0"` |
| `Styles` | `String`[] | The styles to use. To get all styles, use `Find-AnsiStyle -Name *` |
| `NoEnd` | (is switch) | Don't add the reset sequence at the end |
| `End` | (is switch) | Add the reset sequence at the end (for use with unstyled strings, or without a string) |
| `EscMode` | `"joined"`\|`"separate"` | (default `$Global:AnsiColorsEscMode`\|`"joined"`) Use a joined single or separate multiple escape sequences. If a terminal is breaking due to not supporting a squence, set to `"separate"` (should not happen) |
| `FixColorEOL` | `Boolean` | (default `$Global:AnsiColorsFixColorEOL`\|`false`) Fix color at end of line ("clear rest of line") - This could break output, if overwriting a screenpos and if setting it to `true`<br>This is usually needed if using background color and a multiline string |
| `Fix` | | Switch for FixColorEOL |

### Example

```ps1
$str = ConvertTo-AnsiColorString -InputString "Hello World" -ForegroundColor Green -BackgroundColor Gray -Styles Bold -NoEnd
$str += " some more text with same styles"
$str += ConvertTo-AnsiColorString -InputString " - string is continued" -End -Fix
Write-Host $str
```