$ErrorActionPreference = 'Stop'

$htmlPath = Join-Path $PSScriptRoot '..\index.html'
$html = Get-Content -Raw $htmlPath
$requiredSnippets = @(
  'data-tab="reading-playbook"',
  'id="reading-playbook"',
  'Kỹ năng đọc hiểu N3→N2',
  'Quy trình đọc 3 lượt',
  'Cách ngắt câu để tìm xương sống',
  'Bản đồ đuôi câu',
  'Từ nối thay đổi hướng đọc',
  'Bẫy N2: đáp án đúng một phần',
  'Chiến thuật theo dạng câu hỏi',
  'Checklist 30 giây trước khi chốt đáp án',
  'のではないだろうか',
  '一方で',
  '筆者の考え'
)

$missing = $requiredSnippets | Where-Object { -not $html.Contains($_) }
if ($missing) {
  throw "Missing reading playbook content: $($missing -join ', ')"
}

Write-Output 'Reading playbook tab verification passed.'
