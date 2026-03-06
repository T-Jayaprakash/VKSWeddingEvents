$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
Get-ChildItem $dir -Filter "*.html" | ForEach-Object {
    $c = Get-Content $_.FullName -Raw -Encoding UTF8
    $c = $c.Replace('Birthday &amp; Celebrations', 'Birthday Events')
    $c = $c.Replace('Birthday & Celebrations', 'Birthday Events')
    $c = $c.Replace('Birthday &amp; celebrations', 'Birthday Events')
    $c = $c.Replace('Birthday & celebrations', 'Birthday Events')
    $c = $c.Replace('birthday & celebrations', 'birthday events')
    $c = $c.Replace('birthday &amp; celebrations', 'birthday events')
    [System.IO.File]::WriteAllText($_.FullName, $c, [System.Text.UTF8Encoding]::new($false))
    Write-Host "Done: $($_.Name)"
}
Write-Host "All done."
