$ErrorActionPreference = 'Stop'

$htmlPath = Join-Path $PSScriptRoot '..\index.html'
$html = Get-Content -Raw $htmlPath
$requiredSnippets = @(
  'data-tab="listening-playbook"',
  'id="listening-playbook"',
  'listening-before-audio',
  'listening-one-pass',
  'listening-question-types',
  'listening-n3-n2',
  'listening-traps',
  'listening-review-loop',
  'でも・けど・やっぱり・それなら',
  'data-method="3-luot-nghe"',
  'action-next',
  'intent-final'
)

$missing = $requiredSnippets | Where-Object { -not $html.Contains($_) }
if ($missing) {
  throw "Missing listening playbook content: $($missing -join ', ')"
}

Write-Output 'Listening playbook tab verification passed.'
