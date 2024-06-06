# How we use Docker
**TLDR:** we have linux server that runs docker and we just SSH into it from DAT; On local we don't use it;

I believe that we have Docker CE installed on the server, which is fine in terms of license, as opposed to Docker Desktop.

When it comes to local development, we almost never use Docker.

When we do need to test/debug something - we either install Docker CE inside of WSL, or use Podman inside of WSL as well. We started with Podman, but Docker CE seems to work for me fine as well.

Here are some useful resources:

- [DockerDeployment](https://devops.wisetechglobal.com/wtg/BorderWise/_git/Common?path=%2FDeployment%2FDockerDeployment)
- [Docker (podman)](/Guides/Docker-\(podman\))
- [All Matters Linux - Linux Infrastructure Initiative | Containerization and orchestrators | Microsoft Teams](https://teams.microsoft.com/l/channel/19%3Af688e324fd7548a48d9ccc2efd5db5fb%40thread.tacv2/Containerization%20and%20orchestrators?groupId=0d1bbfab-c584-4034-a891-78ccf9de71b4&tenantId=8b493985-e1b4-4b95-ade6-98acafdbdb01)
- [nginx/docker tests](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb?path=%2FFrontend%2Fvue-elements%2Ftools%2Fdocker.skip.ts&_a=contents&version=GBmaster) - we have this test for nginx on docker, but we only enable and run it on local for now
