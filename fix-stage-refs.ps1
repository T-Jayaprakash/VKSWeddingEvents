# Replace all references to wedding-stage-decoration-trichy with stage-decoration-trichy
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
$files = Get-ChildItem -Path $dir -Filter "*.html"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8

    # Replace filename references
    $content = $content.Replace('wedding-stage-decoration-trichy.html', 'stage-decoration-trichy.html')

    # Replace visible link labels (in footers, nav, service lists)
    $content = $content.Replace('>Wedding Stage</a>', '>Stage Decoration</a>')
    $content = $content.Replace('>Wedding Design</a>', '>Stage Decoration</a>')
    $content = $content.Replace('>Wedding Stage Decoration</a>', '>Stage Decoration</a>')
    $content = $content.Replace('>Wedding Stage Decoration Trichy</a>', '>Stage Decoration Trichy</a>')

    # Replace featured card title
    $content = $content.Replace('<div class="featured-overlay-title">Grand Wedding Stage</div>', '<div class="featured-overlay-title">Stage Decoration</div>')

    # Replace SEO tag text
    $content = $content.Replace('>Wedding Decoration Trichy</a>', '>Decoration Services Trichy</a>')
    $content = $content.Replace('>Wedding Decorators Trichy</a>', '>Event Decorators Trichy</a>')
    $content = $content.Replace('>Marriage Decoration Trichy</a>', '>Function Decoration Trichy</a>')

    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.UTF8Encoding]::new($false))
    Write-Host "Done: $($file.Name)"
}
Write-Host "All references updated."
