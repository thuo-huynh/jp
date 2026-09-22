$ErrorActionPreference = 'Stop'
$source = Get-Content -LiteralPath (Join-Path $PSScriptRoot '..\index.html') -Raw -Encoding UTF8
$requirements = @(
  'data-map-source="p1"',
  'data-map-source="p2"',
  'data-map-source="p3"',
  'data-map-source="p4"',
  'data-map-source="full"',
  'Math.min(frameWidth / p1MapSource.naturalWidth, frameHeight / p1MapSource.naturalHeight)'
)
$missing = $requirements | Where-Object { -not $source.Contains($_) }
$assets = 'n2-p1-mindmap.png', 'n2-p2-mindmap.png', 'n2-p3-mindmap.png', 'n2-p4-mindmap.png', 'n2-full-mindmap.png'
$missing += $assets | Where-Object { -not (Test-Path -LiteralPath (Join-Path $PSScriptRoot "..\assets\$_")) }
if ($missing) { throw "N2 map deployment requirements missing: $($missing -join ', ')" }
Write-Output 'N2 map deployment verification passed.'
