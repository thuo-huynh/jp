$ErrorActionPreference = 'Stop'

$htmlPath = Join-Path $PSScriptRoot '..\index.html'
$html = Get-Content -Raw $htmlPath
$requiredSnippets = @(
  'data-tab="counters"',
  'id="counters"',
  'Đếm ngày, tháng & trợ số từ',
  'Tháng 1–12',
  'Ngày trong tháng 1–31',
  '一日（ついたち）',
  '二十日（はつか）',
  '枚（まい）',
  '本（ほん）',
  '缶（かん）',
  '台（だい）',
  '冊（さつ）',
  'Mẹo nhớ theo hình dạng',
  'Biến âm phải thuộc'
)

$missing = $requiredSnippets | Where-Object { -not $html.Contains($_) }
if ($missing) {
  throw "Missing counter-reference content: $($missing -join ', ')"
}

Write-Output 'Counter-reference tab verification passed.'
