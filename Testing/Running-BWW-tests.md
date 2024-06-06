# Pre-requisites
Make sure to follow `Getting started` from `README.md` to install all dependencies before running tests.

# TL;DR
- `npm test` in `src` and `vue-elements` folders;
- `npm run *:watch` during active development;
- There is VS Code plugin

# Active development
## Setup
Make sure to install all recommended extensions from `extensions.recommendations` of `BorderWiseWeb/Frontend/BorderWiseWeb-Frontend.code-workspace`; VS Code should've asked if you'd like to install them when you first opened the workspace.

## Working on legacy AngularJS `Frontend/src` project

### Running Karma unit tests
- `npm run test-karma:watch`
- `npm run test-browser` - runs in browser and allows to use Chrome DevTools to debug
- `fit()`/`fdescribe()` to run **f**ocused (specific) tests and skip others

### Running Cypress integration/e2e tests

#### CLI
- `npm run test-e2e -- --spec="cypress/e2e/auth/login.spec.js"` - run 1 spec file at a time 
- `npm run test-e2e` - run all specs files (not recommended because there are too many specs files, and it would take very long)

#### Cypress UI App
1. `npm run test-e2e:open` - start Cypress server and open UI App
![the-launchpad.png](/.attachments/the-launchpad-4ae59f0b-cf22-45da-9a83-a52cce2886b3.png)
1. Choose testing type: "E2E Testing", and select a browser:
![select-browser.png](/.attachments/select-browser-890dc0c8-1911-4e5e-ae0c-f24254528f7b.png)
1. Select a spec file and start running tests:
![spec-list-with-new-spec.png](/.attachments/spec-list-with-new-spec-2ad67673-bccd-4d94-a6c1-fcb5ed9833fd.png)
## Working on new Vue `Frontend/vue-elements` project

You can choose to run unit tests in a few different ways, see below.

### CLI
This is the easiest way, also this is how tests run in CI so you can debug CI issues using CLI on your local.
- `npm run test:unit:watch`
- `it.only()`/`describe.only()` - to run only specific tests

### Vitest UI
This is the nicest and most productive way, also quite reliable. You can open vitest UI on the second screen and get a nice view of live test results with easy navigation.
- `npm run test:unit:ui`
- `npx vitest --ui PageContentSetup` or similar to only run specific test file
- see [docs](https://vitest.dev/guide/ui.html) for more info
<IMG  src="https://user-images.githubusercontent.com/11247099/171992267-5cae2fa0-b927-400a-8eb1-da776974cb61.png"  alt="Vitest UI"/>

### VS Code test explorer
Not recommended, known for many issues, may work for some tests, see [docs](https://marketplace.visualstudio.com/items?itemName=ZixuanChen.vitest-explorer)

# Running all tests
## When?
- You might want to run all tests before submitting to SH0 to DAT, this might save you time because you won't have to wait in the queue to run tests, also running them locally is usually faster, especially if you're using WSL.
- Another reason to run all tests locally is when you need to debug some error that happened during DAT/QGL run. Still, I would recommend running specific tests, if prettier failed - only run prettier fix; if unit tests failed - only run unit tests; it'll speed things up and help you in the long run.

## How?
### Legacy AngularJS `Frontend/src` project
- `npm test`
- Check out `package.json` to see what this script will run, you can manually run parts to speed it up
- Beware that cypress (`test-e2e`) tests will likely randomly fail due to a known http-server bug. You can use `npm run test-e2e:open` to open Cypress UI and run specific tests you're working on individually. Or use QGL to run all tests - will be extremely slow tho. Might want to give `cypress-run-all.js` a try, not sure it'll help tho (need to modify it to restart http-server every time before each test).

### New Vue `Frontend/vue-elements` project
- `npm test`

# Docker
We have integration tests for Docker and Nginx - `src/__tests__/docker.skip.ts`;
## When?
These are only to be run on local dev machine when making config changes. These will be run on DAT as well once we have Docker support on DAT.
## How?
1. Rename this file from `docker.skip.ts` to `docker.spec.ts` in order to run it
1. `cd ../src && npm run build-dev` - make sure to run build-dev from gulp before running these tests
1. `npx -y cross-env DEBUG=true npm run test:unit -- docker` - one-time run with debug output (recommended when running for the first time)
1. During active development - `vitest docker`

Note, that when this test fails it may leave changes in `nginx.conf` - do not commit them and revert in order for test to run properly next time.