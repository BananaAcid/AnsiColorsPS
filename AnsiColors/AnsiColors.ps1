
Function Find-AnsiColor {
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Name
    )

    # filter for closest matches
    return $ansiColors.Keys | 
        Where-Object { $_ -like "*$Name*" } | 
        Sort-Object @{ Expression = { if ($_ -eq $Name) { 0 } else { 1 } } },  # put exact matches first
                    @{ Expression = { $_ } }
}

Function Find-AnsiStyle {
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Name
    )

    # filter for closest matches
    return $ansiStyles.Keys | 
        Where-Object { $_ -like "*$Name*" } | 
        Sort-Object @{ Expression = { if ($_ -eq $Name) { 0 } else { 1 } } },  # put exact matches first
                    @{ Expression = { $_ } }
}

Function ConvertTo-AnsiColorString {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$InputString,
        [Parameter(Mandatory=$false)]
        [string]$ForegroundColor,
        [Parameter(Mandatory=$false)]
        [string]$BackgroundColor,
        [Parameter(Mandatory=$false)]
        [string[]]$Styles

    )
    
    $esc = [char]27 # using char 27 instead of string "`e" because not using `e makeis it PS 5.1 compatible

    $fgColor = $ansiColors[$ForegroundColor]
    $bgColor = $ansiColors[$BackgroundColor]

    $styleSequence = ""

    # multiple styles in array
    if ($Styles) {
        $styleSequence = $Styles | ForEach-Object { "$esc[{0}m" -f $ansiStyles[$_] }
    }

    if ($fgColor -and $bgColor) {
        return "$styleSequence$esc[38;5;{0};48;5;{1}m{2}$esc[0m" -f $fgColor, $bgColor, $InputString
    } elseif ($fgColor) {
        return "$styleSequence$esc[38;5;{0}m{1}$esc[0m" -f $fgColor, $InputString
    } elseif ($bgColor) {
        return "$styleSequence$esc[48;5;{0}m{1}$esc[0m" -f $bgColor, $InputString
    } elseif ($Styles) {
        return "$styleSequence$InputString$esc[0m"
    } else {
        return $InputString
    }
}

$ansiStyles = @{
    Normal = 0;
    Bold = 1;
    Dim = 2;
    Italic = 3;
    Underline = 4;
    Blink = 5;
    RapidBlink = 6;
    Reverse = 7;
    Hidden = 8;
}

