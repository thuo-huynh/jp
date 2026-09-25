$ErrorActionPreference = 'Stop'

$source = Get-Content -LiteralPath (Join-Path $PSScriptRoot '..\index.html') -Raw -Encoding UTF8
$requirements = @{
  'canvas viewport' = '<canvas id="n2-p1-map-canvas"'
  'animation frame rendering' = 'requestAnimationFrame'
  'wheel zoom handler' = "addEventListener('wheel'"
  'pointer pan handler' = "addEventListener('pointerdown'"
}

$missing = $requirements.GetEnumerator() | Where-Object { $source -notmatch [regex]::Escape($_.Value) } | ForEach-Object Key
if ($source -notmatch 'Math\.min\(frameWidth / p1MapSource\.naturalWidth, frameHeight / p1MapSource\.naturalHeight\)') {
  $missing += 'contain-fit zoom floor'
}
foreach ($mapId in @('p1', 'p2', 'p3', 'p4', 'full')) {
  $selector = 'data-map-source="' + $mapId + '"'
  if ($source -notmatch [regex]::Escape($selector)) {
    $missing += "map selector $mapId"
  }
}
if ($missing) {
  throw "N2 P1 canvas viewer is incomplete. Missing: $($missing -join ', ')"
}

Write-Output 'N2 P1 canvas viewer verification passed.'
