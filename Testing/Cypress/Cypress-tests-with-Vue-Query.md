When migrating from AngularJS to Vue Query we need to change the mental model a bit for writing Cypress tests.

In Cypress often times I see this:
1. Setup test
1. Visit page, login, all that
1. Setup interceptor for requests made by some function
1. Click some buttons that call those functions

This works fine with the old AngularJS data-fetching model, where every time we need data - we make a request.

However, with Vue Query we might choose to cache data for some time. And with Vue Query we don't want to think about manually managing requests, it's abstracted from us, we just ask for data where we need it and it magically appears, maybe from a request, maybe from cache, maybe we put it there manually, etc.

So, this also requires us to change the way we set up Cypress tests.

**TLDR:** In 99% of Cypress tests, you need to setup all intercepts before cy.visit()-ing the app page.

Here's an example of the issue I found in [cypress/e2e/auth/contract/contract-before-editions-dialog.spec.js](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb/pullrequest/220010?_a=files&path=%2FFrontend%2Fsrc%2Fcypress%2Fe2e%2Fauth%2Fcontract%2Fcontract-before-editions-dialog.spec.js)

![Cypress-Vue-Query.drawio.png](/.attachments/Cypress-Vue-Query.drawio-ee932e1d-8915-4c28-a4d4-d4d7ffefb287.png)