fx_version 'cerulean'
game 'gta5'

author 'Storm Systems'
description 'Starter Pack Script'
version '1.0.0'

name 'storm_starterpack'
shared_script '@ox_lib/init.lua'

server_scripts {

    'server.lua'
}

client_scripts {
    'client.lua'
}

dependency 'oxmysql'
dependency 'ox_target'
dependency 'ox_inventory'
dependency 'storm_guide'