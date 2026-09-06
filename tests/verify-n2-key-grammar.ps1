$ErrorActionPreference = 'Stop'

$htmlPath = Join-Path $PSScriptRoot '..\index.html'
$html = Get-Content -Raw $htmlPath
$requiredSnippets = @(
  'data-tab="n2-key-grammar"',
  'id="n2-key-grammar"',
  'N2 trọng điểm thi',
  'Ưu tiên A',
  'Suy đoán &amp; kết luận',
  'Lý do, nghĩa vụ &amp; giới hạn',
  'Phủ định, đối lập &amp; nhượng bộ',
  'Thời điểm &amp; diễn tiến',
  'Kết quả, lựa chọn &amp; khả năng',
  'Quan hệ, phạm vi &amp; tiêu chuẩn',
  'Cặp dễ bị gài trong đề',
  '～ざるを得ない',
  '～わけにはいかない',
  '～に違いない',
  '～にもかかわらず',
  '～たびに',
  '～に応じて'
)

$missing = $requiredSnippets | Where-Object { -not $html.Contains($_) }
if ($missing) {
  throw "Missing N2 key-grammar content: $($missing -join ', ')"
}

Write-Output 'N2 key grammar tab verification passed.'
