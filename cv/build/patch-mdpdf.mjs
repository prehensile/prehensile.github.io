// mdpdf's HTML layout has no charset declaration, so Chrome loads the temp
// file:// document as windows-1252 and every non-ASCII character (— → ö …)
// comes out mojibaked in the PDF and HTML. Upstream bug; patch it on install.
import { readdirSync, readFileSync, writeFileSync, statSync } from 'fs';
import { join } from 'path';

const META = '<meta charset="utf-8">';
const root = 'node_modules/mdpdf';

function* templates(dir) {
    for (const entry of readdirSync(dir)) {
        const path = join(dir, entry);
        if (statSync(path).isDirectory()) yield* templates(path);
        else if (entry === 'doc-body.hbs') yield path;
    }
}

let patched = 0;
for (const path of templates(root)) {
    const html = readFileSync(path, 'utf8');
    if (html.includes(META)) continue;
    if (!html.includes('<head>')) {
        throw new Error(`patch-mdpdf: no <head> in ${path} — mdpdf layout changed`);
    }
    writeFileSync(path, html.replace('<head>', `<head>\n        ${META}`));
    patched++;
}

if (patched) console.log(`patch-mdpdf: added charset to ${patched} template(s)`);
