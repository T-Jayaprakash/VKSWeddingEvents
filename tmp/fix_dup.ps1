$f = 'c:\Users\ajana\.gemini\antigravity\scratch\VKSWeddingEvents\index.html'
$lines = [System.IO.File]::ReadAllLines($f, [System.Text.Encoding]::UTF8)
# Remove the duplicate line 129 (0-indexed: 128), which is the extra <div class="garland-features">
$fixed = $lines[0..127] + $lines[129..($lines.Length - 1)]
[System.IO.File]::WriteAllLines($f, $fixed, [System.Text.UTF8Encoding]::new($false))
Write-Host "Done: $($fixed.Length) lines"
