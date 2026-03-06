$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
Get-ChildItem $dir -Filter "*.html" | ForEach-Object {
    $c = Get-Content $_.FullName -Raw -Encoding UTF8
    $c = $c.Replace('Entrance Arch Design', 'Entrance Design')
    $c = $c.Replace('Entrance Arch Decoration', 'Entrance Design')
    $c = $c.Replace('entrance arch design', 'entrance design')
    $c = $c.Replace('entrance arch decoration', 'entrance design')
    $c = $c.Replace('Entrance Arch', 'Entrance Design')
    $c = $c.Replace('entrance arch', 'entrance design')
    [System.IO.File]::WriteAllText($_.FullName, $c, [System.Text.UTF8Encoding]::new($false))
    Write-Host "Done: $($_.Name)"
}
Write-Host "All done."
