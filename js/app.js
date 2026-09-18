(function () {
  const STORAGE_KEY = "pm-lang";
  const defaultLang = (() => {
    const saved = localStorage.getItem(STORAGE_KEY);
    if (saved && I18N[saved]) return saved;
    const nav = (navigator.language || "en").toLowerCase();
    return nav.startsWith("fr") ? "fr" : "en";
  })();

  const FLAG_UK = `<svg viewBox="0 0 60 30" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><clipPath id="t"><path d="M0,0 v30 h60 v-30 z"/></clipPath><path d="M0,0 v30 h60 v-30 z" fill="#012169"/><path d="M0,0 L60,30 M60,0 L0,30" stroke="#fff" stroke-width="6" clip-path="url(#t)"/><path d="M0,0 L60,30 M60,0 L0,30" stroke="#C8102E" stroke-width="4" clip-path="url(#t)"/><path d="M30,0 v30 M0,15 h60" stroke="#fff" stroke-width="10"/><path d="M30,0 v30 M0,15 h60" stroke="#C8102E" stroke-width="6"/></svg>`;
  const FLAG_FR = `<svg viewBox="0 0 3 2" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><rect width="1" height="2" fill="#002395"/><rect x="1" width="1" height="2" fill="#fff"/><rect x="2" width="1" height="2" fill="#ED2939"/></svg>`;

  function apply(lang) {
    const dict = I18N[lang] || I18N.en;
    document.documentElement.lang = lang === "fr" ? "fr" : "en";
    document.title = dict.metaTitle;
    const meta = document.querySelector('meta[name="description"]');
    if (meta) meta.setAttribute("content", dict.metaDescription);
    const ogt = document.querySelector('meta[property="og:title"]');
    const ogd = document.querySelector('meta[property="og:description"]');
    if (ogt) ogt.setAttribute("content", dict.metaTitle);
    if (ogd) ogd.setAttribute("content", dict.metaDescription);

    document.querySelectorAll("[data-i18n]").forEach((el) => {
      const key = el.getAttribute("data-i18n");
      if (dict[key] != null) el.textContent = dict[key];
    });

    document.querySelectorAll(".lang-switch button").forEach((btn) => {
      btn.setAttribute("aria-pressed", btn.dataset.lang === lang ? "true" : "false");
    });

    localStorage.setItem(STORAGE_KEY, lang);
  }

  function initFlags() {
    const en = document.querySelector('.lang-switch button[data-lang="en"] .flag');
    const fr = document.querySelector('.lang-switch button[data-lang="fr"] .flag');
    if (en) en.innerHTML = FLAG_UK;
    if (fr) fr.innerHTML = FLAG_FR;
  }

  document.addEventListener("click", (e) => {
    const btn = e.target.closest(".lang-switch button");
    if (btn) apply(btn.dataset.lang);
    const menu = e.target.closest(".menu-btn");
    if (menu) {
      document.querySelector(".mobile-panel").classList.toggle("open");
      menu.setAttribute(
        "aria-expanded",
        document.querySelector(".mobile-panel").classList.contains("open") ? "true" : "false"
      );
    }
    if (e.target.closest(".mobile-panel a")) {
      document.querySelector(".mobile-panel").classList.remove("open");
    }
  });

  const sections = ["about", "experience", "work", "skills", "contact"];
  const spy = () => {
    const fromTop = window.scrollY + 96;
    let current = sections[0];
    sections.forEach((id) => {
      const el = document.getElementById(id);
      if (el && el.offsetTop <= fromTop) current = id;
    });
    document.querySelectorAll(".nav-links a").forEach((a) => {
      a.classList.toggle("active", a.getAttribute("href") === "#" + current);
    });
  };
  window.addEventListener("scroll", spy, { passive: true });

  initFlags();
  apply(defaultLang);
  spy();
})();
