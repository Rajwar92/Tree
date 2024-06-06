# BorderWise Multi-line Tariff Classification
BorderWise Multi-line Tariff Classification feature allows users to classify all invoice lines at once and submit the entire data back to CargoWise One. This document provides instructions on how to utilize this feature through the user guide. 

**Step 1:** Open WiseCloud Sand and you will see a list of CW1 sand servers, search for the keyword “Batch” by clicking ctrl+F. Open Sand Server “WI00549317BatchMode”.
 
**Step 2:** Once you access the Sand Server instance, a Username and password prompt will appear. Follow these steps: 
1. For the Username, enter "CW1Support". 
2. To obtain the password, navigate to ediProd and locate the "Support Token" option under the Help section in the bottom panel. Copy the password to your clipboard, and then simply paste it directly into the login form for the Sand Server.

![Picture1.png](/.attachments/Picture1-8ec966e7-63cf-454a-b5c6-be3e6644d2b8.png)

**Step 3:** After the CW1 Sand Server instance is opened, browse to Staff browse to **Staff and Resources** module and create a new Staff Entry with your credentials. Refer to the below screenshot

![staff.png](/.attachments/staff-895818f6-fca3-4f64-9be9-b4cfbbf8e0f7.png)  

**Step 4:** Now login with the newly created credentials and browse to “Customs Declaration” Module, and create a New Customs Declaration.

![Picture2.png](/.attachments/Picture2-ca25281f-1a77-4211-bce1-d25afb3a930e.png)

**Step 5:** On the Customs Declaration screen, navigate to “Inv. Headers” tab, and specify Invoice Headers for your declaration.

![Picture3.png](/.attachments/Picture3-5354d3e4-7935-4670-8c21-964859f502d3.png)

**Step 6:** Navigate to Inv. Lines tab, and specify the Invoice Lines for your customs Declaration.

![Picture4.png](/.attachments/Picture4-92751ffe-841f-4a50-898b-ff4d5b21197a.png)

**Step 7:** Now when you click on any of the Tariff Code, you should see an ellipsis icon, clicking on which should take you to the BorderWise Application in your default web browser.

![Picture5.png](/.attachments/Picture5-d0f278e5-63df-4745-bb11-72ec2c41910a.png)

**Step 8:** In the BorderWise Application, you will be prompted with the dialog explaining the Multi-Line Tariff Classification feature, you can opt not to see this dialog again before proceeding so that you won’t be prompted with this dialog every time you try to access this feature.

![picture22.png](/.attachments/picture22-9036aa3c-2e40-405a-a0ca-6055ede60e98.png)

**Step 9:**  You should be able to access the Multi-Line Tariff Classification Panel.

![Picture7.png](/.attachments/Picture7-4171a541-0667-4e2c-95e4-eba4c4502d29.png)


You can find the explanation of some of the useful features in the Multi-line Tariff Classification Panel Below

### Dock View: 
The dock view button on the top right corner allows the user to toggle between Vertical View and Horizontal View.

![Picture8.png](/.attachments/Picture8-da85aa44-15ad-4018-b17d-3643edda0234.png)


Vertical View

![Picture9.png](/.attachments/Picture9-f3989adc-7131-46bb-9859-69690163844b.png)

Horizontal View

![Picture10.png](/.attachments/Picture10-a8be6d5f-bbf8-4406-87fb-e160504334e7.png)


### Add New Invoice Line:

User can add new invoice lines in the tariff classification by clicking on the plus icon highlighted in the screenshot below. User is also allowed to delete these newly added invoice lines.

![Picture11.png](/.attachments/Picture11-d19091f7-2e56-477c-ba75-81cfcf2e7ad8.png)

### Browse Unclassified Invoice Lines
The unclassified tab option in the navbar at the top allows user to only see unclassified invoice lines.

![Picture12.png](/.attachments/Picture12-ecb44d37-2169-4595-bdae-23dc05954452.png)

After classifying invoice lines in the unclassified tab, user is prompted with a refresh option in the top navbar which will remove classified lines from the Unclassified Tab.

![Picture13.png](/.attachments/Picture13-7b35db8f-ef74-42c6-9154-19b709f76ebc.png)



### Classify Invoice Line
In order to classify invoice lines, users can select any of the options below.
1.  Directly type a valid Tariff Code in the Tariff input field.
2.  Specify the parent heading for the tariff and type “Enter”, which will open the Tariff Table corresponding to that parent heading in the center view, and user can select the appropriate tariff code from the table by clicking on the stat code link.
3.  User can type the respective tariff heading in the search box at the top, and select the appropriate tariff code by clicking on the stat code link.
 ![Picture15.png](/.attachments/Picture15-a720c148-84a0-4c23-aab8-25d510cf6045.png)


# BorderWise Single-line Tariff Classification

BorderWise also supports single-line tariff classification which allows users to classify individual invoice lines and submit the tariff code back to CargoWise One. Following are the steps to access this feature:

**Step 1:** Open CargoWiseOne, and navigate to Import Classification Lookup / Export Tariff Classification Module. Create a New tariff Classification and a New Classification Lookup Dialog should appear on the screen.
![picture25.png](/.attachments/picture25-9e5fd57d-6de2-4afa-bcfb-9ff124e3a954.png)


**Step 2:** Click on the ellipsis button adjacent to the Tariff Number field and BorderWise Application will open in your default web browser with the Tariff Table corresponding to the Tariff Number entered in the Classification Lookup form.

![pitcure20.png](/.attachments/pitcure20-507271e0-0f9c-43bc-82b6-52413bdf4796.png)


**Step 3:** You can select the appropriate Tariff Code by clicking on the stat code link and you will be prompted with the dialog containing the selected Tariff Code. You can opt to not see this dialog again before submitting. 

![picture26.png](/.attachments/picture26-1668d498-b964-4cc9-8a20-c82cdea3427b.png)

**Step 4:** Click on the ”Submit CW1” button and the selected Tariff Code will be populated in the ”Tariff Number” field.

![picture24.png](/.attachments/picture24-ab294ffc-20a1-442c-93ed-600d091a4659.png)