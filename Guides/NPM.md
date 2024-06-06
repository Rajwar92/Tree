# devDependencies

TL;DR: always use `dependencies`, never use `devDependencies` or `--save-dev`

Explanation:
Traditionally it's considered good practice to separate your production dependencies required to run your code from your development dependencies required for testing, for example.
It makes sense when you're writing plan JS files that use Express as a dependency to run API server, and then you have dev dependency jest to test it.
Then to run your code on production you only need to run `npm install --production` and it will install express but jest.

However, in most modern scenarios and especially for front-end it doesn't make sense to separate them. For example, for the front-end projects you don't actually run any code in production, all you do is just building `dist` folder, and then deploying it as static files. One could argue that in this case your deps is everything you need for the build, like gulp or React, and the devDeps is everything you need for testing like jest. However in most CI/CD setups you will have build and test as part of the same pipeline. So you will do `npm ci && npm run build && npm test` and then deploy results of the build if tests pass. It is also considered safer since sometimes there can be variance in the build processes. For example, in gulp when you create a bundle - your files can be concatenated in random order, and sometimes it results in issues. So you want to make sure that dist you're deploying is exactly the same dist as you tested.

devDeps are also relevant when someone is installing your project as a dependency.
For example, `Vuetify` might be using `jest` for running tests. But if we use `mocha` for running tests - we don't need to install `jest` just to use `Vuetify`. So `jest` would be devDep of `Vuetify` that we don't need to install.
Since nobody is installing our app/project as a dependency - we don't care about devDeps.

One could argue that in this case there's no difference between using devDeps or not, but I've seen some plugins and tools that help analyze your dependencies to act weirdly if you use devDeps, so it's safer to just not use them unless you're creating a library package that will be published and consumed by other node projects.

# Patches

Sometimes we need to fix something in our dependencies. We should aim to do that by creating an issue and/or PR to the dependency's project on GitHub. Sometimes we can't wait for it to be merged. Other times we need a fix that is only applicable to our use-case. In these rare circumstances, we have to patch our dependencies. This is done using [patch-package](https://www.npmjs.com/package/patch-package).

## Keeping track

It's very important to keep track of what we're patching, why, how and to have a plan of when the patch will be removed. Every patch is bad for maintenance, so we always should find or create an issue on GitHub and link it in the patch file comments.
For smaller patches we use first lines of the `*.patch` file for comments. They are ignored by the patcher. Make sure to include as much details as possible, so that we know why it is there, what it does and when should it be removed. See other patch files in BWW and WW for examples.
In some cases, like with `orval` - they have minified code in node_modules, making it extremely hard to see what the patch actually does. In this case it is even more important to keep track of changes. In my case, I created a README with patching instructions in the patches folder and created a `bww` branch in my fork, into which I merged all other branches with fixes, and created PRs to the main repo as well.

## How to upgrade dependency for which we have a patch

For example, here's how to upgrade `vuetify` in WW from v3.3.3 to v3.3.8:
1. do `npm ci` on a clean master
1. do `npm install vuetify@3.3.8`
1. do `npx patch-package` - it will show warning saying that we have patch for v3.3.3 but trying to apply it to v3.3.8; worst case scenario - it will show error, unable to apply patch.
  - If there was a warning - it's usually fine, follow its instructions, run `npx patch-package vuetify` and manually review notes from the patch, verify that they are either resolved in vuetify new version and remove that note, or verify that required code changes are in the patch. You can use git blame to find what changes were added for which feature comment.
  - If there was an error - you need to see old patch file, go to the `node_modules` files, manually do changes where they are still needed, potentially some code could change drastically and new solution will be required. After all done run `npx patch-package vuetify`. This command generates new patch file based on the diff between npm version of vuetify and your local one in node_modules.
