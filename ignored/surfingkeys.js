const {
  map,
  unmap,
  iunmap,
  mapkey,
  removeSearchAlias,
  addSearchAlias,
  vmapkey,
  Hints,
  RUNTIME,
  Normal,
  Visual
} = api;

// Vimium/cVim
map('u', 'e');

unmap('p');
mapkey('p', "Open the clipboard's URL in the current tab", function () {
  Front.getContentFromClipboard(function (response) {
    window.location.href = response.data;
  });
});
map('P', 'cc');
map('gi', 'i');
map('_F', 'F');
map('_C', 'C');
map('F', '_C');
map('C', '_F');
map('gf', 'w');
map('`', '\'');
map('_H', 'H');
map('_S', 'S');
map('_D', 'D');
map('_L', 'L');
map('H', '_S');
map('S', '_H')
map('D', '_L');
map('L', '_D');
map('gt', 'R');
map('gT', 'E');
map('K', 'R');
map('J', 'E');

// Unmap temporary keys
unmap('_F');
unmap('_C');
unmap('_S');
unmap('_H');
unmap('_D');
unmap('_L');

// Unmap emoji input
iunmap(':');

// settings.hintAlign = "left"

//Add shift-toggle for background hints
settings.hintShiftNonActive = true;

// Smart Page Boundary
settings.smartPageBoundary = true;

// Search aliases
removeSearchAlias('b', 's') // Get rid of baidu
removeSearchAlias('w', 's') // Get rid of bing
removeSearchAlias('g', 's') // Get rid of Google, I use kagi

// Wikipedia search alias
addSearchAlias(
  'w', // Alias
  'wikipedia', // Prompt
  'https://en.wikipedia.org/w/index.php?title=Special:Search&search=', // search url
  's', // leader key
  'https://en.wikipedia.org/w/api.php?action=opensearch&format=json&formatversion=2&namespace=0&limit=20&suggest=true&search=', // suggestion url
  (response) => JSON.parse(response.text)[1] // Response parser
);

addSearchAlias(
  'g',
  'kagi',
  'https://kagi.com/search?q=',
  's',
  "https://kagi.com/api/autosuggest?q=",
  (response) => JSON.parse(response.text)[1]
);

addSearchAlias('G', 'google', 'https://www.google.com/search?q=', 's', 'https://www.google.com/complete/search?client=chrome-omni&gs_ri=chrome-ext&oit=1&cp=1&pgcl=7&q=', (response) => JSON.parse(response.text)[1]);

// Change open detected URL to new tab
unmap("O");
mapkey('O', '#1Open detected links from text', function () {
  Hints.create(runtime.conf.clickablePat, function (element) {
    window.open(element[2]);
  }, { statusLine: "Open detected links from text" });
});

