$ErrorActionPreference = 'Stop'

$htmlPath = Join-Path $PSScriptRoot '..\index.html'
$html = Get-Content -Raw $htmlPath
$requiredSnippets = @(
  'data-tab="mock-roundup"',
  'id="mock-roundup"',
  'data-source-set="n3-jul-2025"',
  'data-source-set="n3-dec-2025"',
  'data-source-set="n2-jul-2025"',
  'data-source-set="n2-dec-2025"',
  'data-source-set="n3-vocab-2026"',
  'mock-source-caveat',
  'mock-vocab-priorities',
  'mock-answer-traps',
  'mock-grammar-priorities',
  'https://passjapanese.com/en/jlpt-full-exam',
  'https://cotoacademy.com/jlpt-n3-vocabulary-mock-test-free-sample-questions/'
)

$missing = $requiredSnippets | Where-Object { -not $html.Contains($_) }
if ($missing) {
  throw "Missing mock roundup content: $($missing -join ', ')"
}

Write-Output 'Mock N3/N2 roundup tab verification passed.'
