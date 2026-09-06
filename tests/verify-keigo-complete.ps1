$ErrorActionPreference = 'Stop'

$htmlPath = Join-Path $PSScriptRoot '..\index.html'
$html = Get-Content -Raw $htmlPath
$requiredSnippets = @(
  'Kính ngữ toàn diện',
  'Bản đồ chọn kính ngữ',
  '謙譲語I',
  '謙譲語II（丁重語）',
  '美化語',
  'Động từ đặc biệt cần thuộc',
  'Điện thoại &amp; tiếp khách',
  'Lỗi kép kính ngữ',
  'ご覧になられます',
  'おいでになる',
  '拝読する',
  '申しかねます',
  'Đúng / sai kiểu đề N2'
)

$missing = $requiredSnippets | Where-Object { -not $html.Contains($_) }
if ($missing) {
  throw "Missing complete keigo content: $($missing -join ', ')"
}

Write-Output 'Complete keigo tab verification passed.'
