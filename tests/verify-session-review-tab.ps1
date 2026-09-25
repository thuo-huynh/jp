$ErrorActionPreference = 'Stop'

$htmlPath = Join-Path $PSScriptRoot '..\index.html'
$html = Get-Content -Raw $htmlPath
$requiredSnippets = @(
  'data-tab="session-review"',
  'id="session-review"',
  'session-review-pronunciation',
  'session-review-grammar',
  'session-review-requests',
  'session-review-vocabulary',
  'session-review-visit'
)

$missing = $requiredSnippets | Where-Object { -not $html.Contains($_) }
if ($missing) {
  throw "Missing session review content: $($missing -join ', ')"
}

Write-Output 'Session review tab verification passed.'
