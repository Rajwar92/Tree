Based on https://stackoverflow.com/a/42298344/4536543
1. `cd ~/BorderWiseWeb/Frontend/src`
1. `openssl req -x509 -newkey rsa:2048 -keyout keytmp.pem -out cert.pem -days 365 -passout pass:1234 -subj "/"` (passphrase `1234` and all default options)
1. `openssl rsa -in keytmp.pem -out key.pem -passin pass:1234` (passphrase `1234` from before)
1. In `src/http-server.js`:
    - replace `const http = require('http');` with `const https = require('https');`
    - replace `const server = http.createServer((req, res) => {` with `const server = https.createServer({ key: fs.readFileSync('./key.pem'), cert: fs.readFileSync('./cert.pem') }, (req, res) => {`
1. Run `npm run serve` as normal
1. In browser, open `https://localhost:3000`
1. When you see a warning - use "Advanced" -> "Proceed anyway" (on Chrome), see [more](https://www.technipages.com/google-chrome-bypass-your-connection-is-not-private-message/#:~:text=Option%201%20%E2%80%93%20Simply%20Proceed)

Notes:
- Sometimes it will be hanging in loading state, I think it has something to do with service worker, just do a hard reload Ctrl + Shift + R, I think it'll disable service worker and website will load
- If running `npm start` or `npm run build` - might have to disable `findUnusedFiles` task in gulp

---

To make it run like `app.borderwise.com` (WIP):

- add `127.0.0.1 app.borderwise.com` to widnows hosts file
- change `defaultBWWHostPort` to `443`
- use this to make `nvm` work in `sudo`: https://stackoverflow.com/a/40078875/4536543
- run `sudo npm start`