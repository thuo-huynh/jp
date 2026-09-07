$ErrorActionPreference = 'Stop'

$htmlPath = Join-Path $PSScriptRoot '..\index.html'
$html = Get-Content -Raw $htmlPath
$requiredSnippets = @(
  'connector-map-complete',
  'connector-vietnamese-meanings',
  'data-connector-theme="addition"',
  'data-connector-theme="cause-result"',
  'data-connector-theme="reason-explanation"',
  'data-connector-theme="contrast"',
  'data-connector-theme="concession"',
  'data-connector-theme="summary"',
  'data-connector-theme="example"',
  'data-connector-theme="sequence"',
  'data-connector-theme="condition-exception"',
  'data-connector-theme="choice"',
  'data-connector-theme="correction"',
  'nguyen-nhan-ket-qua',
  'doc-ve-sau'
)

$missing = $requiredSnippets | Where-Object { -not $html.Contains($_) }
if ($missing) {
  throw "Missing reading connector map content: $($missing -join ', ')"
}

Write-Output 'Reading connector map verification passed.'
