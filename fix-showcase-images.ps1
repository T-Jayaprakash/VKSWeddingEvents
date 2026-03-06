$dir = Split-Path -Parent $MyInvocation.MyCommand.Path

# ── MANAVARAI PAGE ─────────────────────────────────────────────────────────────
$f = Join-Path $dir "manavarai-decoration-trichy.html"
$c = Get-Content $f -Raw -Encoding UTF8

# Fix hero image (wrong: entrance/DP3_8129)
$c = $c.Replace(
    'src="images/real/entrance/DP3_8129.webp"' + "`r`n" + '                        alt="Traditional manavarai decoration by VKS Garland and Decorations Trichy"',
    'src="images/real/manavarai/DSC07874.webp"' + "`r`n" + '                        alt="Traditional manavarai decoration by VKS Garland and Decorations Trichy"'
)
# Fix og:image
$c = $c.Replace('content="images/real/entrance/DP3_8129.webp"', 'content="images/real/manavarai/DSC07874.webp"')

# Fix showcase item 1 (wrong: entrance/DP3_8129)
$c = $c.Replace(
    'src="images/real/entrance/DP3_8129.webp" alt="Traditional manavarai setup by VKS Trichy"',
    'src="images/real/manavarai/DP3_8146.webp" alt="Traditional manavarai setup by VKS Trichy"'
)
# Fix showcase item 3 (wrong: garland/collection4)
$c = $c.Replace(
    'src="images/real/garland/collection4.webp" alt="Bridal garlands for manavarai"',
    'src="images/real/manavarai/DP2_8534.webp" alt="Manavarai ceremony decoration"'
)
# Fix showcase item 5 (wrong: entrance/PRB_6519)
$c = $c.Replace(
    'src="images/real/entrance/PRB_6519.webp" alt="Grand wedding stage and manavarai"',
    'src="images/real/manavarai/IMG_1954.webp" alt="Manavarai floral arrangement"'
)

[System.IO.File]::WriteAllText($f, $c, [System.Text.UTF8Encoding]::new($false))
Write-Host "Fixed: manavarai-decoration-trichy.html"

# ── ENTRANCE DESIGN PAGE ───────────────────────────────────────────────────────
$f = Join-Path $dir "entrance-arch-decoration-trichy.html"
$c = Get-Content $f -Raw -Encoding UTF8

# Fix any manavarai/ or garland/ images in work showcase - replace with entrance/ ones
$c = $c.Replace(
    'src="images/real/manavarai/DSC07874.webp" alt="Entrance decoration"',
    'src="images/real/entrance/DP3_8129.webp" alt="Entrance design decoration"'
)
$c = $c.Replace(
    'src="images/real/entrance/download (1).webp" alt="Entrance design decoration"',
    'src="images/real/entrance/DP3_8129.webp" alt="Entrance design decoration"'
)

[System.IO.File]::WriteAllText($f, $c, [System.Text.UTF8Encoding]::new($false))
Write-Host "Fixed: entrance-arch-decoration-trichy.html"

# ── BIRTHDAY PAGE ──────────────────────────────────────────────────────────────
$f = Join-Path $dir "birthday-celebration-trichy.html"
$c = Get-Content $f -Raw -Encoding UTF8

# Hero image should be birthday category
$c = $c.Replace(
    'src="images/real/entrance/1.webp" alt="Birthday celebration decoration by VKS Garland and Decorations Trichy"',
    'src="images/real/birthday celebration/1.webp" alt="Birthday celebration decoration by VKS Garland and Decorations Trichy"'
)

[System.IO.File]::WriteAllText($f, $c, [System.Text.UTF8Encoding]::new($false))
Write-Host "Fixed: birthday-celebration-trichy.html"

# ── CORPORATE PAGE ─────────────────────────────────────────────────────────────
$f = Join-Path $dir "corporate-events-trichy.html"
$c = Get-Content $f -Raw -Encoding UTF8

# Fix showcase items that use entrance/ images
$c = $c.Replace(
    'src="images/real/entrance/PRB_6519.webp" alt="Corporate event stage setup"',
    'src="images/real/corporate and political/2.webp" alt="Corporate event stage setup"'
)
$c = $c.Replace(
    'src="images/real/entrance/DP3_8124.webp" alt="Inauguration ceremony decoration"',
    'src="images/real/corporate and political/IMG_1767 (2).webp" alt="Inauguration ceremony decoration"'
)
$c = $c.Replace(
    'src="images/real/entrance/DP3_8905.webp" alt="Political event stage"',
    'src="images/real/corporate and political/download (1).webp" alt="Political event stage"'
)

[System.IO.File]::WriteAllText($f, $c, [System.Text.UTF8Encoding]::new($false))
Write-Host "Fixed: corporate-events-trichy.html"

# ── FLORAL GARLANDS PAGE ───────────────────────────────────────────────────────
$f = Join-Path $dir "floral-garlands-trichy.html"
$c = Get-Content $f -Raw -Encoding UTF8

# Fix showcase items using wrong folders
$c = $c.Replace(
    'src="images/real/garland/1.webp" alt="Floral bouquets Trichy"',
    'src="images/real/garland/2.webp" alt="Floral bouquets Trichy"'
)
$c = $c.Replace(
    'src="images/real/entrance/DP3_8129.webp" alt="Traditional garland hanging"',
    'src="images/real/garland/3.webp" alt="Traditional garland hanging"'
)
$c = $c.Replace(
    'src="images/real/garland/4.webp" alt="Wedding hall garland decoration"',
    'src="images/real/garland/Exclusives hand bunch.webp" alt="Exclusive hand bouquet Trichy"'
)

[System.IO.File]::WriteAllText($f, $c, [System.Text.UTF8Encoding]::new($false))
Write-Host "Fixed: floral-garlands-trichy.html"

Write-Host "All service pages fixed."
