# Test rigs in BorderWise

In BWW we have now dynamic test rigs. This guide is intended for new BorderWise product team members AND developers wishing to have their code functionally tested.

# How do I create a test rig for BorderWise?

The steps below outline how to include the test rig template in a SHV or UAT task.

1. Create a new SHV task

1. The task can either be assigned to the developer or to yourself (if you wish to be notified of the status of the build)

1. Paste in the Pull Request URL as the first line inside task notes

1. Right click in the Task Notes box.

1. Select Insert Template > “BorderWise UAT”. 

![1.png](/.attachments/1-f67f1ccc-152c-4639-a899-64d06fedc78f.png)

6. Change the task type depending on the situations outlined below, then press save.
    - **SH0** – if you require the unit tests to be run as well as the test rig to be created. If no test-rig parameter is provided in task notes, DAT runs unit tests only.
    - **UA0 –** if you just want to build the test rig (test-rig parameter is mandatory).

7. The UAT link passed in task note is used to create the container name during frontend and backend deployment. The UAT link pattern as per different projects is as below:
    - BorderWise UAT: `https://{WorkItemNumber}.app-uat.borderwise.com`
    - WebWatcher UAT: `https://webwatcher-{WorkItemNumber}.app-uat.borderwise.com`
    - UMP UAT: `https://ump-{WorkItemNumber}.app-uat.borderwise.com`

If there are multiple workflows under your work item for which if a developer needs to SH0 or UA0, then the developer should make sure workitemnumber value passed in UAT link in the task note is unique. Otherwise, deployment will override the container. To make the value unique, the developer can append suffixes such as: `https://{WorkItemNumber}{WorkflowNumber}.app-uat.borderwise.com`

8. When the build is complete, the UAT link in SH0/UA0 task will become active.

9. You can also use Crikey Test Results page to access details of the test rig deployment. BorderWise application is deployed as package where frontend and backend are deployed together in test rig. Frontend ports range from 401 to 449 and Backend range from 301 to 349

a. From the Crikey test results under BorderWise/BorderWiseWeb/DynamicTestRigDeployment, copy the WebApi Url to access backend

![2.png](/.attachments/2-ffb3b76a-3c2b-4f25-bbdc-2d001150e641.png)

b. From the Crikey test results under BorderWise/BorderWiseWeb/DynamicTestRigDeployment, copy the front-end url to access the BorderWise application

![3.png](/.attachments/3-71362ebd-52f0-455b-8d2e-59c985e513cc.png)

10. If there are changes in both BorderWise and UMP, we can set up both applications. Include the UAT URLs for both applications in the task notes in Step 5 and refer to the screenshot below for guidance.

![4.png](/.attachments/4-5f227b81-c992-4c6a-99a4-985301941a52.png)

Alternatively, if there is only a change in BorderWise but you want it to connect to the Custom UAT test rig, you can provide the `UMP UAT: {URL}` for BW to connect to. If no UMP UAT URL is mentioned, BorderWise will connect to `UMPBaseUrl` from appsettings.UAT.json

Click [here](https://wisetechglobal.sharepoint.com/sites/StackOverflow/Articles/Forms/AllItems.aspx?id=%2Fsites%2FStackOverflow%2FArticles%2F11988%2Emd&parent=%2Fsites%2FStackOverflow%2FArticles) to see the original article on this topic.