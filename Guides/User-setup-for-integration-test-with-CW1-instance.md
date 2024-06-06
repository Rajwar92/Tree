1. Launch CW1 instance (either test-rigs on SAND or CW1Alpha on Corp or your local CW1 instance) and login as cw1Support.
![image.png](/.attachments/image-884ae92b-4e61-4ec0-b63a-77fc89009ccc.png)

2. Open Staff and Resources module, select any user from Recent items. In case there is no record in recent items, then you could search any staff with Active status to true; 
![image.png](/.attachments/image-ec01c5dc-3b1d-4d48-9606-9d6afc997f7b.png)

3. Modify user's password and email address; The login name is the one used to login CW1 instance. Email should be same as the existing email in UMP (production / test) depends on which env you want to test with. 
![image.png](/.attachments/image-7aced653-1692-4f36-b830-9376e0626747.png)

Password is used for CW1 login
![image.png](/.attachments/image-6e11b932-9ebe-4b58-9016-3dc441c65336.png)

4. Set up Security Rights -> give permission to access custom files
![image.png](/.attachments/image-2d2034a7-7910-422a-91a5-ff4d00042529.png)

5. Save

6. If you want to test features for UMP, then  
Open registry -> set up "BorderWise UMP API Base Address", overide the default value with your test rig url  
![image.png](/.attachments/image-542bedf4-23a3-4ed9-b24d-6fc697f9aafb.png)

7. If you want to test features for BW, then do the same thing for "BorderWise Web Address". Sometime you need to change both fields
![image.png](/.attachments/image-f886bb83-3752-4131-9e3f-d5527e236bb4.png)

8. Save and login as new user, then use the login name and password to login.
![image.png](/.attachments/image-0b1635f8-f0cc-4043-912e-e42da5f4b8cf.png)

9. If you override the ump API base address with your test rig URL and are wanting autologin to take you to a BW test rig, you will need to update the autologin url in appsettings in your UMP UAT

10. You should be able to connect BW via autologin now.
