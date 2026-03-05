$root = 'c:\Users\ajana\.gemini\antigravity\scratch\VKSWeddingEvents'
$files = Get-ChildItem -Path $root -Filter '*.html' -File

# Define replacement pairs as byte-level sequences using regex on raw bytes
foreach ($f in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $text = [System.Text.Encoding]::Latin1.GetString($bytes)
    $original = $text

    # Garbled UTF-8: these sequences appear when UTF-8 text was read as Latin-1
    # U+00E9 (e acute) encoded as UTF-8 = 0xC3 0xA9, read as Latin-1 = "Ã©"
    $text = $text.Replace([System.Text.Encoding]::Latin1.GetString([byte[]](0xC3, 0xA9)), [char]0xE9)   # é
    # U+2014 (em dash) UTF-8 = E2 80 94 -> Latin-1 = "â€""
    $text = $text.Replace([System.Text.Encoding]::Latin1.GetString([byte[]](0xE2, 0x80, 0x94)), '&#8212;')
    # U+2019 (right single quote) UTF-8 = E2 80 99 -> Latin-1 = "â€™"
    $text = $text.Replace([System.Text.Encoding]::Latin1.GetString([byte[]](0xE2, 0x80, 0x99)), '&#8217;')
    # U+201C (left double quote) UTF-8 = E2 80 9C -> Latin-1 = "â€œ"
    $text = $text.Replace([System.Text.Encoding]::Latin1.GetString([byte[]](0xE2, 0x80, 0x9C)), '&#8220;')
    # U+201D (right double quote) UTF-8 = E2 80 9D -> Latin-1 = "â€"
    $text = $text.Replace([System.Text.Encoding]::Latin1.GetString([byte[]](0xE2, 0x80, 0x9D)), '&#8221;')
    # U+00C2 U+00A0 (non-breaking space) UTF-8 = C2 A0 -> remove stray Â
    $text = $text.Replace([System.Text.Encoding]::Latin1.GetString([byte[]](0xC2, 0xA0)), ' ')
    $text = $text.Replace([System.Text.Encoding]::Latin1.GetString([byte[]](0xC3, 0xA0)), [char]0xE0)   # à

    if ($text -ne $original) {
        # Write back as proper UTF-8
        [System.IO.File]::WriteAllText($f.FullName, $text, [System.Text.UTF8Encoding]::new($false))
        Write-Host "Fixed: $($f.Name)"
    } else {
        Write-Host "Clean: $($f.Name)"
    }
}
Write-Host "`nDone."
