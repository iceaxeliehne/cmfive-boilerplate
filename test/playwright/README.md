# Get Cmfive Working

- Use this codespace: https://github.com/2pisoftware/codespace_dev_box/tree/BoilerplateCore_Modules_Tests_Debug
- Open Codespace using your local VS Code using Remote Explorer extension for VS Code
- Wait for everything to be setup, then right click on the nginx webapp container and `Open In Browser`
- If the webpage gives a MONOLOGGER error, run `bash ./.codespaces/scripts/02_postCreateScript.sh`
- If not, Cmfive is ready for your Playwright tests

# Download nvm

- `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash`
- (or go to [nvm's github](https://github.com/nvm-sh/nvm) and use the latest command found there)

# Use the feature/AdminBS5Conversion branch as the cmfive-core repo

- `cd ../cmfive-core`
- `git switch feature/AdminBS5Conversion`

# Use the feature/PlaywrightMigration branch as the cmfive-boilerplate repo

- `cd cmfive-boilerplate`
- `git switch feature/PlaywrightMigration`

# Setup playwright
- `cd cmfive-boilerplate/test/playwright`
- `npm run setup`

# Run Playwright Tests

- `npm run build`
- `npm run test`
    - `npm run test` optional args:
        - `--platform` (runs tests with the selected browser):
            - usage:
                - `npm run test --platform="Chromium"`
        - `--module` (runs all tests for a module):
            - usage:
                - `npm run test --module="Admin"`
                - `npm run test --platform="Chromium" --module="Admin"`
- after completing a test suite run, if you want to reuse the system for another test, you must run `npm run cleanup` before you run `npm run test` again
            

# Setting up a new Playwright test for a module

- cd into the top level of the module (for example, cwd could be `cmfive-core/system/modules/help`)
- `bash /workspaces/codespace_dev_box/cmfive-boilerplate/test/playwright/mapToPlaywright.sh`
- the above script should be run whenever the relative path between a module and the base playwright directory in `cmfive-boilerplate` changes
- `*.test.ts` files contain the actual test code
- `*.utils.ts` files contain utility functions for a given module
    - util files are imported like so: `import { AdminHelper } from '@utils/admin'`, without `.utils.ts` file extension
    - you MUST run `npm run build` from `cmfive-boilerplate/test/playwright/` before changes to `xyz.utils.ts` are propagated to files importing `@utils/xyz`