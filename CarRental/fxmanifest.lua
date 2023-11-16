fx_version 'cerulean'
games { 'gta5' }

shared_script {
    'shared/config.lua'
}

server_scripts{
    'server/sv_main.lua'
}

client_scripts{
    'client/cl_main.lua'
}

ui_page {
	'ui/index.html'
}

files {
	"ui/index.html",
	"ui/css/*.css",
	"ui/js/*.js",
    'ui/images/*.png',
    'ui/font/Jost-SemiBold.ttf',
}