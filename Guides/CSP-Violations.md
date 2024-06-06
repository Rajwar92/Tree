# Getting Started

1. Use [csp-reports-analyzer](https://devops.wisetechglobal.com/wtg/BorderWise/_git/DevTools?version=GBMMZ%2Fcsp&path=%2Ftools%2Fcsp-reports-analyzer) to find new issues, aggregate them, group, etc. Github Copilot helps a lot.
2. Check out [Known issues](#known-issues)

**Pro Tip**: for checking all the content for 3rd party images of base64 data usage, you can use [mongo-html-checker](https://devops.wisetechglobal.com/wtg/BorderWise/_git/DevTools?version=GBMMZ%2Fcsp&path=%2Ftools%2Fmongo-html-checker)

# Known issues

Note, that this is an exert from Maxim Mazurok's Obsidian, so internal links might not work, but should be good enough

- Images from `wcotradetools.org` - fixed by manual team
	- [x] Double check all other content for `src="h...`, etc.
	- Examples:
		- https://www.wcotradetools.org/sites/default/files/nomenclature/inline-images/explanatory-notes/0629_2942_en_2017_fichiers/image001.png
		- https://www.wcotradetools.org/sites/default/files/nomenclature/inline-images/explanatory-notes/0629_2942_en_2017_fichiers/image138.png
		- https://www.wcotradetools.org/s3/global/wco/hsnotes/2022/images/explanatory-notes/0629_2942_en_2017_fichiers/image138.png
		- https://www.wcotradetools.org/sites/default/files/nomenclature/inline-images/explanatory-notes/0629_2925_en_2017_fichiers/image001.gif
		- https://www.wcotradetools.org/sites/default/files/nomenclature/inline-images/explanatory-notes/0739_3905_en_2017_fichiers/image001.gif
		- https://www.wcotradetools.org/sites/default/files/nomenclature/inline-images/explanatory-notes/0629_2924_en_2017_fichiers/image001.gif
- `fonts.gstatic.cn` - legit Google fonts for China, allowed
	- Examples:
		- https://fonts.gstatic.cn/s/roboto/v30/KFOkCnqEu92Fr1Mu51xIIzIXKMny.woff2
		- https://fonts.gstatic.cn/s/roboto/v30/KFOlCnqEu92Fr1MmYUtfChc4AMP6lbBP.woff2
		- https://fonts.gstatic.cn/s/roboto/v30/KFOlCnqEu92Fr1MmSU5fABc4AMP6lbBP.woff2
		- etc.
- `collinsdictionary.com` - looks like some plugin used for translations/definitions?
	- Examples:
		- https://www.collinsdictionary.com/external/images/info.png?version=5.0.34
		- https://www.collinsdictionary.com/external/images/info.png?version=5.0.35
		- https://www.collinsdictionary.com/external/images/info.png?version=5.0.37
		- https://www.collinsdictionary.com/external/images/lbcefrb/a2.png?version=5.0.35
		- https://www.collinsdictionary.com/external/images/lbcefrb/b1plus.png?version=5.0.34
		- https://www.collinsdictionary.com/external/images/lbcefrb/b2.png?version=5.0.35
- Already allowed, weird:
	- `sentry.io
		- Examples:
			- https://o827986.ingest.sentry.io/api/5818829/envelope/?sentry_key=dfc9b7af16364687a712017b52545d52&sentry_version=7
	- `hotjar.io`
		- Examples:
			- https://metrics.hotjar.io/?v=6
			- https://static.hotjar.com/c/hotjar-3657851.js?sv=6
	- `borderwise.com`
		- Examples:
			- https://app.borderwise.com/api/error-report/frontend-issue
			- https://app.borderwise.com/api/host/version
			- https://app.borderwise.com/api/v1/library/au/tariff-tabs?heading=9404&tariffType=IMP&year=2022
			- https://app.borderwise.com/api/v1/library/books/61a856726b37123a14272d2a/timestamp
			- https://app.borderwise.com/api/v1/user/license/status/5b40bb5553d34c027765d6140529725b/
			- https://app.borderwise.com/api/v1/user/search-history
			- https://app.borderwise.com/app/templates/common/generic-tariff-tabs-container.html?v=1702526785863
			- https://app.borderwise.com/assets/css/style.hsnotes.min.6801e23b.css
			- https://app.borderwise.com/manifest.webmanifest
	- `googletagmanager.com` - no idea ;(
		- Theory was: if it's blocked using redirect to non-whitelisted domain it will trigger CSP, but it is probably wrong theory because final destination URL will be reported, not the original one
		- Example: https://www.googletagmanager.com/gtag/js?id=G-EVQQLXSL5E
- `cs.hae123.cn` - might be extension, users likely not affected
	- From `fatkun-pro-mv` in URL I found [Fatkun Batch Download Image](https://chromewebstore.google.com/detail/efcapamiilmdfbbilogcddbdckjhpajj) Chrome extension, seems pretty legit and couldn't reproduce the issue
	- Only happened on login page, might be some bots...
	- Examples:
		- https://cs.hae123.cn/gw?name=fatkun-pro-mv3&uid=7da14c81d7284d9e84cc898b70bf214e
- `baidu.com` - likely ads from malware
	- Params from URL: "con**wid**=240&con**hei**=350" suggest it's width and height of the ad?
	- See [malware verdict](https://any.run/report/11a5f0657fb8c59ffae17c0911d0d3a3c3f7fe719485edfdd8bfedf777c9f7ed/cc35831f-b102-4391-ae1d-e0814b16ab91#i-table-processes-79421450-9951-4011-8fdb-26a08d8304e1) for the same URL as we see in logs
	- Examples:
		- https://pos.baidu.com/dcsm?conwid=240&conhei=350&rdid=6818871&dc=3&di=u6818871&s1=2839721755&dtm=HTML_POST
- `alicdn.com` - reliability monitoring, **could affect user experience in CN**
	- Seems like it detects blank/white pages, most likely part of Alibaba Cloud performance/reliability monitoring. Potentially might be used to report/fix pages with resources unavailable in China? I guess we don't really need it
	- Example: `https://g.alicdn.com/woodpeckerx/itrace-next/??itrace-blank.iife.js`
- `login.microsoftonline.com` - because Sentry is blocked
	- I guess it's most likely related to sentry domain being blocked by security
	- Looks like a legit login for [Toll Group](https://www.tollgroup.com/) based on background image
	- [[Dmitry Kislov]] said "we don’t have SSO redirects yet but will soon have for WTG users"
	- Once url-decoded, `SAMLRequest` part can be decoded using https://www.samltool.com/decode.php, looks like this:
		```xml
		<?xml version="1.0"?>
		<AuthnRequest xmlns="urn:oasis:names:tc:SAML:2.0:protocol" Version="2.0"
			ID="_913cf84de6779bcba0ff358c3aef9514f893a8f069862e2714b2b2bcf3d2f947"
			IssueInstant="2023-12-14T22:00:59Z">
			<Issuer xmlns="urn:oasis:names:tc:SAML:2.0:assertion">
				https://saml.threatpulse.net:8443/saml/saml_realm</Issuer>
		</AuthnRequest>
		```
	- `RelayState` is base64 encoded `ocs=https://o827986.ingest.sentry.io/api/5818829/envelope/?sentry_key=dfc9b7af16364687a712017b52545d52&sentry_version=7,` in all examples
	- Examples:
		- https://login.microsoftonline.com/0f004b2e-fb07-45e7-a568-caf4905b0339/saml2?SAMLRequest=jZA7a8QwEIT7%2BxVG%2Fdl6%2BSFh%2BzhIc5A0SUiR5pB1K3xgy45WDvn5EQ6BlGFhi53h22Ha09c8ZZ8Q8L74jrCcklN%2FaM9bHP0zfGyAMUsOjx3ZgteLwTtqb2ZAHa1%2BOT89ap5TvYYlLnaZSPb2i0pnkl0eOnJVTFjXyBtUda0GOxjqnCgbKww4VTLpGiVM42ilmooDr5kceBrrxI07JeuEQdzg4jEaHxOZcnFk%2FMjkK%2BeaUl2qd9K3uyn8J61BhBBTStKPMa6oiwLNPOVxDGDiuk0IuYeoGynFruzrmsRpboufP31b%2FC2pP3wD&RelayState=b2NzPWh0dHBzOi8vbzgyNzk4Ni5pbmdlc3Quc2VudHJ5LmlvL2FwaS81ODE4ODI5L2VudmVsb3BlLz9zZW50cnlfa2V5PWRmYzliN2FmMTYzNjQ2ODdhNzEyMDE3YjUyNTQ1ZDUyJnNlbnRyeV92ZXJzaW9uPTcs
		- https://login.microsoftonline.com/0f004b2e-fb07-45e7-a568-caf4905b0339/saml2?SAMLRequest=jZAxa8MwEIX3%2FAqjPbYky7YsbIdAlkC7tKVDl6BIMg7YsqM7h%2F78qi6Fjl0O7t7ju8drDp%2FTmDxcgNvsW8JSSg7drjmuOPgXd18dYBIdHlqyBq9mDTdQXk8OFBr1enx%2BUjylagkzzmYeSfL%2Bi4pnkpxPLbkYlltbWylkrjXrWW8LV0lem8rUvCzjJqkRheivdV0wKazk1ljj7LUqaSW%2BMQCrO3tA7TGSKc%2F3jO85e%2BNMFVxR9kG6ZjOF%2F6TVAC5gTEm6AXEBlWWgpzHFITiNyzqCS71DJYXIN2UblyiOU5P9%2FOma7G9J3e4L&RelayState=b2NzPWh0dHBzOi8vbzgyNzk4Ni5pbmdlc3Quc2VudHJ5LmlvL2FwaS81ODE4ODI5L2VudmVsb3BlLz9zZW50cnlfa2V5PWRmYzliN2FmMTYzNjQ2ODdhNzEyMDE3YjUyNTQ1ZDUyJnNlbnRyeV92ZXJzaW9uPTcs
		- https://login.microsoftonline.com/0f004b2e-fb07-45e7-a568-caf4905b0339/saml2?SAMLRequest=jZAxa8MwFIT3%2FAqjPbYky0okbIdAl0C6tKVDlyDLEg7Ysqv3HPrzK1wKHbvc8O747nj16Wsas4eLcJ9DQ1hOyand1ecVh%2FDiPlcHmKVEgIasMejZwB10MJMDjVa%2Fnp%2BvmudUL3HG2c4jyd5%2FUelMsstTQ27CW6G6ikmpjKS%2Bkp0yJRPG%2BL7nvKdcdlIpJaQtbcl6dvDMV4Iy6QU9uAQBWN0lAJqAiUt5uWd8z49vnGmhNBMfpK23UPzPVgPgIqaNpB0QF9BFAWYacxyiM7isI7g8ONRHIcrN2eSWzHGqi5%2Beti7%2BvqjdfQM%3D&RelayState=b2NzPWh0dHBzOi8vbzgyNzk4Ni5pbmdlc3Quc2VudHJ5LmlvL2FwaS81ODE4ODI5L2VudmVsb3BlLz9zZW50cnlfa2V5PWRmYzliN2FmMTYzNjQ2ODdhNzEyMDE3YjUyNTQ1ZDUyJnNlbnRyeV92ZXJzaW9uPTcs
- `trendmicro.com` - [Trend Micro's Password Manager](https://pwm.trendmicro.com/) - **could affect user experience**
	- Examples:
		- https://pwm-image.trendmicro.com
		- https://pwm-image.trendmicro.com/5.8/extensionFrame/styles/engineV3.css
- `effirst.com` - mobile apps monitoring platform in CN
	- Alibaba mobile applications monitoring platform, happened once on login, users likely not affected
	- Examples:
		- https://px.effirst.com/api/v1/jssdk/upload?wpk-header=app%3D9zxuc2j4-4ogpwyg4%26cp%3Dnone%26de%3D4%26seq%3D1702623996903%26tm%3D1702623996%26ud%3Dc4a9cfcc-782c-4420-92af-c774019af6ba%26ver%3D%26type%3Dflow%26sver%3D2.3.4%26sign%3D9bf8a190ef82c5049df7b199c599c45b&uc_param_str=prveosfrnwutmisv&data=%7B%22uid%22%3A%22%22%2C%22wid%22%3A%22c4a9cfcc-782c-4420-92af-c774019af6ba%22%2C%22type%22%3A%22flow%22%2C%22category%22%3A5%2C%22w_cnt%22%3A1%2C%22w_rel%22%3A%22%22%2C%22w_bid%22%3A%229zxuc2j4-4ogpwyg4%22%2C%22w_cid%22%3A%22%22%2C%22w_spa%22%3Afalse%2C%22w_frmid%22%3A%2272c6aa58-8eb2-45e2-2e68-f3244f481c3d%22%2C%22w_tm%22%3A1702623996897%2C%22log_src%22%3A%22jssdk%22%2C%22sdk_ver%22%3A%222.3.4%22%2C%22w_url%22%3A%22https%3A%2F%2Fapp.borderwise.com%2Faccount%2Flogin%22%2C%22w_query%22%3A%22%22%2C%22w_ref%22%3A%22%22%2C%22w_title%22%3A%22BorderWise%22%2C%22ua%22%3A%22Mozilla%2F5.0%20(iPhone%3B%20CPU%20iPhone%20OS%2017_0_3%20like%20Mac%20OS%20X%3B%20zh-cn)%20AppleWebKit%2F601.1.46%20(KHTML%2C%20like%20Gecko)%20Mobile%2F21A360%20Quark%2F6.7.7.1942%20Mobile%22%2C%22referrer%22%3A%22https%3A%2F%2Fapp.borderwise.com%2F%22%2C%22dsp_dpi%22%3A3%2C%22dsp_w%22%3A393%2C%22dsp_h%22%3A852%2C%22net%22%3A%22%22%2C%22w_send_mode%22%3A%22img%22%7D
- `tql.com` - most likely some Truckload corporate extension...
	- Resources are likely from tql.com intranet
	- Examples:
		- https://svcs.tql.com/CrossReferenceContent/libraries/bootstrap/fonts/glyphicons-halflings-regular.ttf
		- https://svcs.tql.com/CrossReferenceContent/libraries/bootstrap/fonts/glyphicons-halflings-regular.woff
		- https://svcs.tql.com/CrossReferenceContent/libraries/bootstrap/fonts/glyphicons-halflings-regular.woff2
- `data` 
	- Login and app pages, including with `authtoken` param
	- Violated directives:
		- `font-src` - we don't load fonts using data, none of the content does it either
		- `media-src` - only for `<audio>` and `<video>` which we don't use, I checked
	- Source files:
		- `googletagmanager.com/gtag/js` - only `font-src` violated, kinda weird, it doesn't show anything, likely some proxy error response
		- Empty - violates both `font-src` and `media-src`; Empty source means inline stuff or eval
	- Checked all content for all possibilities of data, didn't find anything, so it all must be coming from unknown 3rd party sources like extensions, etc.
	- [x] Finish checking all fields recursively (for direct books, etc.) for known issues
		- [x] src="http...
		- [x] src="???
		- [x] audio/video/track
		- [x] `data:font`
