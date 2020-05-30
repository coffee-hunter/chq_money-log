resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description 'CHQ Money Log'

author 'ColtenHQ#5123'

server_script {
    'server/main.lua',
    '@mysql-async/lib/MySQL.lua',
	'config.lua',
}
