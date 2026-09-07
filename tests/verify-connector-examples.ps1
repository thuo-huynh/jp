$ErrorActionPreference = 'Stop'

$htmlPath = Join-Path $PSScriptRoot '..\index.html'
$html = Get-Content -Raw $htmlPath
$requiredSnippets = @(
  'connector-table-wrap',
  'connector-example',
  'connector-example-ja',
  'connector-example-vn',
  'connector-table'
)

$missing = $requiredSnippets | Where-Object { -not $html.Contains($_) }
if ($missing) {
  throw "Missing connector example presentation: $($missing -join ', ')"
}

$exampleCount = [regex]::Matches($html, 'class="connector-example"').Count
if ($exampleCount -ne 32) {
  throw "Expected 32 connector examples, found $exampleCount"
}

Write-Output 'Connector examples verification passed.'
