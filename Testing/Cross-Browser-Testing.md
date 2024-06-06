[Cross Browser Testing](https://developer.mozilla.org/en-US/docs/Learn/Tools_and_testing/Cross_browser_testing/Introduction) is the practice of ensuring that a website works across various browsers and devices.
There are multiple methods we can try to test cross-browser:

**1. Use cross-browser testing sites:**
* There are lots of cross-browser testing sites that we can find online.
* The most popular one would be [browserstack](https://www.browserstack.com/)
* Pros: Quick test, multiple browsers/versions/devices are ready to test
Cons: It's not free and the free trial only 1 minute testing (too short)
* Another site that has longer testing period (3 minutes) is [browserling](https://www.browserling.com/) but it's very limited on browsers/versions/devices

=> Big cons from testing sites are that we cannot test freely

**2. Download the exact browsers/versions/devices:**

2.1. Use [PortableApps](https://portableapps.com):
* We can [download PortableApps](https://portableapps.com/download) and then download [PortableApps files](https://sourceforge.net/projects/portableapps/files/) to install the one we want
For example: We can download [Chrome Portable files here](https://sourceforge.net/projects/portableapps/files/Google%20Chrome%20Portable/)
* Pros: Can test freely
Cons: For older versions, lots of files are unavailable so cannot install
For example, try [downloading Chrome v80.0.3987.87](https://sourceforge.net/projects/portableapps/files/Google%20Chrome%20Portable/GoogleChromePortable_80.0.3987.87_online.paf.exe/download), it will show the error `The installer was unable to download Google Chrome (Stable). The installation of the portable app will be incomplete without it. Please try installing again. (ERROR: File Not Found 404)` while installing.

2.2. Download exact version for Chromium:

2.2.1. Follow the instructions from [Chromium Wiki](https://www.chromium.org/getting-involved/download-chromium/)
Or follow the instructions from [this SO](https://stackoverflow.com/a/54927497/13079808)
=> Pros: Will be able to download much older version

2.2.2. Another way is following comment in the SO above, download from [chromium.cypress.io/](https://chromium.cypress.io/)
=> The links seem to all be official and you can filter by OS.