# Rename "Stage Decoration" → "General Decoration" across all HTML files
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
$files = Get-ChildItem -Path $dir -Filter "*.html"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8

    # Visible labels and headings
    $content = $content.Replace('Stage Decoration', 'General Decoration')
    $content = $content.Replace('stage decoration', 'general decoration')
    $content = $content.Replace('Stage decoration', 'General decoration')

    # Title tag and meta updates in stage-decoration-trichy.html
    $content = $content.Replace('Stage Decoration for All Events in Trichy', 'General Decoration for All Events in Trichy')
    $content = $content.Replace('stage decoration for all events in Trichy', 'general decoration for all events in Trichy')
    $content = $content.Replace('Stage Decorators', 'General Decorators')
    $content = $content.Replace('Stage decorators', 'general decorators')
    $content = $content.Replace('Stage Decorator', 'General Decorator')
    $content = $content.Replace("Trichy's Most Trusted Stage Decorators", "Trichy's Most Trusted Event Decorators")
    $content = $content.Replace('stage decoration trichy', 'general decoration trichy')
    $content = $content.Replace('Stage Decoration Trichy', 'General Decoration Trichy')
    $content = $content.Replace('event stage decoration trichy', 'general event decoration trichy')
    $content = $content.Replace('stage-decoration-trichy', 'general-decoration-trichy')

    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.UTF8Encoding]::new($false))
    Write-Host "Done: $($file.Name)"
}

# Also rename the HTML file itself
$old = Join-Path $dir "stage-decoration-trichy.html"
$new = Join-Path $dir "general-decoration-trichy.html"
if (Test-Path $old) {
    Rename-Item -Path $old -NewName "general-decoration-trichy.html"
    Write-Host "Renamed: stage-decoration-trichy.html -> general-decoration-trichy.html"
}

Write-Host "All done."
