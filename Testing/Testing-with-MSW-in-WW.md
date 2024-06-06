Our Mock Service Worker (MSW) handlers in WebWatcher (WW) use a state of mock data (which can be found in `mockData.ts`) to simulate how our requests work in the real world. 

This state provides enough data to ensure the majority of components behave seamlessly in our tests without having to tinker with them too much. 

The benefit of this is that it removes the need to setup detailed mock data and routes for each separate test, meaning we're only required to make small changes to test data relevant for the functionality we're testing in a given test.

# When Should I Modify Handlers.ts?

The routes defined in `handlers.ts` should be routes that are relevant to a variety of different tests. Generally, these routes return all the data associated with the default library item we use in a lot of our tests.

These routes should return values from the state so that if/when we change values during our tests (or our handlers), these data changes are reflected across all our mock routes (e.g. our schedule now endpoint should update a schedule's last check property).

As an example, these routes return monitoring requests in the default collection and schedule info for the default monitoring request used in our test files:

![image.png](/.attachments/image-35de5127-046b-4586-9f86-12acb66dd6ac.png)

# What If I Want to Test Something a Bit More Specific?

## Modify the State During Your Test

If you want to test something that only requires a small change to existing data, you should modify the state.

An example of this could be modifying the default monitoring request's extraction type from "Custom" to "Web", which we might want to do when testing our `ConfigurationForm` component.

Changes made to the state are all reset before each test in our `setupTests.ts` file, so we don't have to worry about possibly breaking other tests.

![image.png](/.attachments/image-bf13df5f-3e29-4e9d-b5c3-cb914f6174dd.png)

## Setup Separate Handler Inside of a Test

In some cases there may be mock request routes that are only relevant to a specific test. Or maybe we don't care about a request response and only want to confirm that a request was sent (e.g. when a form is submitted).

In these cases we can call `server.use()` within our test to setup our custom route, which will prepend our request handler to the current MSW server instance to ensure it matches before any other existing handler.

An example of this can be seen in `LoginForm.spec.ts`:

![image.png](/.attachments/image-10b15cbd-1f38-440f-98e6-c4aae63b0a24.png)




