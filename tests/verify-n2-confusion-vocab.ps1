$ErrorActionPreference = 'Stop'

$htmlPath = Join-Path $PSScriptRoot '..\index.html'
$html = Get-Content -Raw -Encoding UTF8 $htmlPath
$requiredSnippets = @(
  'data-tab="n2-confusion-vocab"',
  'id="n2-confusion-vocab"',
  'n2-confusion-vocab-table',
  'data-n2-confusion-entry="1"',
  'data-n2-confusion-entry="71"'
)

$missing = $requiredSnippets | Where-Object { -not $html.Contains($_) }
if ($missing) {
  throw "Missing N2 confusion vocabulary content: $($missing -join ', ')"
}

$panel = [regex]::Match($html, '(?s)<div id="n2-confusion-vocab" class="tab-panel">(.*?)</div>\s*<div id="session-review"')
if (-not $panel.Success) {
  throw 'Could not isolate the N2 confusion vocabulary panel.'
}

$rowCount = [regex]::Matches($panel.Groups[1].Value, '<tr(?:\s|>)').Count
if ($rowCount -ne 72) {
  throw "Expected 71 vocabulary rows plus a header, found $rowCount table rows."
}

$entryCount = [regex]::Matches($panel.Groups[1].Value, 'data-n2-confusion-entry="\d+"').Count
if ($entryCount -ne 71) {
  throw "Expected 71 numbered vocabulary entries, found $entryCount."
}

$translationArrow = [string][char]0x2192
$exampleCount = [regex]::Matches($panel.Groups[1].Value, '<br>' + [regex]::Escape($translationArrow) + ' ').Count
if ($exampleCount -ne 71) {
  throw "Expected one translated example for every entry, found $exampleCount."
}

Write-Output 'N2 confusion vocabulary tab verification passed.'
