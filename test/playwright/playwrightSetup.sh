#!/bin/bash

# Load NVM into the script session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# ensure styles are compiled
cd ../../../cmfive-core/system/templates/base
nvm install 14
nvm use 14
npm i
npm run dev

# setup playwright dependencies
cd ../../../../cmfive-boilerplate/test/playwright
nvm install 18
nvm use 18
npm i
npx playwright install
npx playwright install-deps
sudo apt-get update
npx playwright install --force msedge
npx playwright install --force chrome