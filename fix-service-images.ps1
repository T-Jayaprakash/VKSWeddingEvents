# Fix service page work-showcase images to use category-specific images
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path

# BIRTHDAY PAGE: replace with birthday celebration/ images
$birthday = Join-Path $dir "birthday-celebration-trichy.html"
$content = Get-Content $birthday -Raw -Encoding UTF8
# Fix hero image
$content = $content.Replace('src="images/real/entrance/DP3_8907.webp" alt="Birthday celebration decoration by VKS Garland and Decorations Trichy"', 'src="images/real/birthday celebration/1.webp" alt="Birthday celebration decoration by VKS Garland and Decorations Trichy"')
# Fix work showcase images  
$content = $content.Replace('src="images/real/entrance/DP3_8907.webp" alt="Birthday celebration decoration VKS Trichy"', 'src="images/real/birthday celebration/1.webp" alt="Birthday celebration decoration VKS Trichy"')
$content = $content.Replace('src="images/real/entrance/DP3_8905.webp" alt="Celebration event decoration"', 'src="images/real/birthday celebration/2.webp" alt="Celebration event decoration"')
$content = $content.Replace('src="images/real/garland/collection4.webp" alt="Floral garland arrangement for celebration"', 'src="images/real/birthday celebration/3.webp" alt="Celebration floral arrangement"')
$content = $content.Replace('src="images/real/other/DP3_8901.webp" alt="Event stage decoration"', 'src="images/real/birthday celebration/4.webp" alt="Birthday stage decoration"')
$content = $content.Replace('src="images/real/manavarai/DP3_8146.webp" alt="Luxury hall celebration setup"', 'src="images/real/birthday celebration/download.webp" alt="Luxury hall celebration setup"')
[System.IO.File]::WriteAllText($birthday, $content, [System.Text.UTF8Encoding]::new($false))
Write-Host "Updated birthday page"

# CORPORATE PAGE: replace with corporate and political/ images
$corporate = Join-Path $dir "corporate-events-trichy.html"
$content = Get-Content $corporate -Raw -Encoding UTF8
# Fix hero image
$content = $content.Replace('src="images/real/entrance/PRB_6584.webp" alt="Corporate and political event stage by VKS Garland and Decorations Trichy"', 'src="images/real/corporate and political/1.webp" alt="Corporate and political event stage by VKS Garland and Decorations Trichy"')
# Fix work showcase images
$content = $content.Replace('src="images/real/entrance/PRB_6584.webp" alt="Corporate stage decoration by VKS Trichy"', 'src="images/real/corporate and political/1.webp" alt="Corporate stage decoration by VKS Trichy"')
$content = $content.Replace('src="images/real/entrance/PRB_6519.webp" alt="Grand stage setup for event"', 'src="images/real/corporate and political/2.webp" alt="Corporate event stage setup"')
$content = $content.Replace('src="images/real/entrance/DP3_8124.webp" alt="Event entrance arch"', 'src="images/real/corporate and political/IMG_1767 (2).webp" alt="Inauguration ceremony decoration"')
$content = $content.Replace('src="images/real/manavarai/DP3_8146.webp" alt="Luxury event hall setup"', 'src="images/real/corporate and political/download.webp" alt="Corporate event floral design"')
$content = $content.Replace('src="images/real/entrance/DP3_8905.webp" alt="Professional stage side decoration"', 'src="images/real/corporate and political/download (1).webp" alt="Political event stage"')
[System.IO.File]::WriteAllText($corporate, $content, [System.Text.UTF8Encoding]::new($false))
Write-Host "Updated corporate page"

# FLORAL GARLANDS PAGE: replace showcase with garland/ images (hero already correct)
$garland = Join-Path $dir "floral-garlands-trichy.html"
$content = Get-Content $garland -Raw -Encoding UTF8
$content = $content.Replace('src="images/real/manavarai/DP2_8536.webp" alt="Floral bouquets Trichy"', 'src="images/real/garland/1.webp" alt="Floral bouquets Trichy"')
$content = $content.Replace('src="images/real/garland/1.webp" alt="Floral arrangements and garlands"', 'src="images/real/garland/2.webp" alt="Floral arrangements and garlands"')
$content = $content.Replace('src="images/real/entrance/DP3_8129.webp" alt="Traditional garland hanging for manavarai"', 'src="images/real/garland/3.webp" alt="Traditional garland hanging"')
$content = $content.Replace('src="images/real/manavarai/DSC07874.webp" alt="Wedding hall garland decoration"', 'src="images/real/garland/4.webp" alt="Wedding hall garland decoration"')
[System.IO.File]::WriteAllText($garland, $content, [System.Text.UTF8Encoding]::new($false))
Write-Host "Updated floral garlands page"

# ENTRANCE ARCH PAGE: ensure it uses entrance/ images in its showcase
$entrance = Join-Path $dir "entrance-arch-decoration-trichy.html"
$content = Get-Content $entrance -Raw -Encoding UTF8
# These should already be correct from PS1 run, but verify hero
$content = $content.Replace('src="images/real/manavarai/DSC07874.webp" alt="Wedding hall garland decor"', 'src="images/real/entrance/download (1).webp" alt="Entrance arch decoration"')
[System.IO.File]::WriteAllText($entrance, $content, [System.Text.UTF8Encoding]::new($false))
Write-Host "Updated entrance arch page"

# MANAVARAI PAGE: ensure manavarai/ images in showcase
$manavarai = Join-Path $dir "manavarai-decoration-trichy.html"
$content = Get-Content $manavarai -Raw -Encoding UTF8
[System.IO.File]::WriteAllText($manavarai, $content, [System.Text.UTF8Encoding]::new($false))
Write-Host "Updated manavarai page"

Write-Host "All service pages updated."