$ansiColors = @{
    # Powershell defined ones, 0-15
    Black = 0; DarkBlue = 4; DarkGreen = 2; DarkCyan = 6; DarkRed = 1; DarkMagenta = 5; DarkYellow = 3; Gray = 7; DarkGray = 8; Blue = 12; Green = 10; Cyan = 14; Red = 9; Magenta = 13; Yellow = 11; White = 15;

    # copied from HexDocs.pm
    
    # Blue (37 colors)
    Blue004 = 4; LightBlue012 = 12; FuzzyWuzzy = 17; Stratos = 17; VeryDarkBlue = 17;
    NavyBlue = 18; CarnationPink = 19; DukeBlue = 19; MediumBlue = 20; Orient = 24;
    SeaBlue = 24; Endeavour = 25; MediumPersianBlue = 25; ScienceBlue = 26; TrueBlue = 26;
    BlueRibbon = 27; BrandeisBlue = 27; DeepCerulean = 31; BlueCola = 32; Lochmara = 32;
    StrongBlue = 32; Azure = 33; AzureRadiance = 33; PureBlue = 33; Cerulean = 38;
    BlueBolt = 39; DeepSkyBlue = 39; VividSkyBlue = 45; Comet = 60; MostlyDesaturatedDarkBlue = 60;
    UclaBlue = 60; DarkModerateBlue = 61; Liberty = 61; Scampi = 61; Indigo = 62;
    SlateBlue = 62; CornflowerBlue = 63; HippieBlue = 67; Rackley = 67; SteelBlue = 67;
    HavelockBlue = 68; ModerateBlue = 68; UnitedNationsBlue = 68; Blueberry = 69; LightBlue = 69;
    CrystalBlue = 73; DarkModerateCyan = 73; Tradewind = 73; AquaPearl = 74; CarolinaBlue = 74;
    Shakespeare = 74; BlueJeans = 75; MayaBlue = 81; CoolGrey = 103; DarkGrayishBlue = 103;
    ShadowBlue = 103; ChetwodeBlue = 104; Ube = 104; VioletsAreBlue = 105; LightCobaltBlue = 110;
    PoloBlue = 110; SlightlyDesaturatedBlue = 110; FrenchSkyBlue = 111; Malibu = 111; GrayishBlue = 146;
    WildBlueYonder = 146; Wistful = 146; MaximumBluePurple = 147; Melrose = 147; FreshAir = 153;
    PaleBlue = 153; Fog = 189; PaleLavender = 189; VeryPaleBlue = 189;

    # Brown (17 colors)
    Brown = 94; GambogeOrange = 94; CopperRose = 95; DeepTaupe = 95; MostlyDesaturatedDarkRed = 95;
    DarkOrangeBrownTone = 130; RoseOfSharon = 130; WindsorTan = 130; DarkModerateRed = 131; ElectricBrown = 131;
    Matrix = 131; DarkGoldenrod = 136; PirateGold = 136; Bronze = 137; DarkModerateOrange = 137;
    Muesli = 137; DarkGrayishRed = 138; EnglishLavender = 138; Pharlap = 138; BuddhaGold = 142;
    LightGold = 142; DarkGrayishYellow = 144; Hillary = 144; Sage = 144; Chocolate = 172;
    HarvestGold = 172; MangoTango = 172; Copperfield = 173; RawSienna = 173; Goldenrod = 178;
    MustardYellow = 178; EarthYellow = 179; ModerateOrange = 179; SlightlyDesaturatedOrange = 180; Tan = 180;
    ClamShell = 181; GrayishRed = 181; PaleChestnut = 181; Grandis = 222; Jasmine = 222;
    Khaki = 222; Caramel = 223; Moccasin = 223; PaleOrange = 223;

    # Cyan (19 colors)
    Cyan006 = 6; Aqua = 14; LightCyan014 = 14; Teal = 30; BondiBlue = 37;
    TiffanyBlue = 37; DarkTurquoise = 44; RobinsEggBlue = 44; Juniper = 66; MostlyDesaturatedDarkCyan = 66;
    SteelTeal = 66; MediumTurquoise = 80; ModerateCyan = 80; Viking = 80; Aquamarine086 = 86;
    Aquamarine087 = 87; DarkGrayishCyan = 109; GulfStream = 109; PewterBlue = 109; PearlAqua = 115;
    VistaBlue = 115; Bermuda = 116; MiddleBlueGreen = 116; SlightlyDesaturatedCyan = 116; PaleCyan = 117;
    VeryLightBlue = 117; Aquamarine = 122; LimeGreen = 122; Anakiwa = 123; ElectricBlue = 123;
    VeryLightCyan = 123; Crystal = 152; GrayishCyan = 152; JungleMist = 152; AeroBlue = 158;
    MagicMint = 158; Celeste = 159; FrenchPass = 159;

    # Gray and Black (32 colors)
    Black000 = 0; Argent = 7; LightBlack = 8; Scorpion = 59; TaupeGray = 102;
    SilverFoil = 145; LightSilver = 188; VampireBlack = 232; ChineseBlack = 233; CodGray = 233;
    EerieBlack = 234; RaisinBlack = 235; DarkCharcoal = 236; BlackOlive = 237; MineShaft = 237;
    OuterSpace = 238; DarkLiver = 239; Tundora = 239; DavysGrey = 240; GraniteGray = 241;
    VeryDarkGray = 241; DimGray = 242; DoveGray = 242; Boulder = 243; SonicSilver = 243;
    PhilippineGray = 245; DustyGray = 246; SpanishGray = 247; QuickSilver = 248; PhilippineSilver = 249;
    SilverChalice = 249; Silver = 250; SilverSand = 251; AmericanSilver = 252; LightGray = 252;
    Alto = 253; Gainsboro = 253; Mercury = 254; Platinum = 254; BrightGray = 255;
    Gallery = 255; VeryLightGray = 255;

    # Green (58 colors)
    OfficeGreen = 2; Yellow003 = 3; ElectricGreen = 10; LightGreen010 = 10; Camarone = 22;
    VeryDarkLimeGreen = 22; BangladeshGreen = 23; BlueStone = 23; DarkSlateGray = 23; VeryDarkCyan = 23;
    Ao = 28; DeepSea = 29; SpanishViridian = 29; DarkLimeGreen = 34; IslamicGreen = 34;
    JapaneseLaurel = 34; GoGreen = 35; Jade = 35; PersianGreen = 36; StrongLimeGreen = 40;
    Malachite = 41; CaribbeanGreen042 = 42; CaribbeanGreen = 43; StrongCyan = 43; SpringGreen047 = 47;
    GuppieGreen = 48; MediumSpringGreen = 49; SpringGreen = 49; BrightTurquoise = 50; PureCyan = 50;
    SeaGreen = 50; BronzeYellow = 58; VerdunGreen = 58; VeryDarkYellowOliveTone = 58; Avocado = 64;
    GladeGreen = 65; MostlyDesaturatedDarkLimeGreen = 65; RussianGreen = 65; KellyGreen = 70; DarkModerateLimeGreen = 71;
    Fern = 71; ForestGreen = 71; PolishedPine = 72; SilverTree = 72; AlienArmpit = 76;
    HarlequinGreen = 76; StrongGreen = 76; ModerateLimeGreen = 77; CaribbeanGreenPearl = 78; Downy = 79;
    Eucalyptus = 79; BrightGreen = 82; LightLimeGreen = 83; VeryLightMalachiteGreen = 84; MediumAquamarine = 85;
    DarkYellowOliveTone = 100; Olive = 100; ClayCreek = 101; MostlyDesaturatedDarkYellow = 101; Shadow = 101;
    AppleGreen = 106; Limeade = 106; Asparagus = 107; ChelseaCucumber = 107; DarkModerateGreen = 107;
    BayLeaf = 108; DarkGrayishLimeGreen = 108; DarkSeaGreen = 108; Pistachio = 112; Mantis = 113;
    PastelGreen = 114; SlightlyDesaturatedLimeGreen = 114; Chartreuse = 118; PureGreen = 118; LightGreen = 119;
    ScreaminGreen = 119; VeryLightLimeGreen = 120; MintGreen121 = 121; DarkModerateYellow = 143; OliveGreen = 143;
    RioGrande = 148; SheenGreen = 148; VividLimeGreen = 148; Conifer = 149; JuneBud = 149;
    ModerateGreen = 149; Feijoa = 150; SlightlyDesaturatedGreen = 150; YellowGreen = 150; GrayishLimeGreen = 151;
    LightMossGreen = 151; PixieGreen = 151; Lime = 154; SpringBud = 154; GreenYellow = 155;
    Inchworm = 155; MintGreen = 156; VeryLightGreen = 156; Menthol = 157; PaleLimeGreen = 157;
    GrayishYellow = 187; GreenMist = 187; PastelGray = 187; PaleGreen = 193; Reef = 193;
    TeaGreen = 193; Beige = 194; Nyanza = 194; SnowyMint = 194; VeryPaleLimeGreen = 194;
    LightCyan = 195; OysterBay = 195; VeryPaleCyan = 195;

    # Orange (8 colors)
    StrongOrange = 166; Tenn = 166; BlazeOrange = 202; OrangeRed = 202; VividOrange = 202;
    AmericanOrange = 208; DarkOrange = 208; FlushOrange = 208; Coral = 209; Salmon = 209;
    ChineseYellow = 214; Orange = 214; PureOrange = 214; YellowSea = 214; LightOrange = 215;
    Rajah = 215; TexasRose = 215; HitPink = 216; MacaroniAndCheese = 216; VeryLightOrange = 216;
    Melon = 217; PaleRedPinkTone = 217; Sundown = 217;

    # Pink (24 colors)
    Fuchsia = 13; LightMagenta013 = 13; MexicanPink = 162; StrongPink = 162; HollywoodCerise163 = 163;
    Hopbush = 169; ModeratePink = 169; SuperPink = 169; Heliotrope = 171; LightMagenta = 171;
    MyPink = 174; NewYorkPink = 174; SlightlyDesaturatedRed = 174; CanCan = 175; MiddlePurple = 175;
    SlightlyDesaturatedPink = 175; DeepMauve = 176; LightOrchid = 176; SlightlyDesaturatedMagenta = 176; BrightLilac = 177;
    VeryLightViolet = 177; GrayishMagenta = 182; PinkLavender = 182; Thistle = 182; BrightPink = 198;
    Rose = 198; FashionFuchsia = 199; HollywoodCerise = 199; PurePink = 199; PureMagenta = 200;
    HotPink = 205; LightPink = 205; LightDeepPink = 206; PurplePizzazz = 206; PinkFlamingo = 207;
    ShockingPink = 207; PinkSalmon = 211; TickleMePink = 211; LavenderRose = 212; PrincessPerfume = 212;
    VeryLightPink = 212; BlushPink = 213; FuchsiaPink = 213; VeryLightMagenta = 213; CottonCandy = 218;
    LavenderPink = 218; PalePink = 218; PaleMagenta = 219; RichBrilliantLavender = 219; Shampoo = 219;
    Cosmos = 224; MistyRose = 224; VeryPaleRedPinkTone = 224; BubbleGum = 225; PinkLace = 225;
    VeryPaleMagenta = 225;

    # Purple, Violet and Magenta (29 colors)
    Patriarch = 5; ImperialPurple = 53; Pompadour = 53; VeryDarkMagenta = 53; MetallicViolet = 54;
    PigmentIndigo = 54; ChinesePurple = 55; DarkViolet = 55; ElectricViolet056 = 56; ElectricIndigo = 57;
    FrenchPlum = 89; FreshEggplant = 90; MardiGras = 90; Purple = 91; Violet = 91;
    FrenchViolet = 92; StrongViolet = 92; ElectricViolet = 93; PureViolet = 93; ChineseViolet = 96;
    MostlyDesaturatedDarkMagenta = 96; Strikemaster = 96; DarkModerateViolet = 97; Deluge = 97; RoyalPurple = 97;
    MediumPurple = 98; ModerateViolet = 98; Blueberry099 = 99; Flirt = 126; HeliotropeMagenta = 127;
    VividMulberry = 128; ElectricPurple = 129; DarkModerateMagenta = 133; PearlyPurple = 133; RichLilac = 134;
    LavenderIndigo = 135; LightViolet = 135; Bouquet = 139; DarkGrayishMagenta = 139; OperaMauve = 139;
    Lavender = 140; SlightlyDesaturatedViolet = 140; BrightLavender = 141; DeepMagenta = 164; StrongMagenta = 164;
    Phlox = 165; ModerateMagenta = 170; Orchid = 170; Mauve = 183; PaleViolet = 183;

    # Red (16 colors)
    Maroon = 1; LightRed = 9; BloodRed = 52; Rosewood = 52; VeryDarkRed = 52;
    DeepRed = 88; BrightRed = 124; DarkCandyAppleRed = 124; DarkPink = 125; JazzberryJam = 125;
    DarkModeratePink = 132; Tapestry = 132; TurkishRose = 132; GuardsmanRed = 160; RossoCorsa = 160;
    StrongRed = 160; Razzmatazz = 161; RoyalRed = 161; IndianRed = 167; ModerateRed = 167;
    Roman = 167; Blush = 168; Cranberry = 168; MysticPearl = 168; VividRaspberry = 197;
    WinterSky = 197; Bittersweet = 203; PastelRed = 203; Strawberry = 204; WildWatermelon = 204;
    Tulip = 210; VeryLightRed = 210; VividTangerine = 210;

    # White (3 colors)
    LightWhite = 15; Cream = 230; Cumulus = 230; VeryPaleYellow = 230;

    # Yellow (13 colors)
    LightYellow011 = 11; Citrine = 184; Corn = 184; StrongYellow = 184; ChineseGreen = 185;
    ModerateYellow = 185; Tacha = 185; Deco = 186; MediumSpringBud = 186; SlightlyDesaturatedYellow = 186;
    ChartreuseYellow = 190; PureYellow = 190; Canary = 191; MaximumGreenYellow = 191; Honeysuckle = 192;
    Mindaro = 192; Gold = 220; Dandelion = 221; NaplesYellow = 221; LaserLemon = 227;
    LightYellow = 227; Dolly = 228; PastelYellow = 228; VeryLightYellow = 228; Calamansi = 229;
    PaleYellow = 229; Portafino = 229;
}