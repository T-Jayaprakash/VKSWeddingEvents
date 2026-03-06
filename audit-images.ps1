$dir = Split-Path -Parent $MyInvocation.MyCommand.Path

$pages = @{
    'manavarai-decoration-trichy.html'    = 'manavarai'
    'entrance-arch-decoration-trichy.html' = 'entrance'
    'birthday-celebration-trichy.html'    = 'birthday celebration'
    'corporate-events-trichy.html'        = 'corporate and political'
    'floral-garlands-trichy.html'         = 'garland'
    'general-decoration-trichy.html'      = 'other'
}

foreach ($page in $pages.Keys) {
    $expected = $pages[$page]
    $path = Join-Path $dir $page
    $lines = Select-String -Path $path -Pattern 'src="images/real/'
    Write-Host "`n=== $page (expected folder: $expected) ==="
    foreach ($line in $lines) {
        if ($line.Line -match 'src="images/real/([^"]+)"') {
            $src = $matches[1]
            $folder = ($src -split '/' | Select-Object -First 1)
            if ($folder -ne $expected) {
                Write-Host "  MISMATCH: $src"
            }
        }
    }
}
Write-Host "`nAudit complete."
