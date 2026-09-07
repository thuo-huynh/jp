$ErrorActionPreference = 'Stop'

$htmlPath = Join-Path $PSScriptRoot '..\index.html'
$html = Get-Content -Raw $htmlPath
$requiredSnippets = @(
  'data-reading-set="mondai3-onsen"',
  'hiện đã làm 35/55+ bài',
  'data-reading-set="mondai3-kireru"',
  'data-reading-set="mondai3-luck"',
  'data-reading-set="mondai3-shops"',
  'Bài 32 — Suối nước nóng và cách tắm',
  'Bài 33 — 「直ぐに切れる」人',
  'Bài 34 — Nghĩ tích cực về vận may',
  'Bài 35 — Sự thay đổi của các loại cửa hàng',
  '温泉の説明で正しいのはどれか。',
  '著者が問題だと考えていることは何か。',
  '運についての著者の考えはどれか。',
  'どの店がどの店に影響を与えたか。'
)

$missing = $requiredSnippets | Where-Object { -not $html.Contains($_) }
if ($missing) {
  throw "Missing 問題III reading content: $($missing -join ', ')"
}

$questionCount = [regex]::Matches($html, 'data-reading-question="mondai3-(onsen|kireru|luck|shops)-[1-4]"').Count
if ($questionCount -ne 16) {
  throw "Expected 16 問題III questions, found $questionCount"
}

$relocatedReadingCount = [regex]::Matches($html, 'data-reading-set="mondai3-(luck|shops)" data-relocate-to="dokkai"').Count
if ($relocatedReadingCount -ne 2) {
  throw "Expected two 問題III readings to be relocated into dokkai, found $relocatedReadingCount"
}
if (-not $html.Contains('dokkai.appendChild(item)')) {
  throw 'Missing runtime relocation for the 問題III readings'
}

Write-Output '問題III reading-set verification passed.'
