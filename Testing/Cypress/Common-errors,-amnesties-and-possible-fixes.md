# Common Cypress errors/amnesties

1. [requestTimeout for `wait` of multiple requests aliases](https://devops.wisetechglobal.com/wtg/BorderWise/_wiki/wikis/BorderWise.wiki/3415/Common-errors-and-possible-fixes?anchor=1.-requesttimeout-for-%60wait%60-of-multiple-requests-aliases)
2. [Too many tests in 1 spec file](https://devops.wisetechglobal.com/wtg/BorderWise/_wiki/wikis/BorderWise.wiki/3415/Common-errors-amnesties-and-possible-fixes?anchor=2.-too-many-tests-in-1-spec-file)
3. [Leaked request because of test dependency on previous test](https://devops.wisetechglobal.com/wtg/BorderWise/_wiki/wikis/BorderWise.wiki/3415/Common-errors-amnesties-and-possible-fixes?anchor=3.-leaked-request-because-of-test-dependency-on-previous-test)

<hr>

## 1. requestTimeout for `wait` of multiple requests aliases

1. For example, the code below:
```
cy.wait(['@validateLicence', '@getUser', '@recordActivity', '@checkLicenceStatus', '@getDailyUpdates']);
```

might lead to error:

```text
CypressError: Timed out retrying after 5000ms: `cy.wait()` timed out waiting `5000ms` for the 1st request to the route: `recordActivity`. No request ever occurred.
```

2. Possible fix:
From the latest docs, [timeout for `wait`](https://docs.cypress.io/api/commands/wait#Timeouts) is divided into `requestTimeout` and `responseTimeout`.

![image.png](/.attachments/image-569a26fa-d4a6-4fce-985a-e91937ea5d4e.png)
![image.png](/.attachments/image-7c7d43e9-51f7-4b39-93f3-c76ff204f960.png)

We are waiting for [an array of aliases](https://docs.cypress.io/api/commands/wait#Using-an-Array-of-Aliases), in which Cypress will wait for all requests to complete within the given `requestTimeout` and `responseTimeout`.
And [the given `requestTimeout`](https://docs.cypress.io/guides/references/configuration#Timeouts) is 5000 ms
So, if a request like `@getUser` takes too long to response (we can `setTimeout` to delay like 6000 ms), then we'll never reach the rest of array of aliases (including `@recordActivity`, `@checkLicenceStatus`, `@getDailyUpdates`).

=> We need to increase `requestTimeout` for the `wait` for array of aliases command
=> The best increased timeout number to cover the whole array of aliases can be number of aliases multiplying default `requestTimeout` (which can be access via `Cypress.config('requestTimeout')`

In the example above, the increased `requestTimeout` should be `5 * Cypress.config('requestTimeout')` or 25000 ms
=> The code can be rewritten as follows:
```
cy.wait(['@validateLicence', '@getUser', '@recordActivity', '@checkLicenceStatus', '@getDailyUpdates'], { requestTimeout: 5 * Cypress.config('requestTimeout') });
```

## 2. Too many tests in 1 spec file

If a spec file has too many tests and there are a lot of tests depending on previous tests, it is considered not best practice.
There are lots of drawbacks for this kind of spec file.
1. You will have to run all tests in the spec file to reproduce a failed test
=> Takes long time to reach the failed test and not even sure that it can be reproduced.
2. You will have to follow the code logic/flow from the beginning to the failed test in order to trace the problem
3. You cannot run this big spec file in GUI mode because Chromium will crash because of "Out of memory" error
=> So to reproduce the problem, you have to run it from the beginning to the failed test, and run it in CLI mode 
=> Sounds like quite a nightmare, isn't it?

4. It can pass on your local, but it can still fail on DAT (because DAT run on different machines)
=> So if it fails on DAT and we cannot reproduce the problem locally because of huge number of tests, that's when those tests confuse and cost us the most.

Therefore, there should be a limit to number of tests in a spec in order to improve testing + developer experience.
IMO, number of tests in each spec file should be within 15-20 tests.
If the number of tests start reaching or exceeding this limit, it means that there will be much higher chance for us to get trouble with the spec file soon (due to those reasons above).

So if a dev faces this case, a refactor should be done as follows:
* Split the spec file with huge number of tests into multiple smaller spec files.
* Each small spec file has its own purpose of testing
* Put those smaller spec files into 1 folder that serve for general purpose of previous huge spec file.

For example: [PR for refactoring `search.spec.js`](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb/pullrequest/139931)

In this case, the huge spec file is `search.spec.js`
We split `search.spec.js` into multiple smaller spec file, each has its own purpose of testing, which is purpose of testing for search features.
And all of those small spec files are included in folder `search`
You should divide tests appropriately based on the purpose of search and also create utils/helpers to reuse in different spec files.

For example:
* `search/alphabetical-search-results.spec.js`
* `search/clear-query-button.spec.js`
...

Another reference is [when I split tests for authentication here](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb/commit/5ddf8101374e19154775adcc73ead0f0bc408bbc?refName=refs%2Fheads%2Fmaster&path=%2FFrontend%2Fsrc%2Fcypress%2Fintegration%2Fauth) into multiple smaller spec files of folder `auth`

## 3. Leaked request because of test dependency on previous test
For example, we have 2 tests called `"test 1"` and `"test 2"`.
And "test 1" has intercept for a request `"request 1"`.
But somehow, `"test 1"` is very quickly passed without `"request 1"` is made.
Then, when it goes to `"test 2"` already, `"request 1"` is now called.
But there is no intercept for `"request 1"` in `"test 2"`
=> This means `"request 1"` is leaked from `"test 1"` to `"test 2"`
=> This is when `"request 1"` is gonna return 404, which might lead to some troubles in rendering stuff.

=> Possible solutions to avoid this error:
* Check the functionality to make sure it doesn't make any unnecessary requests continuously 
=> most of the times I see leaked requests are because of AngularJS bad rendering mechanisms + some bad watches inside components
=> This is pretty hard to fix because AngularJS mechanism is hard to follow
=> The mitigation is probably trying to narrow down the watches, and migrate to Vue component asap

* Make the intercepts in `"test 1"` accessible to `"test 2"`
=> Doing this, the leaked request is still made successfully and would highly likely not to cause troubles during `"test 2"`

* Going with test isolation way: Either separate 2 tests or combine them (depending on the test context)

See WI: <a href="https://svc-ediprod.wtg.zone/Services/link/ShowEditForm/WorkItem/d55c958e-ccbf-4b46-bba5-91110541866c?lang=en-gb">WI00620285 - BWW. Fix "Should auto open previous TOC item" in left-toc.spec.js</a> for this exact error happen.
See PR: https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb/pullrequest/167469?_a=files for the solution with test isolation way
