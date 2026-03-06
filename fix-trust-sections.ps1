# Replace the full trust-section block on each service page
# with a simple 2-3 line inline "why VKS" blurb specific to each service

$dir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Helper: read file, replace trust-section block, write back
function ReplaceTrust($filename, $newBlock) {
    $path = Join-Path $dir $filename
    $content = Get-Content $path -Raw -Encoding UTF8

    # Match everything from the opening trust-section div to its closing </div>
    # The section starts with <div class="trust-section"> and ends with </div>\n\n
    $pattern = '(?s)<div class="trust-section">.*?</div>\s*</div>\s*</div>'
    $content = [regex]::Replace($content, $pattern, $newBlock)

    [System.IO.File]::WriteAllText($path, $content, [System.Text.UTF8Encoding]::new($false))
    Write-Host "Updated: $filename"
}

# ── STAGE DECORATION ──────────────────────────────────────────────────────────
ReplaceTrust "stage-decoration-trichy.html" @'
<div class="why-vks-inline section-alt">
  <div class="container"><div class="reveal">
    <span class="section-label">Why VKS</span>
    <p>VKS Garland and Decorations has designed 500+ stages across all event types in Trichy over the past 12+ years. We source fresh flowers every morning, arrive on time, and deliver results that exceed expectations — for every occasion, every time.</p>
  </div></div>
</div>
'@

# ── MANAVARAI ──────────────────────────────────────────────────────────────────
ReplaceTrust "manavarai-decoration-trichy.html" @'
<div class="why-vks-inline section-alt">
  <div class="container"><div class="reveal">
    <span class="section-label">Why VKS</span>
    <p>VKS Garland and Decorations has deep roots in South Indian wedding tradition. Our manavarai setups honour your rituals precisely — from the placement of the lamps to the fragrance of the jasmine, every detail is handled with care and cultural respect.</p>
  </div></div>
</div>
'@

# ── ENTRANCE ARCH ──────────────────────────────────────────────────────────────
ReplaceTrust "entrance-arch-decoration-trichy.html" @'
<div class="why-vks-inline section-alt">
  <div class="container"><div class="reveal">
    <span class="section-label">Why VKS</span>
    <p>At VKS Garland and Decorations, entrance arches are not an afterthought — they are the opening statement of your entire event. We design and build arches that stop guests in their tracks and set the perfect mood before they even step inside.</p>
  </div></div>
</div>
'@

# ── BIRTHDAY ───────────────────────────────────────────────────────────────────
ReplaceTrust "birthday-celebration-trichy.html" @'
<div class="why-vks-inline section-alt">
  <div class="container"><div class="reveal">
    <span class="section-label">Why VKS</span>
    <p>VKS Garland and Decorations treats every birthday and private celebration as a personal milestone. We listen to your theme, your colours, your vision — and craft a setup that makes the moment feel as memorable as it should be.</p>
  </div></div>
</div>
'@

# ── CORPORATE ──────────────────────────────────────────────────────────────────
ReplaceTrust "corporate-events-trichy.html" @'
<div class="why-vks-inline section-alt">
  <div class="container"><div class="reveal">
    <span class="section-label">Why VKS</span>
    <p>VKS Garland and Decorations understands that professional events run on precision. We show up prepared, execute on schedule, and deliver stage setups that project exactly the image your organisation needs — without compromise.</p>
  </div></div>
</div>
'@

# ── FLORAL GARLANDS ────────────────────────────────────────────────────────────
ReplaceTrust "floral-garlands-trichy.html" @'
<div class="why-vks-inline section-alt">
  <div class="container"><div class="reveal">
    <span class="section-label">Why VKS</span>
    <p>Every garland from VKS Garland and Decorations is strung fresh on the morning of your event — no stored flowers, no shortcuts. With 12+ years of mastery in traditional South Indian floral craft, we make every garland as beautiful as the moment it marks.</p>
  </div></div>
</div>
'@

Write-Host "All trust sections replaced."
