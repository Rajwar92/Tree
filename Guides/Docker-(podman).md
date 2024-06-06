Following are my posts from [Containerization and orchestrators](https://teams.microsoft.com/l/channel/19%3af688e324fd7548a48d9ccc2efd5db5fb%40thread.tacv2/Containerization%2520and%2520orchestrators?groupId=0d1bbfab-c584-4034-a891-78ccf9de71b4&tenantId=8b493985-e1b4-4b95-ade6-98acafdbdb01) MS Teams channel. Hopefully they will help you set up Docker/Podman on local.

---

So as I've [shared recently](https://stackoverflow.com/c/wisetechglobal/a/10269/250 "https://stackoverflow.com/c/wisetechglobal/a/10269/250") I'm switching to WTG laptop instead of personal PC due to performance reasons.

And I don't have Docker Desktop on WTG laptop, so I decided to give Podman a try.

Since I'm using WSL for performance reasons, I will be using Podman in WSL as well, not in Windows.

As soon as I figured out that we need to install podman from Kubic repository to get the latest version - it was smooth sailing. Just changed docker in my commands to podman and it works.

A quick guide:

1. Follow [instructions](https://web.archive.org/web/20240112131221/https://podman.io/docs/installation) (follow the instructions under "If you would prefer newer...") to install podman from Kubic repository (NOT from official repositories) (**important!**, [see why](https://github.com/containers/podman/discussions/15586#discussioncomment-3725602 "https://github.com/containers/podman/discussions/15586#discussioncomment-3725602"))
1. Run `sudo apt install podman-docker` - to get docker=podman alias working even outside of bash (in scripts/tests that is)
1. Run `docker login -u <username> -p <password> -v docker.io` (need to sign up for account on [docker website](https://docker.io "https://docker.io") and use credentials here )
1. Edit `/etc/containers/registries.conf` and make sure that `short-name-mode="permissive"` (will need sudo privileges to write changes)
1. Replace host.docker.internal with host.containers.internal - if you use it somewhere to reference host machine IP (won't work with podman v3 from official repo, need v4 from Kubic repo, [see](https://github.com/containers/podman/discussions/15586#discussioncomment-3725602 "https://github.com/containers/podman/discussions/15586#discussioncomment-3725602"))
1. To run `docker-rebuild-and-run.sh` locally you might need to update references to `%%API_HTTP_HOST%%` to a real URL.

**Note for Running Docker.spec tests** - Make sure you run `npm ci` and `npm run build-dev` beforehand

---

Hi guys,

When installing podman in Ubuntu, make sure to use Kubic repository (endorsed by podman) because it has the latest version (v4). While the official Ubuntu repository has a way outdated podman v3. (Note: This may no longer be a problem by 25/04/2024 when the new Ubuntu LTS comes out)

Instructions: <https://podman.io/getting-started/installation#ubuntu>

Credits: <https://github.com/containers/podman/discussions/15586#discussioncomment-3725602>

Also I've updated the guide above:

- added podman-docker package for setting up the alias
- removed registry config, because v4 comes with all the registries pre-configured
- removed notes about network issues as they are completely resolved by using v4

Cheers!

---

If you ever need **docker-compose** - use https://github.com/containers/podman-compose instead