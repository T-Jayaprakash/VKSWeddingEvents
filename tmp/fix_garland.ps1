$file = 'c:\Users\ajana\.gemini\antigravity\scratch\VKSWeddingEvents\index.html'
$lines = [System.IO.File]::ReadAllLines($file, [System.Text.Encoding]::UTF8)

$newLines = @(
'        <div class="garland-features">',
'          <div class="garland-feature-item">',
'            <div class="garland-feature-icon">',
'              <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22V12"/><path d="M12 12C12 8 9 5 6 5s-3 4 0 6 6 1 6 1z"/><path d="M12 12C12 8 15 5 18 5s3 4 0 6-6 1-6 1z"/></svg>',
'            </div>',
'            <div class="garland-feature-content">',
'              <h4>Fresh Flowers Daily</h4>',
'              <p>Every garland from VKS Garland and Decorations is strung fresh on the morning of your event &mdash; never stored, never artificial.</p>',
'            </div>',
'          </div>',
'          <div class="garland-feature-item">',
'            <div class="garland-feature-icon">',
'              <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2L2 7l10 5 10-5-10-5z"/><path d="M2 17l10 5 10-5"/><path d="M2 12l10 5 10-5"/></svg>',
'            </div>',
'            <div class="garland-feature-content">',
'              <h4>Traditional Craftsmanship</h4>',
'              <p>At VKS Garland and Decorations, our designs are rooted in traditional South Indian wedding customs &mdash; jasmine maalai, rose maalai, marigold torana and more.</p>',
'            </div>',
'          </div>',
'          <div class="garland-feature-item">',
'            <div class="garland-feature-icon">',
'              <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"/><circle cx="12" cy="12" r="8"/><line x1="12" y1="4" x2="12" y2="2"/><line x1="12" y1="22" x2="12" y2="20"/></svg>',
'            </div>',
'            <div class="garland-feature-content">',
'              <h4>Bridal &amp; Groom Garlands</h4>',
'              <p>VKS Garland and Decorations crafts bespoke garlands for the bride and groom, perfectly matched to your stage d&eacute;cor and colour palette.</p>',
'            </div>',
'          </div>',
'          <div class="garland-feature-item">',
'            <div class="garland-feature-icon">',
'              <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>',
'            </div>',
'            <div class="garland-feature-content">',
'              <h4>Venue Garland Decor</h4>',
'              <p>From cascading doorway garlands to pillar arrangements, VKS Garland and Decorations dresses your entire venue with hanging florals and torana.</p>',
'            </div>',
'          </div>',
'        </div>'
)

# Replace lines 128 to 157 (1-indexed) = indices 127 to 156 (0-indexed)
$before = $lines[0..127]
$after  = $lines[157..($lines.Length - 1)]
$result = $before + $newLines + $after

[System.IO.File]::WriteAllLines($file, $result, [System.Text.UTF8Encoding]::new($false))
Write-Host "Done: $($result.Length) lines written"
