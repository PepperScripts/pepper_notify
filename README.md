# Pepper Notify

Free notification system for FiveM · Standalone (works with ESX, QBCore, Qbox or no framework at all)

**Pepper Scripts** · More scripts: https://pepper-scripts.tebex.store · Support: https://discord.gg/6NaFJWKDYu

---

## 🇬🇧 English

### Features
- Four types: `success`, `error`, `info`, `warning`, each with its own colour and icon
- Optional title, timer bar and sound (native GTA sounds, no audio files)
- Six screen positions, colours and durations set in `config.lua`
- Exports for client and server, plus a client event
- Accepts the field names of ox_lib (`description`, `type = 'inform'`) and QBCore (`text`, `length`, `'primary'`)
- Same `id` replaces a notification instead of stacking it
- No dependencies, no loop running in the background

### Installation
1. Put the `pepper_notify` folder into your `resources` folder.
2. Add to your `server.cfg`:
   ```
   ensure pepper_notify
   ```
3. Restart the server and type `/notifytest` in game.

### Usage
Client:
```lua
exports.pepper_notify:Notify({ title = 'Garage', message = 'Vehicle parked.', type = 'success', duration = 5000 })
exports.pepper_notify:Notify('Vehicle parked.', 'success', 5000)
```
Server:
```lua
exports.pepper_notify:Notify(source, { title = 'Bank', message = 'You received $500.', type = 'info' })
exports.pepper_notify:Notify(-1, 'Server restart in 10 minutes.', 'warning', 10000) -- everyone
```
Event (from the server): `TriggerClientEvent('pepper_notify:show', source, { message = 'Hello', type = 'info' })`

| Field | Meaning |
|---|---|
| `message` | Text (required) |
| `title` | Bold first line (optional) |
| `type` | `success`, `error`, `info` or `warning` (default `info`) |
| `duration` | Milliseconds (default from `config.lua`) |
| `id` | A notification with the same `id` is replaced |

### Use it for your framework's notifications
- **ESX:** in `es_extended/client/functions.lua`, let `ESX.ShowNotification` call
  `exports.pepper_notify:Notify(message, notifyType, length)`.
- **QBCore / Qbox:** in `qb-core/client/functions.lua`, let `QBCore.Functions.Notify` call
  `exports.pepper_notify:Notify(text, texttype, length)`.

### Settings (`config.lua`)
| Option | Meaning |
|---|---|
| `Config.Position` | `top-right`, `top-left`, `top-center`, `bottom-right`, `bottom-left`, `bottom-center` |
| `Config.DefaultDuration` / `MinDuration` / `MaxDuration` | Durations in milliseconds |
| `Config.MaxVisible` | How many notifications are visible at once |
| `Config.ProgressBar` | Timer bar on/off |
| `Config.Sound` | Sound on/off and which GTA sound plays |
| `Config.Colors` | Colour per type |
| `Config.TestCommand` | `/notifytest` on/off |

---

## 🇩🇪 Deutsch

### Features
- Vier Typen: `success`, `error`, `info`, `warning` – jeder mit eigener Farbe und eigenem Symbol
- Optionaler Titel, Zeitbalken und Ton (GTA-eigene Sounds, keine Audiodateien)
- Sechs Positionen, Farben und Dauer in der `config.lua`
- Exports für Client und Server, dazu ein Client-Event
- Versteht die Feldnamen von ox_lib (`description`, `type = 'inform'`) und QBCore (`text`, `length`, `'primary'`)
- Gleiche `id` ersetzt eine Meldung, statt sie zu stapeln
- Keine Abhängigkeiten, keine Schleife im Hintergrund

### Installation
1. Ordner `pepper_notify` in deinen `resources`-Ordner legen.
2. In der `server.cfg` eintragen:
   ```
   ensure pepper_notify
   ```
3. Server neu starten und im Spiel `/notifytest` eingeben.

### Benutzung
Die Aufrufe stehen oben im englischen Teil unter „Usage“. Kurz:
`exports.pepper_notify:Notify({ title = 'Garage', message = 'Fahrzeug geparkt.', type = 'success' })` auf dem Client,
`exports.pepper_notify:Notify(source, 'Du hast 500 $ erhalten.', 'info')` auf dem Server (`-1` = alle Spieler).

### Für die Meldungen deines Frameworks nutzen
- **ESX:** in `es_extended/client/functions.lua` in `ESX.ShowNotification` den Export aufrufen.
- **QBCore / Qbox:** in `qb-core/client/functions.lua` in `QBCore.Functions.Notify` den Export aufrufen.

---

MIT License · Pepper Scripts is not affiliated with Rockstar Games, Take-Two Interactive or Cfx.re.
