// Pepper Notify – NUI: baut die Meldungen auf und blendet sie nach Ablauf aus
(() => {
    const stack = document.getElementById('stack');
    const POSITIONS = ['top-right', 'top-left', 'top-center', 'bottom-right', 'bottom-left', 'bottom-center'];
    const ICONS = {
        success: '<path d="M20 6 9 17l-5-5"/>',
        error: '<circle cx="12" cy="12" r="9"/><path d="m15 9-6 6M9 9l6 6"/>',
        info: '<circle cx="12" cy="12" r="9"/><path d="M12 11v5M12 8h.01"/>',
        warning: '<path d="M12 3 2 20h20L12 3z"/><path d="M12 10v4M12 17h.01"/>',
    };
    const settings = {
        maxVisible: 5,
        progressBar: true,
        colors: { success: '#3DD68C', error: '#E5484D', info: '#4C9AFF', warning: '#FF8A3D' },
    };
    const timers = new Map();

    function remove(el) {
        if (!el || el.classList.contains('leaving')) return;
        clearTimeout(timers.get(el));
        timers.delete(el);
        el.classList.add('leaving');
        el.addEventListener('animationend', () => el.remove(), { once: true });
        setTimeout(() => el.remove(), 400); // Sicherheitsnetz, falls die Animation nicht läuft
    }

    function build(data) {
        const el = document.createElement('div');
        el.className = 'note';
        el.style.setProperty('--accent', settings.colors[data.type] || settings.colors.info);
        if (data.id) el.dataset.id = data.id;

        const icon = document.createElement('div');
        icon.className = 'note-icon';
        icon.innerHTML = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" ' +
            'stroke-linecap="round" stroke-linejoin="round">' + (ICONS[data.type] || ICONS.info) + '</svg>';
        el.appendChild(icon);

        const body = document.createElement('div');
        body.className = 'note-body';
        if (data.title) {
            const title = document.createElement('div');
            title.className = 'note-title';
            title.textContent = data.title; // textContent: Spielertexte werden nie als HTML ausgeführt
            body.appendChild(title);
        }
        const message = document.createElement('div');
        message.className = 'note-message';
        message.textContent = data.message;
        body.appendChild(message);
        el.appendChild(body);

        if (settings.progressBar) {
            const bar = document.createElement('div');
            bar.className = 'note-bar';
            bar.style.animationDuration = data.duration + 'ms';
            el.appendChild(bar);
        }
        return el;
    }

    function notify(data) {
        if (!data || !data.message) return;

        // Gleiche id = vorhandene Meldung ersetzen statt stapeln
        if (data.id) {
            for (const old of [...stack.children]) {
                if (old.dataset.id === data.id && !old.classList.contains('leaving')) {
                    clearTimeout(timers.get(old));
                    timers.delete(old);
                    old.remove();
                }
            }
        }

        const el = build(data);
        stack.appendChild(el);
        timers.set(el, setTimeout(() => remove(el), data.duration));

        const visible = [...stack.children].filter((n) => !n.classList.contains('leaving'));
        for (let i = 0; i < visible.length - settings.maxVisible; i++) remove(visible[i]);
    }

    window.addEventListener('message', (event) => {
        const msg = event.data || {};
        if (msg.action === 'notify') notify(msg.data);
    });

    // Im Browser (ohne FiveM) gibt es GetParentResourceName nicht – dann bleiben die Standardwerte.
    const resource = typeof GetParentResourceName === 'function' ? GetParentResourceName() : null;
    if (resource) {
        fetch(`https://${resource}/ready`, { method: 'POST', body: '{}' })
            .then((res) => res.json())
            .then((cfg) => {
                if (POSITIONS.includes(cfg.position)) stack.className = 'stack ' + cfg.position;
                if (Number(cfg.maxVisible) > 0) settings.maxVisible = Number(cfg.maxVisible);
                settings.progressBar = cfg.progressBar !== false;
                Object.assign(settings.colors, cfg.colors || {});
            })
            .catch(() => {});
    }
})();
