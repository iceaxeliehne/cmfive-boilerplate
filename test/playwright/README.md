# Get Cmfive Working

- Use this codespace: https://github.com/2pisoftware/codespace_dev_box/tree/BoilerplateCore_Modules_Tests_Debug
- Open in VS Code Desktop
- Wait for everything to be setup, then right click on the nginx webapp container and `Open In Browser`
- If the webpage gives a MONOLOGGER error, run `bash ./.codespaces/scripts/02_postCreateScript.sh`
- If not, Cmfive is ready for your Playwright tests

# Download nvm

- Grab the latest version of nvm from https://nvm.sh using the `curl` command
- Close the current terminal after nvm is downloaded, and open a new terminal

# Use the feature/PlaywrightMigration branch as the cmfive-boilerplate repo

- `cd cmfive-boilerplate`
- `git switch feature/PlaywrightMigration`

# Use the feature/AdminBS5Conversion branch as the cmfive-core repo

- `cd ../cmfive-core`
- `git switch feature/AdminBS5Conversion`

# Ensure styles are compiled

- `cd ../cmfive-core/system/templates/base`
- `nvm install 14`
- `nvm use 14`
- `npm i`
- `npm run dev`

# Setup Playwright

- `cd ../../../test/playwright`
- `nvm install 18`
- `nvm use 18`
- `npm i`
- `npx playwright install`
- `npx playwright install-deps`

# Run Playwright Tests

- cwd should be `cmfive-boilerplate/test/playwright/`
- `npm run build`
- `npx playwright test --project=chromium`

# Setup a Playwright test for a module
- cd into the module
- `bash /workspaces/codespace_dev_box/cmfive-boilerplate/test/playwright/createPlaywrightTest.sh`
- *.test.ts files contain tests
- *.utils.ts files contain utility functions for a given module
    - util files are imported like so: `import { Xyz } from '@utils/xyz'`, without `.utils.ts` file extension
    - must run `npm run build` from `cmfive-boilerplate/test/playwright/` before changes to `xyz.utils.ts` are propagated to files importing `@utils/xyz`