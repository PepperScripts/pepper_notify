Config = {}

-- Position auf dem Bildschirm · Position on screen:
-- 'top-right' | 'top-left' | 'top-center' | 'bottom-right' | 'bottom-left' | 'bottom-center'
Config.Position = 'top-center'

-- Standarddauer in Millisekunden, wenn der Aufruf keine nennt · Default duration in milliseconds
Config.DefaultDuration = 5000
Config.MinDuration = 1000
Config.MaxDuration = 30000

-- Wie viele Meldungen gleichzeitig sichtbar sind (ältere verschwinden zuerst) · Max visible at once
Config.MaxVisible = 5

-- Zeitbalken unter der Meldung · Timer bar below the notification
Config.ProgressBar = true

-- Ton beim Einblenden (GTA-eigene Sounds, keine Audiodateien) · Sound on show (native GTA sounds)
Config.Sound = {
    enabled = true,
    default = { name = 'SELECT', set = 'HUD_FRONTEND_DEFAULT_SOUNDSET' },
    error   = { name = 'ERROR',  set = 'HUD_FRONTEND_DEFAULT_SOUNDSET' },
}

-- Farben je Typ · Colours per type
Config.Colors = {
    success = '#3DD68C',
    error   = '#E5484D',
    info    = '#4C9AFF',
    warning = '#FF8A3D',
}

-- /notifytest zeigt alle vier Typen (zum Ausprobieren, danach gern auf false)
-- /notifytest shows all four types (for trying it out, set to false afterwards)
Config.TestCommand = true
