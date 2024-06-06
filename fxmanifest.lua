fx_version 'cerulean'
game 'gta5'

author 'Orion'
description 'Rental Vehicle'
version '1.0.0'

lua54 'yes'

shared_scripts {
    'config.lua'
}

client_scripts {
    '@ox_lib/init.lua',
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

dependencies {
    'qb-core',
    'ox_target',
    'ox_lib'
}