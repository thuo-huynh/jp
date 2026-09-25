const fs = require('fs');
const path = require('path');

const htmlPath = path.join(__dirname, '..', 'index.html');
const source = fs.readFileSync(htmlPath, 'utf8');
const script = source.match(/<script>([\s\S]*?)<\/script>/)?.[1];

if (!script) throw new Error('Không tìm thấy JavaScript của sổ tay.');
new Function(script);
console.log('Notebook JavaScript syntax verification passed.');
