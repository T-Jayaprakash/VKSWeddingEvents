$root = 'c:\Users\ajana\.gemini\antigravity\scratch\VKSWeddingEvents'

$seoBlock = @'

    <section class="seo-tags">
        <h3>Popular Decoration Searches in Trichy</h3>
        <div class="seo-tag-cloud">
            <a href="wedding-stage-decoration-trichy.html" class="seo-tag">Wedding Decoration Trichy</a>
            <a href="wedding-stage-decoration-trichy.html" class="seo-tag">Wedding Decorators Trichy</a>
            <a href="wedding-stage-decoration-trichy.html" class="seo-tag">Marriage Decoration Trichy</a>
            <a href="wedding-stage-decoration-trichy.html" class="seo-tag">Wedding Stage Decoration Trichy</a>
            <a href="manavarai-decoration-trichy.html" class="seo-tag">Manavarai Decoration Trichy</a>
            <a href="entrance-arch-decoration-trichy.html" class="seo-tag">Entrance Arch Decoration Trichy</a>
            <a href="services.html" class="seo-tag">Flower Decoration Trichy</a>
            <a href="services.html" class="seo-tag">Stage Decoration Trichy</a>
            <a href="services.html" class="seo-tag">Event Decoration Services Trichy</a>
            <a href="services.html" class="seo-tag">Garland Makers Trichy</a>
            <a href="services.html" class="seo-tag">Trichy Malai Makers</a>
            <a href="services.html" class="seo-tag">Flower Malai Trichy</a>
            <a href="services.html" class="seo-tag">Bride Groom Garlands Trichy</a>
            <a href="services.html" class="seo-tag">Traditional Garlands Trichy</a>
            <a href="services.html" class="seo-tag">Birthday Decoration Trichy</a>
            <a href="services.html" class="seo-tag">Baby Shower Decoration Trichy</a>
            <a href="services.html" class="seo-tag">Seemantham Decoration Trichy</a>
            <a href="services.html" class="seo-tag">College Event Decoration Trichy</a>
            <a href="services.html" class="seo-tag">Political Stage Decoration Trichy</a>
            <a href="services.html" class="seo-tag">Temple Decoration Trichy</a>
            <a href="gallery.html" class="seo-tag">Wedding Decoration Photos Trichy</a>
            <a href="services.html" class="seo-tag">Event Decorators Tiruchirappalli</a>
            <a href="services.html" class="seo-tag">Decoration Works Trichy</a>
            <a href="services.html" class="seo-tag">Decoration Workers Trichy</a>
        </div>
    </section>

'@

$files = Get-ChildItem -Path $root -Filter '*.html' -File | Where-Object { $_.Name -notmatch '^tmp' }

foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)

    # Skip if already injected
    if ($content -match 'class="seo-tags"') {
        Write-Host "SKIP (already has seo-tags): $($f.Name)"
        continue
    }

    # Insert before <footer
    if ($content -match '<footer') {
        $content = [System.Text.RegularExpressions.Regex]::Replace(
            $content,
            '(?i)(\s*<footer\s)',
            $seoBlock + '    <footer '
        )
        [System.IO.File]::WriteAllText($f.FullName, $content, [System.Text.UTF8Encoding]::new($false))
        Write-Host "Updated: $($f.Name)"
    } else {
        Write-Host "SKIP (no footer found): $($f.Name)"
    }
}

Write-Host "`nDone."
