# Web Watcher

### Common Setup

1. Set up Jumphost
   - Follow [these instructions](https://wisetechglobal.sharepoint.com/Technical%20Support/WiseTech%20Global%20Secure%20Remote%20Access.pdf?CT=1657436790992&OR=Outlook-Body&CID=5DCEAF35-A066-42D4-895D-7F22522B1C44) to set up Jumphost
1. SSH into a server
   - We usually use PuTTY to ssh into the different servers through Jumphost. Check with BorderWise team members if they have some shortcuts they're willing to share. 
   - If you want to set up your own shortcuts:
      1. Download the [PuTTY client](https://www.putty.org/) (`.exe`) and place it in a folder
      1. Create a Windows shortcut with the PuTTY executable as the target in the same folder
      1. Append ` -ssh borderwise@<server URL>` to the Target. It should look like `<path to PuTTY>  -ssh borderwise@<server URL>`
      1. Create shortcuts for whichever servers you need to connect to
      1. Copy the folder with PuTTY and the shortcuts into Jumphost. This can be easily done by selecting the folder and pressing <kbd>`Ctrl`</kbd> + <kbd>`C`</kbd> followed by <kbd>`Ctrl`</kbd> + <kbd>`V`</kbd> in Jumphost
   - When connecting to servers you will be prompted for passwords. Reach out to a BorderWise team member if you need the password for a specific server

## Test
_TODO: Verify that these instructions work._

[Original documentation](http://tfs.wtg.zone:8080/tfs/CargoWise/BorderWise/_git/content_service_documents?path=%2Fdatabase%2Fpostgresql%2Fbww-testing%2FREADME.md&version=GBmaster&_a=preview)

Server: `au2wt-sdkr-2.test.wisecloud.zone`

### Server Setup
1. `host$ docker-compose build`
1. `host$ docker-compose up -d`
1. `host$ docker exec -it postgresql_db_1 bash`
1. `root@container# su - postgres`
1. Change password of postgres db user:
   - `postgres@container# psql`
   - `postgres=# \password postgres`, then type the password
     - You can request the password from a team lead
     - Passwords are stored in https://safe.wisetechglobal.com/
   - `postgres=# exit`
1. Create the DB user:
   - `postgres@container# createuser -U postgres testing -P`
     - Creates a new user from the postgres user called 'testing' and prompts for a password.
     - Password should match the one in stored in https://safe.wisetechglobal.com/
1. Create the DB:
   - `createdb -O testing webwatcher_test`
     - Creates the database 'webwatcher_test' which is owned by the user 'testing'
1. Open [pgAdmin](http://contentservice.wtg.zone:8082/browser/)
1. Create a new server for Test if it isn't there already and enter the relevant host address, username, and password.
   ![image.png](/.attachments/image-e1942bdc-633c-46e7-b663-188cfeff5589.png)
1. Follow instructions from [https://wisetechglobal.sharepoint.com/sites/StackOverflow/questions/Forms/AllItems.aspx?id=%2Fsites%2FStackOverflow%2Fquestions%2F10763%2Emd&parent=%2Fsites%2FStackOverflow%2Fquestions) to restore data.

## Production

[Original documentation](http://tfs.wtg.zone:8080/tfs/CargoWise/BorderWise/_git/content_service_documents?path=%2Fdatabase%2Fpostgresql%2Fsetup.md&version=GBmaster&_a=preview)

Servers:
- Primary: `au2wp-sbps-401.wisecloud.zone`
- Secondary: `au2wp-sbps-402.wisecloud.zone`

### Server Setup
- Primary
  1. Check that there is a 'main' cluster on the server: `pg_lsclusters`
     - If there isn't create a new cluster called 'main' like so: `pg_createcluster 14 main`
  1. Create a new user to be used to replicate the cluster: `createuser -U postgres secondary -P --replication`
  1. Stop the cluster if it is running: `sudo systemctl stop postgresql`
  1. Update the config file to enable connections and replication: `/etc/postgresql/14/main/postgresql.conf`
     - Set `listen_addresses = '*'`
     - Set `wal_level = replica`
  1. Update the authentication config file to allow connections `/etc/postgresql/14/main/pg_hba.conf`. Add the following lines to the end of the file:
     - `host	replication	all		10.2.88.44/32	md5` (To allow replication from the secondary server)
     - `host	webwatcher	webwatcher	10.61.198.26/32	md5` (To allow pgAdmin to connect to the webwatcher database as the webwatcher user)
     - `host	webwatcher	webwatcher	10.2.67.111/32	md5` (To allow WebWatcher BE to connect to the webwatcher database as the webwatcher user)
     - `host	webwatcher	webwatcher	10.2.67.112/32	md5` (To allow WebWatcher BE to connect to the webwatcher database as the webwatcher user)
  1. Start the cluster: `sudo systemctl start postgresql`
  1. Check that it is running: `pg_lsclusters`
  1. Open [pgAdmin](http://contentservice.wtg.zone:8082/browser/)
  1. Create a new server for Prod if it isn't there already and enter the relevant host address, username, and password.
     ![image.png](/.attachments/image-e1942bdc-633c-46e7-b663-188cfeff5589.png)
  1. Follow instructions from [this Stack Overflow post](https://wisetechglobal.sharepoint.com/sites/StackOverflow/questions/Forms/AllItems.aspx?id=%2Fsites%2FStackOverflow%2Fquestions%2F10763%2Emd&parent=%2Fsites%2FStackOverflow%2Fquestions) to restore data.
- Secondary
  1. Generate an SSH key: `ssh-keygen -t ed25519` _(Not sure if this is necessary)_
  1. Copy the generated `~/.ssh/id_ed25519.pub` to the primary server's postgres user's home. Save it as `~/.ssh/authorized_keys` _(Not sure if this is necessary)_
  1. Connect from the secondary server to the primary server and confirm the server ssh fingerprint: _(Not sure if this is necessary)_
     1. On secondary: `ssh postgres@<primary IP>`
     1. On primary: `ssh postgres@localhost`
     1. Confirm that the ssh fingerprint for both are the same
     1. Complete the connection from the secondary server to the primary to save the fingerprint
  1. Sign in as the `postgres`: `su postgres`
     - The password should be the same as the server password
  1. Check that there is a 'main' cluster on the server: `pg_lsclusters`
     - If there isn't create a new cluster called 'main' like so: `pg_createcluster 14 main`
  1. Stop the cluster if it is running:
     - Log out of the postgres user: `exit`
     - Stop the cluster: `sudo systemctl stop postgresql`
  1. Sign in as the `postgres` again: `su postgres`
  1. Remove all of the files in the data directory: `rm -rv /var/lib/postgresql/14/main/`
  1. Start replicating from the primary server: `pg_basebackup -h 10.2.88.43 -U secondary -X stream -C -S <replica slot name> -v -R -W -D /var/lib/postgresql/14/main/`
     - `-h`: Host, the IP address of the primary server
     - `-U`: Replication user, the user `secondary` which we created on the primary server
     - `-X`: Stream value tells `pg_basebackup` to stream from the primary server
     - `-C`: Creates a replication slot
     - `-S`: Names the replication slot, this can be called anything. `replica_1` for example.
     - `-v`: Prints verbose output of the process
     - `-R`: Instructs server to operate as standby server for the primary server
     - `-W`: Prompts to provide password for the replication user `secondary`
     - `-D`: The directory for the backed up files
  1. Log out of the postgres user: `exit`
  1. Start the cluster: `sudo systemctl start postgresql`
  1. Verify that the primary server is streaming to the secondary server. On the primary server:
     1. Open the postgres command line interface as the postgres user: `sudo -u postgres psql`
     1. Enter and run the query `SELECT client_addr, state FROM pg_stat_replication;`
     1. There should be one row with the IP address of the secondary server and state as `streaming`
  1. Verify that the secondary server is mirroring the data in the primary server. On the secondary server:
     1. Open the postgres command line interface as the postgres user: `sudo -u postgres psql`
     1. Run some queries on the database and see if the output matches the same queries on the primary server.
     1. Alternatively: run queries through [pgAdmin](http://contentservice.wtg.zone:8082/browser/).
  1. Setup regular backups on the secondary server:
     1. Sign in as the `postgres`: `su postgres`
     1. Copy the backup scripts to the home directory of the postgres user `/var/lib/postgresql/`
        - [dump_backup.sh](https://devops.wisetechglobal.com/wtg/BorderWise/_wiki/wikis/BorderWise.wiki/4243/Backup-Scripts?anchor=dump_backup.sh) ([Original source](http://tfs.wtg.zone:8080/tfs/CargoWise/BorderWise/_git/content_service_documents?path=%2Fdatabase%2Fpostgresql%2Fscripts%2Fdump_backup.sh&version=GBmaster))
        - [invoke_backup_cleaner.sh](https://devops.wisetechglobal.com/wtg/BorderWise/_wiki/wikis/BorderWise.wiki/4243/Backup-Scripts?anchor=invoke_backup_cleaner.sh) ([Original source](http://tfs.wtg.zone:8080/tfs/CargoWise/BorderWise/_git/content_service_documents?path=%2Fdatabase%2Fpostgresql%2Fscripts%2Finvoke_backup_cleaner.sh&version=GBmaster))
        - [backup_cleaner.py](https://devops.wisetechglobal.com/wtg/BorderWise/_wiki/wikis/BorderWise.wiki/4243/Backup-Scripts?anchor=backup_cleaner.py) ([Original source](http://tfs.wtg.zone:8080/tfs/CargoWise/BorderWise/_git/content_service?path=%2Fcs%2Fscripts%2Fbackup_cleaner.py&version=GBmaster))
     1. Create a `dumps` directory `/var/lib/postgresql/dumps/`
     1. Make sure that the scripts have executable rights and the `dumps` directory has writable rights
     1. Set up cron jobs: `crontab -e`

        ```
        # m  h    dom mon dow   command
        0    */3  *   *   *     /var/lib/postgresql/dump_backup.sh
        0    2    *   *   *     /var/lib/postgresql/invoke_backup_cleaner.sh
        ```
        - Runs `dump_backup.sh` every 3 hours
        - Runs `invoke_backup_cleaner.sh` every day on the second hour of the day

  - [Replication instruction inspired by this](https://www.cherryservers.com/blog/how-to-set-up-postgresql-database-replication)

### Recover From Backup

1. Copy most recent backup zip to the data directory of the cluster you want to recover
   - Backup zips are stored on the secondary server at `/var/lib/postgresql/dumps/`
1. Extract it using `tar -xvf <backup>.tar.gz`
1. Move the extracted contents up into the data directory: `mv <backup>/* <data directory>`
   - This should give an error for some sub-directories which cannot be overridden since they have existing files in them
1. Empty the failed directories in the data directory: `rm -r <failed directory>/*`
1. Run the move command again: ``mv <backup>/* <data directory>`
1. Remove `standby.signal` if it is in the data directory
1. Start the cluster

### Steps if Primary Goes Down

1. Update the connection strings in WebWatcher BE to point to the secondary server
   - Update both `Backend/src/WebApi/publish.appsettings.Production.json` and `Backend/src/Scheduler/publish.appsettings.Production.json`
1. On the secondary server:
   1. Stop the cluster if it is running: `sudo systemctl stop postgresql`
   1. Update the config file to enable connections if it hasn't been already: `/etc/postgresql/14/main/postgresql.conf`
      - Set `listen_addresses = '*'`
   1. Update the authentication config file to allow connections if it hasn't been already `/etc/postgresql/14/main/pg_hba.conf`. Add the following lines to the end of the file:
      - `host	webwatcher	webwatcher	10.2.67.111/32	md5` (To allow WebWatcher BE to connect to the webwatcher database as the webwatcher user)
      - `host	webwatcher	webwatcher	10.2.67.112/32	md5` (To allow WebWatcher BE to connect to the webwatcher database as the webwatcher user)
   1. Start the cluster: `sudo systemctl start postgresql`
   1. Sign in as the `postgres` again: `su postgres`
   1. Promote the cluster to no longer run in standby mode: `pg_ctlcluster 14 main promote`
      - If this is not done the cluster will be read-only
1. Deploy the updated connection strings to WebWatcher production
1. Fix the primary server and restore its database
   - Can use a backup from `/var/lib/postgresql/dumps/` on the secondary server or from somewhere else
1. Revert the changes to the connection string in WebWatcher BE so that they point back to the primary server
1. Deploy the reverted connection strings
1. Set up replication on the secondary server again following the instructions from above


### Password rotation

Generate a new password.
1. Generate new password using the password generator on https://safe.wisetechglobal.com [Use the WTG_SVC_Account settings]
2. Update the password on https://safe.wisetechglobal.com
3. Encrypt the password for use on DAT by running the following command in Powershell
  - `$plaintext = (Read-Host -Prompt "Enter text to encrypt"); $plaintextBytes = [System.Text.Encoding]::UTF8.GetBytes($plaintext); $crypto = [System.Security.Cryptography.RSACryptoServiceProvider]::new(); try { $crypto.FromXmlString("<RSAKeyValue><Modulus>uJFr8lEdDZ6fUXQTiwKRVMrhS7t4oR6/eCuajCQARwIjO3v46HPefEgyMFC6uxGyQg+S7n4xAIfN5a4Ax5yimn5XQNamxgNRQpBQ5mcrGx7r/vRfLqUtt54N4pgwq77arJEMJDEtU+B3wjF+5bMUE1gHmc3Cs5XzGwWbFLHMmWk=</Modulus><Exponent>AQAB</Exponent></RSAKeyValue>"); $encrypted = $crypto.Encrypt($plaintextBytes, $true); Write-Host ([Convert]::ToBase64String($encrypted)) } finally { $crypto.Dispose() }`
  - See this article on [StackOverflow](https://wisetechglobal.sharepoint.com/sites/StackOverflow/questions/Forms/AllItems.aspx?id=%2Fsites%2FStackOverflow%2Fquestions%2F2929%2Emd&parent=%2Fsites%2FStackOverflow%2Fquestions) for more detail

4. Update WebWatcher\Deployment\Deployment\WebWatcherConfigFileUpdater.cs with the new plaintext encrypted password generated in step 2
5. After CH0 finished
   - Update postgresql server password
   - Restart postgresql process
   - Deploy new build on Crikey