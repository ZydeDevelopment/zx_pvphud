fx_version 'cerulean'
game 'gta5'

author 'EDZINK'
description 'PVP HUD for FiveM - ESX & QB-Core Compatible'
version '1.0.0'

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

dependencies {
    'ox_lib'
}

lua54 'yes'
