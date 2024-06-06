1. Open Microsoft SQL Server Management Studio
1. Connect to the UMP Test database server:
    - Server type: Database Engine
    - Server name: `sydsp-ssql-8.sand.wtg.zone`
    - Authentication: SQU Server Authentication
        - Login: `OdysseyAdmin`
        - Password: _ask a team member_
1. Open the 'Databases' folder in the Object Explorer
1. Right click 'BorderWise_UMP_Test'
1. Select 'Tasks' > 'Back Up...'
1. Configure the backup
    - Database: `BorderWise_UMP_Test`
    - Backup type: `Full`
    - Backup component: Database
    - Back up to: `Disk`
        - Add: `\\sydsp-ssql-8.sand.wtg.zone\SQL_Backup\BorderWise_UMP\<backup name>.bak`
1. Press 'OK'
1. Go to `\\sydsp-ssql-8.sand.wtg.zone\SQL_Backup\BorderWise_UMP\<backup name>.bak` in your file explorer to find the backup