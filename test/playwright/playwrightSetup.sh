#!/bin/bash

# Load NVM into the script session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
unset npm_config_prefix

compile-styles() {
    (
        cd ../../../cmfive-core/system/templates/base
        nvm install 14
        nvm use 14
        npm install
        npm run dev
    )
}

setup-playwright() {
    (
        nvm install 18
        nvm use 18
        npm install
        npx playwright install
        npx playwright install-deps
        sudo apt-get update
        npx playwright install --force msedge
        npx playwright install --force chrome
    )
}

# compile styles and setup playwright in parallel
# both subscripts use subshells so each `nvm use` doesn't interfere with the other
compile-styles & setup-playwright

wait