// Improve default remove query/fragment
mapkey('g?', '#4Reload current page without query', function () {
  window.location.href = window.location.href.replace(/\?[^?#]*/, '');
});
mapkey('g#', '#4Reload current page without hash fragment', function () {
  window.location.href = window.location.href.replace(/\#[^#]*/, '');
});
mapkey('gB', '#4Reload current page without query or hash fragment', function () {
  window.location.href = window.location.href.replace(/[#?].*/, '');
});

// Add copy without query/fragment
mapkey('y?', "#7Copy current page's URL without query", function () {
  Clipboard.write(window.location.href.replace(/\?[^?#]*/, ''))
});
mapkey('y#', "#7Copy current page's URL without hash fragment", function () {
  Clipboard.write(window.location.href.replace(/#[^#]*/, ''))
});
mapkey('yb', "#7Copy current page's URL without query or hash fragment", function () {
  Clipboard.write(window.location.href.replace(/[#?].*$/, ''))
});

// Base64 stuff
vmapkey("dy", "#9Base64 decode and copy selection", function () {
  const text = window.getSelection().toString()
  Clipboard.write(atob(text))
  Visual.toggle();
});

vmapkey("do", "#9Base64 decode selection and open as URL", function () {
  const text = window.getSelection().toString()
  window.open(atob(text));
  Visual.toggle()
});

// Passthrough key
mapkey('p', '#0enter ephemeral PassThrough mode to temporarily suppress SurfingKeys', function () {
  Normal.passThrough(1500);
});

// Copy image url key
mapkey(';yi', "#7Copy image URL", function () {
  Hints.create('img', function (element) {
    Clipboard.write(element.src);
  });
});

// Download url
mapkey(';df', "#1Download link", function () {
  Hints.create("*[href]", function (element) {
    RUNTIME('download', { url: element.href })
  })
});

mapkey(';dm', "#1Download multiple links", function () {
  Hints.create("*[href]", function (element) {
    RUNTIME('download', { url: element.href })
  }, { multipleHits: true })
});

mapkey('sx', "#6Open current page in kagi summary page in a new tab", function () {
  window.open(`https://kagi.com/summarizer/index.html?target_language=&summary=takeaway&url=${window.location.href}`)
});
mapkey('sX', "#6Open selected hint with Kagi summarizer", function () {
  Hints.create("*[href]", function (element) {
    window.open(`https://kagi.com/summarizer/index.html?target_language=&summary=takeaway&url=${element.href}`)
  });
});

// Bottom-style omnibar
settings.omnibarPosition = 'bottom';

// Neovim hasn't ever worked for me, because it whines about websocket
// security. I use firenvim for large inputs anyways, which seems to have
// better performance, so this is mostly about editing single line inputs and
// multiselects
settings.useNeovim = false;

settings.newTabPosition = "last";

// Tomorrow night style hints
Hints.style('font-family: system-ui;');
Hints.style("font-family: system-ui;", "text");

// set theme
settings.theme = `
/* Edit these variables for easy theme making */
:root {
  /* Font */
  --font: system-ui;
  --font-size: 12;
  --font-weight: bold;

  --fg: #C5C8C6;
  --bg: #282A2E;
  --bg-dark: #1D1F21;
  --border: #373b41;
  --main-fg: #52C196;
  --accent-fg: #81A2BE;
  --info-fg: #AC7BBA;
  --select: #585858;

  /* Unused Alternate Colors */
  /* --cyan: #4CB3BC; */
  /* --orange: #DE935F; */
  /* --red: #CC6666; */
  /* --yellow: #CBCA77; */
}
/* ---------- Generic ---------- */
.sk_theme {
background: var(--bg);
color: var(--fg);
  background-color: var(--bg);
  border-color: var(--border);
  font-family: var(--font);
  font-size: var(--font-size);
  font-weight: var(--font-weight);
}
input {
  font-family: var(--font);
  font-weight: var(--font-weight);
}
.sk_theme tbody {
  color: var(--fg);
}
.sk_theme input {
  color: var(--fg);
}
/* Hints */
#sk_hints .begin {
  color: var(--accent-fg) !important;
}
#sk_tabs .sk_tab {
  background: var(--bg-dark);
  border: 1px solid var(--border);
  color: var(--fg);
}
#sk_tabs .sk_tab_title {
  color: var(--fg);
}
#sk_tabs .sk_tab_url {
  color: var(--accent-fg);
}
#sk_tabs .sk_tab_hint {
  background: var(--bg);
  border: 1px solid var(--border);
  color: var(--accent-fg);
}
.sk_theme #sk_frame {
  background: var(--bg);
  opacity: 0.2;
  color: var(--accent-fg);
}
/* ---------- Omnibar ---------- */
/* Uncomment this and use settings.omnibarPosition = 'bottom' for Pentadactyl/Tridactyl style bottom bar */
.sk_theme#sk_omnibar {
  width: 100%;
  left: 0;
}
.sk_theme .title {
  color: var(--accent-fg);
}
.sk_theme .url {
  color: var(--main-fg);
}
.sk_theme .annotation {
  color: var(--accent-fg);
}
.sk_theme .omnibar_highlight {
  color: var(--accent-fg);
}
.sk_theme .omnibar_timestamp {
  color: var(--info-fg);
}
.sk_theme .omnibar_visitcount {
  color: var(--accent-fg);
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
  background: var(--bg-dark);
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
  background: var(--border);
}
.sk_theme #sk_omnibarSearchArea {
  border-top-color: var(--border);
  border-bottom-color: var(--border);
}
.sk_theme #sk_omnibarSearchArea input,
.sk_theme #sk_omnibarSearchArea span {
  font-size: var(--font-size);
}
.sk_theme .separator {
  color: var(--accent-fg);
}
/* ---------- Popup Notification Banner ---------- */
#sk_banner {
  font-family: var(--font);
  font-size: var(--font-size);
  font-weight: var(--font-weight);
  background: var(--bg);
  border-color: var(--border);
  color: var(--fg);
  opacity: 0.9;
}
/* ---------- Popup Keys ---------- */
#sk_keystroke {
  background-color: var(--bg);
}
.sk_theme kbd .candidates {
  color: var(--info-fg);
}
.sk_theme span.annotation {
  color: var(--accent-fg);
}
/* ---------- Popup Translation Bubble ---------- */
#sk_bubble {
  background-color: var(--bg) !important;
  color: var(--fg) !important;
  border-color: var(--border) !important;
}
#sk_bubble * {
  color: var(--fg) !important;
}
#sk_bubble div.sk_arrow div:nth-of-type(1) {
  border-top-color: var(--border) !important;
  border-bottom-color: var(--border) !important;
}
#sk_bubble div.sk_arrow div:nth-of-type(2) {
  border-top-color: var(--bg) !important;
  border-bottom-color: var(--bg) !important;
}
/* ---------- Search ---------- */
#sk_status,
#sk_find {
  font-size: var(--font-size);
  border-color: var(--border);
}
.sk_theme kbd {
  background: var(--bg-dark);
  border-color: var(--border);
  box-shadow: none;
  color: var(--fg);
}
.sk_theme .feature_name span {
  color: var(--main-fg);
}
/* ---------- ACE Editor ---------- */
#sk_editor {
  background: var(--bg-dark) !important;
  height: 50% !important;
  /* Remove this to restore the default editor size */
}
.ace_dialog-bottom {
  border-top: 1px solid var(--bg) !important;
}
.ace-chrome .ace_print-margin,
.ace_gutter,
.ace_gutter-cell,
.ace_dialog {
  background: var(--bg) !important;
}
.ace-chrome {
  color: var(--fg) !important;
}
.ace_gutter,
.ace_dialog {
  color: var(--fg) !important;
}
.ace_cursor {
  color: var(--fg) !important;
}
.normal-mode .ace_cursor {
  background-color: var(--fg) !important;
  border: var(--fg) !important;
  opacity: 0.7 !important;
}
.ace_marker-layer .ace_selection {
  background: var(--select) !important;
}
`;
