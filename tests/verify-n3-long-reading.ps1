$ErrorActionPreference = 'Stop'

$htmlPath = Join-Path $PSScriptRoot '..\index.html'
$html = Get-Content -Raw $htmlPath
$requiredSnippets = @(
  'data-reading-set="kotodama"',
  'Bài đọc dài — 言霊（ことだま）',
  '問1　どうして日本の病院には４号室がないのか。',
  '問2　どうして試合の前に「トンカツ」を食べるのか。',
  '問3　どうして今でも言葉を変えて使うのか。',
  '問4　本文の内容と合っているのはどれか。',
  '聞き手の気分を悪くしないため',
  'Bẫy đọc hiểu'
)

$missing = $requiredSnippets | Where-Object { -not $html.Contains($_) }
if ($missing) {
  throw "Missing N3 long-reading content: $($missing -join ', ')"
}

$questionCount = [regex]::Matches($html, 'data-reading-question="kotodama-[1-4]"').Count
if ($questionCount -ne 4) {
  throw "Expected four Kotodama questions, found $questionCount"
}

Write-Output 'N3 long-reading verification passed.'
