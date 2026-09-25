$ErrorActionPreference = 'Stop'

$htmlPath = Join-Path $PSScriptRoot '..\index.html'
$html = Get-Content -Raw -Encoding UTF8 $htmlPath
$requiredSnippets = @(
  'data-tab="jlpt-105-grammar"',
  'id="jlpt-105-grammar"',
  'jlpt105-search-input',
  'jlpt105-count-label',
  'data-jlpt105-entry="1"',
  'data-jlpt105-entry="105"',
  '～たばかりだ',
  '～わけではない',
  '～に相違ない',
  '～ついでに'
)

$missing = $requiredSnippets | Where-Object { -not $html.Contains($_) }
if ($missing) {
  throw "Missing JLPT 105 grammar content: $($missing -join ', ')"
}

$panel = [regex]::Match($html, '(?s)<div id="jlpt-105-grammar" class="tab-panel">(.*?)</div>\s*<div id="mock-roundup"')
if (-not $panel.Success) {
  throw 'Could not isolate the JLPT 105 grammar panel.'
}

$entries = [regex]::Matches($panel.Groups[1].Value, 'data-jlpt105-entry="(\d+)"')
if ($entries.Count -ne 105) {
  throw "Expected 105 grammar entries, found $($entries.Count)."
}

$entryNumbers = @($entries | ForEach-Object { [int]$_.Groups[1].Value } | Sort-Object -Unique)
if ($entryNumbers.Count -ne 105 -or ($entryNumbers -join ',') -ne ((1..105) -join ',')) {
  throw 'Grammar entries must be uniquely numbered from 1 through 105.'
}

Write-Output 'JLPT 105 grammar tab verification passed.'
