# Pre-req:
Make sure to checkout and understand the definition of Intermittent Failures and Amnesty tests:
See StackOverflow references below:
- [What are Intermittent Failures?](https://wisetechglobal.sharepoint.com/sites/StackOverflow/questions/Forms/AllItems.aspx?id=%2Fsites%2FStackOverflow%2Fquestions%2F8794%2Emd&parent=%2Fsites%2FStackOverflow%2Fquestions)
- [Why are test failures shown in grey vs black?](https://wisetechglobal.sharepoint.com/sites/StackOverflow/questions/Forms/AllItems.aspx?id=%2Fsites%2FStackOverflow%2Fquestions%2F8787%2Emd&parent=%2Fsites%2FStackOverflow%2Fquestions)
- [What is the difference between an incident, a defect, an issue, and an amnesty?](https://wisetechglobal.sharepoint.com/sites/StackOverflow/questions/Forms/AllItems.aspx?id=%2Fsites%2FStackOverflow%2Fquestions%2F103%2Emd&parent=%2Fsites%2FStackOverflow%2Fquestions)

# TL;DR
> Intermittent Failure is a failure of a test on one DAT test agent, when a subsequent execution of the same test within the same DAT run has passed

> A "confirmed" failure is the test was run on three separate DAT test agents and the test failed all three times.

> An Amnesty is a unit test that has started failing, but no change in the DAT run could be automatically identified as the cause of the failure. This could be due to intermittent failures, time-based failures (e.g. tests that depend upon Daylight Savings), systemic issues (e.g. updates to DAT virtual machines) or any other reason that would cause a test to work for a certain amount of time before it started to fail. 

# "Confirmed" failures on DAT that is caused by your PR/changes:
- If your DAT run always fail when you submit your changes, and the failed test is related to your changes, then you will have to fix it (or ask for assisting to fix it) within your PR/changes.
- If your changes make Cypress tests failed on DAT, but it still pass on master branch, it can have 2 meanings:
  - Your functionality code changes has problems that broke a functionality that is supposed to work
  - The code for Cypress test needs to be updated to reflect your changes

# "Confirmed" failures on DAT that is NOT caused by your PR/changes:
- Please double check carefully that the "confirmed" failure is NOT caused by your changes.
- If your DAT run fail, but it's really NOT related to your changes, then it is highly likely to be an Amnesty test failure.
=> You can try submitting for another DAT run (because sometimes DAT env can cause some unexpected issues).
- Any failed DAT run will be recorded, and if a Cypress test fail too many times, DAT will start seeing it as an Amnesty test, and we will have an Amnesty WI to fix it.

# Approaches for Amnesty test failure
## Fix it :)
- Please read more about Cypress best practices in their docs to find possible fix
- See also: 
  - Wiki for [Common errors, amnesties and possible fixes](https://devops.wisetechglobal.com/wtg/BorderWise/_wiki/wikis/BorderWise.wiki/3415/Common-errors-amnesties-and-possible-fixes)
  - [Common Cypress errors](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb?path=%2FFrontend%2Fsrc&anchor=common-cypress-errors) in README.md

### After finding the fix:
When we finish fixing any Cypress Amnesty Failure, there are few cautious approaches that we can take in order to make sure amnesty test actually fixed:
1. Before starting to fix the test - make sure you can reproduce the failure. Edit script `run-tests-until-failure.sh` to run the test you're trying to fix and run it until it fails. If it's been running for a while (30 minutes, etc) and still doesn't fail - maybe try to think what could go wrong and try to fail it manually. Like switching in devtools to slower network speed, or adding timeouts/delays for requests, trying to create a race condition, etc.
1. Try script `run-tests-until-failure.sh` to re-run a test locally as many times as you want. If the script running your test successfully for an acceptable number of times (at least 5-10 times, but best to leave it running for as long as you can while working on something else, like an hour or so), then most likely the test is fixed.
1. Try running your fix on DAT for multiple times (like shelf test for 3 times). Be aware that every time we run shelf test on DAT, the test can be run in different machine, so even multiple run on DAT can pass but amnesty test can still come back on another DAT machine.
1. Try running tests under system load. For example, download [y-cruncher](https://wisetechglobal-my.sharepoint.com/:u:/p/maxim_mazurok/ERFHzV9Y89dKonxI6zoXOaUBibburqXjTDunJ83SMNrbmQ?e=FwUrd0) (password "shadow" because it's blocked by IS for no good reason). In there you can run stress-test. You can also change performance mode to something other than "Ultra Performance" in Dell Optimized, and might want to change Windows power mode to "Best power efficiency". The goal is to slow down you PC to be like DAT, as it can be very slow under load. And keep on running `run-tests-until-failure.sh`.

## Skip Amnesty test and fix later:
- Skipping a test is NOT a recommended way whenever we have a failure.
Even when amnesty test is NOT caused by your changes, you should try to fix it before thinking of skipping.
- There are some cases that we can have tolerance for skipping Cypress tests:
  - Some breaking changes like upgrading Cypress, huge PR, work in progress, etc... 
  - When a priority WIs require faster merge like defects fixes, etc...

  => But then, the skipped Cypress tests should be pushed to be fixed immediately.

- See similar SO reference also: [What to do when Cypress e2e test fails intermittently on DAT for BorderWise Web?](https://wisetechglobal.sharepoint.com/sites/StackOverflow/questions/Forms/AllItems.aspx?id=%2Fsites%2FStackOverflow%2Fquestions%2F10783%2Emd&parent=%2Fsites%2FStackOverflow%2Fquestions)

### Important notes for skipping a Cypress failure test:

- If you decide to skip a Cypress test, then when you create WI to fix that test, please include the link of failed DAT run, and also attach the screenshot + log file of that failed Cypress test.
- If you don't include the link, the screenshot and the log file, we can't trace back whatever the issue you have with that test.
This ends up we enable the test again just to see why it failed. 
  - If the re-enabled test pass, then we'll never know the real issue.
  - If the re-enabled test fail, we are never sure that it's the same issue as when you skipped it.

- Screenshots + logs files stored on DAT artifacts repository will be removed after a period of time.
=> So please attach them in eDocs when you create the WI to fix the Cypress test.
=> This will help preserve them permanently for us to trace back.

- See [WI00632147 - BWW. Fix skipped cypress tests](https://svc-ediprod.wtg.zone/Services/link/ShowEditForm/WorkItem/4f6964e1-f403-4183-9786-bd5182da34ab?lang=en-gb) for example: no information at all to find possible fix :cry:

