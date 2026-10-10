-- Pepper Notify – Benachrichtigungen im Pepper-Design (Standalone, kostenlos)
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'pepper_notify'
author 'Pepper Scripts'
description 'Clean notifications with exports for client and server – standalone'
version '1.0.1'
repository 'https://github.com/PepperScripts/pepper_notify'

shared_script 'config.lua'
client_script 'client/main.lua'
server_script 'server/main.lua'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/app.js',
}
