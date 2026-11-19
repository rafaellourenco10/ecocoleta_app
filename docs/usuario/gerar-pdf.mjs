// Gera documentacao-usuario.pdf a partir dos .md e confere links e âncoras.
// Uso: node docs/usuario/gerar-pdf.mjs [--externos]   (precisa de npx e do Microsoft Edge)
import { readFileSync, writeFileSync, readdirSync, existsSync, unlinkSync } from 'node:fs';
import { join, dirname, resolve, relative } from 'node:path';
import { execFileSync } from 'node:child_process';
import { fileURLToPath, pathToFileURL } from 'node:url';

const raiz = dirname(fileURLToPath(import.meta.url));
const ordem = ['README.md',
  ...['guia', 'equipe', 'processo'].flatMap(d => readdirSync(join(raiz, d)).filter(f => f.endsWith('.md')).sort().map(f => `${d}/${f}`))];

// Slug igual ao do GitHub: minúsculas, mantém letras/números (com acento), espaço vira hífen
const slug = t => t.replace(/<[^>]+>|[*`]|\[([^\]]*)\]\([^)]*\)/g, '$1').trim().toLowerCase()
  .replace(/[^\p{L}\p{N}\s_-]/gu, '').replace(/\s/g, '-');
const idArq = f => f.replace(/\.md$/, '').replace(/[^a-z0-9]+/gi, '-');
const semCodigo = md => md.replace(/```[\s\S]*?```/g, '');

const ancoras = Object.fromEntries(ordem.map(f => [f,
  new Set([...semCodigo(readFileSync(join(raiz, f), 'utf8')).matchAll(/^#{1,6} (.+)$/gm)].map(m => slug(m[1])))]));

// 1. Conferência de links
const erros = [], externos = new Set();
for (const f of ordem) {
  const md = semCodigo(readFileSync(join(raiz, f), 'utf8'));
  for (const [, alvo] of md.matchAll(/\]\(([^)\s]+)\)|(?:src|href)="([^"]+)"/g).map(m => [m[0], m[1] ?? m[2]])) {
    if (/^https?:/.test(alvo)) { externos.add(alvo); continue; }
    const [caminho, ancora] = alvo.split('#');
    const destino = caminho ? relative(raiz, resolve(raiz, dirname(f), caminho)).replace(/\\/g, '/') : f;
    if (caminho && !existsSync(join(raiz, destino))) erros.push(`${f}: arquivo inexistente ${alvo}`);
    else if (ancora && destino.endsWith('.md') && !ancoras[destino]?.has(decodeURIComponent(ancora)))
      erros.push(`${f}: âncora inexistente ${alvo}`);
  }
}
if (process.argv.includes('--externos')) {
  for (const url of externos) {
    const r = await fetch(url, { method: 'GET', redirect: 'follow', headers: { Range: 'bytes=0-0' } }).catch(e => ({ status: e.message }));
    if (!(r.status >= 200 && r.status < 400)) erros.push(`externo ${r.status}: ${url}`);
  }
}
console.log(`${ordem.length} páginas, ${externos.size} links externos${process.argv.includes('--externos') ? ' conferidos' : ''}.`);
if (erros.length) { console.error('ERROS:\n' + erros.join('\n')); process.exit(1); }
console.log('Links e âncoras: OK');

// 2. HTML único (marked via npx) com âncoras prefixadas pelo arquivo
const npx = process.platform === 'win32' ? 'npx.cmd' : 'npx';
const secoes = ordem.map(f => {
  let html = execFileSync(npx, ['-y', 'marked@18.1.3', '--gfm', '-i', join(raiz, f)], { encoding: 'utf8', shell: true });
  html = html.replace(/<h([1-6])>([\s\S]*?)<\/h\1>/g, (_, n, t) => `<h${n} id="${idArq(f)}--${slug(t)}">${t}</h${n}>`)
    .replace(/<pre><code class="language-mermaid">([\s\S]*?)<\/code><\/pre>/g, '<pre class="mermaid">$1</pre>')
    .replace(/(href|src)="([^"#:]*)(#[^"]*)?"/g, (m, attr, caminho, ancora = '') => {
      if (!caminho && !ancora) return m;
      const destino = caminho ? relative(raiz, resolve(raiz, dirname(f), caminho)).replace(/\\/g, '/') : f;
      if (attr === 'src' || !destino.endsWith('.md')) return `${attr}="${destino}"`;
      return `href="#${idArq(destino)}${ancora ? '--' + decodeURIComponent(ancora.slice(1)) : ''}"`;
    });
  return `<section id="${idArq(f)}">${html}</section>`;
}).join('\n');

const css = `body{font:11pt/1.5 "Segoe UI",system-ui,sans-serif;color:#1c2a22;max-width:none;margin:0}
section{page-break-before:always}section:first-child{page-break-before:auto}
h1{color:#0f6b37;border-bottom:2px solid #15803d;padding-bottom:4px}h2{color:#15803d;margin-top:1.4em}
table{border-collapse:collapse;width:100%;margin:.6em 0;font-size:9.5pt;page-break-inside:auto}
th,td{border:1px solid #c9d6ce;padding:4px 6px;vertical-align:top;text-align:left}th{background:#e3f5ea}
tr{page-break-inside:avoid}blockquote{border-left:4px solid #15803d;margin:.8em 0;padding:.2em 1em;background:#f3faf5}
pre{background:#f5f7f6;border:1px solid #dfe7e2;padding:8px;font-size:8.5pt;white-space:pre-wrap;page-break-inside:avoid}
code{font-family:Consolas,monospace;font-size:.92em}pre.mermaid{background:none;border:0;text-align:center}
img{max-width:100%}a{color:#0f6b37}@page{margin:18mm 16mm}`;
const htmlArq = join(raiz, 'documentacao-usuario.html');
writeFileSync(htmlArq, `<!doctype html><html lang="pt-BR"><head><meta charset="utf-8"><title>Documentação de usuário do EcoColeta</title>
<style>${css}</style></head><body>${secoes}
<script type="module">import m from 'https://cdn.jsdelivr.net/npm/mermaid@11.4.1/dist/mermaid.esm.min.mjs';
m.initialize({startOnLoad:false,theme:'neutral'});await m.run();document.title+=' ';</script></body></html>`);

// 3. PDF com o Edge headless (o tempo virtual deixa o Mermaid desenhar)
const edge = ['C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe', 'C:/Program Files/Microsoft/Edge/Application/msedge.exe'].find(existsSync);
const pdf = join(raiz, 'documentacao-usuario.pdf');
execFileSync(edge, ['--headless', '--disable-gpu', '--no-pdf-header-footer', '--virtual-time-budget=20000',
  `--print-to-pdf=${pdf}`, pathToFileURL(htmlArq).href], { stdio: 'ignore' });
unlinkSync(htmlArq);
console.log(`PDF gerado: ${pdf}`);
