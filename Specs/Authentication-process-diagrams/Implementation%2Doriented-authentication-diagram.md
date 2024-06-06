 Below is more implementation-oriented diagram that will helps developers to follow the flow, divide the stages and maybe find a way to improve the process:
In this diagram, I have divided/separated stages including:
* Normal login
* autologin
* `getSession()`
* `initializeLicence()`
* `contractCheck()`
* `studentCheck()`
* `licenceCheck()`
* Licence Dialog
* Editions Dialog
* `initUser()`

=> Currently, we are coupling these stages by Promises hell chain inside `app.controller.js`
=> So, one of the ideas is to separate them in a Vue component called `AuthCover`, which will be implemented in [WI00587038 - BWW. Create AuthCover component in Vue](https://svc-ediprod.wtg.zone/Services/link/ShowEditForm/WorkItem/c81de151-43a1-40aa-bfb3-ef70f9b26be5?lang=en-gb)

![Login-with-implementation-details-vertical.drawio.png](/.attachments/Login-with-implementation-details-vertical.drawio-502c71f9-5f1b-4810-bc9f-c010b4a33879.png)