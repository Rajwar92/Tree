TL;DR: Required Vue props are now guaranteed to be provided

Big improvement for AngularJS+Vue was just checked in.
Now if you defined your prop as required in Vue like so:
```js
props: {
  tabName: {
    type: String,
    required: true
  }
}
```
then we will perform prop validation automatically.
We will wait for AngularJS digest cycle to finish
Once it's done - we will check if required prop is not present - error will be logged and displayed instead of the component.
The component will only attempt to render if required prop is present.
This means that you can trust TypeScript types and just use `props.tabName` trusting that it will always be `String` and never `undefined`.
Because if it is `undefined` - the error is logged and displayed instead of the actual component.

The main benefit is that this helps ensure that AngularJS implementation matches our Vue expectations.

Previously we might declare prop as "required" and TS will tell us that it's always defined, but AngularJS might set it to undefined. And we had no good way of handling these errors.

If you get errors saying that required prop isn't defined - it means one of two things:
Either Vue misunderstood AngularJS implementation and this prop is actually optional, and so we should always check before using/relying on it
Or AngularJS has a bug, and sets required prop to undefined instead of throwing error or something, then we need to fix AngularJS logic, this is a silent bug that we always had but never knew about it

And there are two reasons why props validation error can occur:
1. The prop should actually be optional. 
For example, if we had `<ve-user-info/>` component - then `studentId` prop would be optional, because not everyone is a student.
2. There is a bug on AngularJS side and it shouldn't be rendering ve-* component without required prop. 
For example, if we had `<ve-user-info/>` component - then `userEmail` prop can not be optional. It is required in order for the component to function, and if we don't provide it - the component loses reason for existing. We also can't "solve" this by providing default email, because why would you be showing some empty/dummy email to user?
The challenge is when prop needs to be dynamically loaded by calling API for example.
We should use the following principles:
   1. Do not render component without providing required prop - error will be thrown
   2. Do not add default prop value just to make error go away
   3. If it takes more than 1 second to load - ideally show loading
   4. It's better to handle this in the parent of ve-* component
For a concrete example of what not to do see [this pr](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb/pullrequest/209376?_a=files). I'll update you guys with an example of what to do after we fix it.
 
Props validation for ve-* components allows us to ensure that strict contracts between components aren't broken. And this is very important when working in a large team with large number of components, not everyone knows everything about every component, so the least we can do it to make props reliable.

Check out PR [here](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb/pullrequest/207761?_a=files).