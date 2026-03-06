# Fix image paths after folder reorganization
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
$files = Get-ChildItem -Path $dir -Filter "*.html" | Where-Object {
    $_.Name -ne "blog-wedding-trends-trichy-2026.html"
}

# Old flat path => New categorized path
$map = @{
    "images/real/DSC07874.webp"       = "images/real/manavarai/DSC07874.webp"
    "images/real/DP3_8146.webp"       = "images/real/manavarai/DP3_8146.webp"
    "images/real/DP2_8534.webp"       = "images/real/manavarai/DP2_8534.webp"
    "images/real/DP2_8536.webp"       = "images/real/manavarai/DP2_8536.webp"
    "images/real/DP2_7869.webp"       = "images/real/manavarai/DP2_7869.webp"
    "images/real/PRB_6519.webp"       = "images/real/entrance/PRB_6519.webp"
    "images/real/PRB_6584.webp"       = "images/real/entrance/PRB_6584.webp"
    "images/real/DP3_8124.webp"       = "images/real/entrance/DP3_8124.webp"
    "images/real/DP3_8129.webp"       = "images/real/entrance/DP3_8129.webp"
    "images/real/DP3_8905.webp"       = "images/real/entrance/DP3_8905.webp"
    "images/real/DP3_8907.webp"       = "images/real/entrance/DP3_8907.webp"
    "images/real/DP2_7898.webp"       = "images/real/entrance/DP2_7898.webp"
    "images/real/collection4.webp"    = "images/real/garland/collection4.webp"
    "images/real/DP3_8901.webp"       = "images/real/other/DP3_8901.webp"
    "images/real/gallery3.webp"       = "images/real/garland/1.webp"
    "images/real/IMG_1314.PNG"        = "images/real/manavarai/DSC07874.webp"
    "images/real/IMG_1862 (2).JPG"    = "images/real/corporate and political/1.webp"
    "images/real/IMG_1767 (2).JPG"    = "images/real/corporate and political/IMG_1767 (2).webp"
    "images/real/IMG_1954.JPG"        = "images/real/manavarai/IMG_1954.webp"
}

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    foreach ($old in $map.Keys) {
        $new = $map[$old]
        $content = $content.Replace($old, $new)
    }
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.UTF8Encoding]::new($false))
    Write-Host "Updated: $($file.Name)"
}
Write-Host "All done."
