game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'marcus'
description 'A Script That Would Allow medics To carry a Job Bag'
version '1.0.2'

shared_scripts {
    "configs/**.lua"
}

server_script {
    "server/**.lua"
}

client_script {
    "client/**.lua"
}

escrow_ignore {
    "configs/**.lua",
    "README.lua"
}

files {
    'stream/prop_cs_shopping_bag.ydr'
}

dependencies {
    'rsg-core',
    'rsg-target'
}

lua54 'yes'
this_is_a_map 'no'
