(async () => {
  const grid = document.getElementById("member-grid");
  const count = document.getElementById("member-count");
  try {
    const res = await fetch("members.json", { cache: "no-cache" });
    const members = await res.json();

    count.textContent = members.length;

    const frag = document.createDocumentFragment();
    for (const m of members) {
      const a = document.createElement("a");
      a.className = "member";
      a.href = m.dotfiles || `https://github.com/${m.github}`;
      a.target = "_blank";
      a.rel = "noopener";
      a.title = m.dotfiles ? `${m.github} — dotfiles` : m.github;

      const img = document.createElement("img");
      img.loading = "lazy";
      img.alt = m.github;
      img.src = `https://github.com/${encodeURIComponent(m.github)}.png?size=240`;

      const label = document.createElement("span");
      label.textContent = "@" + m.github;

      a.append(img, label);
      frag.append(a);
    }

    // pad grid so a single member doesn't look lonely
    const ghosts = Math.max(0, 10 - members.length);
    for (let i = 0; i < ghosts; i++) {
      const g = document.createElement("a");
      g.className = "member-ghost";
      g.href = "#join";
      g.textContent = "+";
      g.title = "this could be you";
      frag.append(g);
    }

    grid.replaceChildren(frag);
  } catch (e) {
    grid.textContent = "failed to load members.json: " + e.message;
  }
})();
