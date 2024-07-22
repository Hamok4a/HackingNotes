### Same-Origin Policy (SOP) Exceptions Study Notes

#### Exceptions to SOP

##### Writable but Not Readable Cross-Domain

1. **`location` Object:**
    
    - You can write to the `location` object to navigate to a different URL.
    - Example: `iframe.contentWindow.location = "http://another-website.com"`
2. **`location.href` Property:**
    
    - You can set the `href` property of the `location` object in iframes or new windows to change the URL.
    - Example: `iframe.contentWindow.location.href = "http://another-website.com"`

##### Readable but Not Writable Cross-Domain

1. **`window.length` Property:**
    
    - You can read the number of frames (iframes) within a window.
    - Example: `var numFrames = window.length;`
2. **`window.closed` Property:**
    
    - You can check if a window or tab has been closed.
    - Example: `var isClosed = window.closed;`

##### Cross-Domain Function Calls

1. **`close`, `blur`, `focus` on New Windows:**
    
    - You can call these functions to manage the state of a new window.
    - Example:
        
        javascript
        

- - `var newWindow = window.open("http://another-website.com"); newWindow.close();`
        
- **`postMessage` Function on Iframes and New Windows:**
    
    - You can send messages between different origins using `postMessage`.
    - Example:
        
        javascript
        

1. - `iframe.contentWindow.postMessage("Hello", "http://another-website.com");`
        

#### Relaxing SOP with `document.domain`

- **Purpose:**
    
    - Allows relaxation of SOP within a specific domain if it's part of the Fully Qualified Domain Name (FQDN).
- **How It Works:**
    
    - Example: `marketing.example.com` and `example.com` can set `document.domain` to `example.com` for mutual access.
    - Code:
        
        javascript
        

- - `document.domain = "example.com";`
        
- **Limitations:**
    
    - Modern browsers prevent setting `document.domain` to a Top-Level Domain (TLD) like `com`.

#### SOP and Cookies

- **Relaxation for Cookies:**
    
    - SOP is more relaxed for cookies, making them accessible across subdomains.
    - Example: Cookies set for `example.com` can be accessed by `sub.example.com`.
- **Mitigation:**
    
    - Use the `HttpOnly` cookie flag to reduce risk.
    - `HttpOnly` prevents JavaScript from accessing cookies, reducing the impact of cross-site scripting (XSS) attacks.

#### Comprehensive Overview of SOP

- These notes provide a concise yet comprehensive overview of the same-origin policy.
- Understanding these exceptions and methods to relax SOP is crucial for explaining this web security mechanism in an interview setting.