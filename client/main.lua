-- Pepper Notify – Client: nimmt Aufrufe entgegen und reicht sie an die NUI weiter
local uiReady = false
local pending = {}

local ALIASES = {
    success = 'success',
    error = 'error',
    info = 'info', inform = 'info', primary = 'info',
    warning = 'warning', warn = 'warning',
}

-- Erlaubt beide Schreibweisen: Notify({ title, message, type, duration }) und Notify(message, type, duration).
-- Versteht auch die Feldnamen von ox_lib (description, type = 'inform') und QBCore (text, length, 'primary').
local function normalize(a, b, c)
    local data = type(a) == 'table' and a or { message = a, type = b, duration = c }
    local message = data.message or data.description or data.text
    if message == nil or message == '' then return nil end

    local duration = tonumber(data.duration or data.length) or Config.DefaultDuration
    duration = math.max(Config.MinDuration, math.min(Config.MaxDuration, math.floor(duration)))

    return {
        id = data.id and tostring(data.id) or nil,
        title = data.title and tostring(data.title) or nil,
        message = tostring(message),
        type = ALIASES[tostring(data.type or 'info'):lower()] or 'info',
        duration = duration,
    }
end

local function playSound(ntype)
    if not Config.Sound.enabled then return end
    local sound = Config.Sound[ntype] or Config.Sound.default
    if sound then PlaySoundFrontend(-1, sound.name, sound.set, true) end
end

local function show(a, b, c)
    local data = normalize(a, b, c)
    if not data then return end
    if not uiReady then
        pending[#pending + 1] = data
        return
    end
    playSound(data.type)
    SendNUIMessage({ action = 'notify', data = data })
end

exports('Notify', show)

RegisterNetEvent('pepper_notify:show', function(a, b, c)
    show(a, b, c)
end)

-- Die NUI meldet sich, sobald sie geladen ist, und bekommt die Einstellungen zurück.
RegisterNUICallback('ready', function(_, cb)
    cb({
        position = Config.Position,
        maxVisible = Config.MaxVisible,
        progressBar = Config.ProgressBar,
        colors = Config.Colors,
    })
    uiReady = true
    for i = 1, #pending do
        playSound(pending[i].type)
        SendNUIMessage({ action = 'notify', data = pending[i] })
    end
    pending = {}
end)

if Config.TestCommand then
    RegisterCommand('notifytest', function()
        show({ title = 'Pepper Notify', message = 'Saved successfully.', type = 'success' })
        show({ title = 'Pepper Notify', message = 'Something went wrong.', type = 'error' })
        show({ message = 'A message without a title.', type = 'info' })
        show({ title = 'Pepper Notify', message = 'Your vehicle is low on fuel.', type = 'warning', duration = 8000 })
    end, false)
end
