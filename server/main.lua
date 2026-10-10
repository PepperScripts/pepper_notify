-- Pepper Notify – Server: Export, um Spielern vom Server aus eine Meldung zu schicken
-- exports.pepper_notify:Notify(source, { title = 'Bank', message = 'Paid $500', type = 'success' })
-- exports.pepper_notify:Notify(source, 'Paid $500', 'success', 5000)
-- target = -1 schickt die Meldung an alle Spieler.
exports('Notify', function(target, a, b, c)
    target = tonumber(target)
    if not target then return end
    TriggerClientEvent('pepper_notify:show', target, a, b, c)
end)
