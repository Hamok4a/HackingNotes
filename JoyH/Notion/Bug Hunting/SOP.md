### Same-Origin Policy (SOP) Study Notes

#### What is the Same-Origin Policy (SOP)?

- SOP is a web browser security mechanism that prevents websites from attacking each other.
- It restricts scripts on one origin from accessing data from another origin.
- An origin is defined by the combination of a URI scheme, domain, and port number.

#### Example: URL Breakdown

- URL: `http://normal-website.com/example/example.html`
    - Scheme: `http`
    - Domain: `normal-website.com`
    - Port: `80`

#### Access Permissions Based on SOP

|URL Accessed|Access Permitted?|
|---|---|
|`http://normal-website.com/example/`|Yes: same scheme, domain, and port|
|`http://normal-website.com/example2/`|Yes: same scheme, domain, and port|
|`https://normal-website.com/example/`|No: different scheme and port|
|`http://en.normal-website.com/example/`|No: different domain|
|`http://www.normal-website.com/example/`|No: different domain|
|`http://normal-website.com:8080/example/`|No: different port|

_Note: Internet Explorer does not consider the port number in SOP._

#### Why is SOP Necessary?

- Protects against unauthorized access to sensitive data.
- Prevents malicious websites from reading data such as emails from GMail or private messages from Facebook.

#### Implementation of SOP

- Controls JavaScript access to cross-domain content.
- [[Allows cross-origin loading of resources like images, media, and scripts but restricts JavaScript from reading these resources' contents.]]

#### [[Exceptions to SOP]]

1. **Writable but not readable cross-domain:**
    
    - `location` object
    - `location.href` property from iframes or new windows
2. **Readable but not writable cross-domain:**
    
    - `window.length` property (number of frames)
    - `window.closed` property
3. **Cross-domain function calls:**
    
    - `close`, `blur`, `focus` on new windows
    - `postMessage` function on iframes and new windows for sending messages between domains

#### Relaxing SOP with `document.domain`

- Allows relaxation of SOP within a specific domain, if it's part of the FQDN (full quality domain name).
- Example: `marketing.example.com` and `example.com` can set `document.domain` to `example.com` for mutual access.
- Modern browsers prevent setting `document.domain` to a TLD like `com`.

#### SOP and Cookies

- SOP is more relaxed for cookies, accessible across subdomains.
- Mitigation: Use the `HttpOnly` cookie flag to reduce risk.

These notes provide a concise yet comprehensive overview of the same-origin policy, essential for understanding and explaining this critical web security mechanism in an interview setting.