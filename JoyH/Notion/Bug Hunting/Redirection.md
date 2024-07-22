# **Server-Side Redirects:**
- *Description:* ==Server-side redirects== are initiated by the ==web server== before the page content is sent to the browser. The server sends an HTTP response with a status code that indicates a redirect, along with the new location (URL) to which the browser should navigate.
- *Common Status Codes:* Common server-side redirect status codes include 301 (Permanent Redirect) and 302 (Temporary Redirect). These codes are part of the HTTP response header.
- *Example (HTTP header):*

# **Client-Side Redirects:**
- *Description:* Client-side redirects are initiated by the browser or by JavaScript running on the client side after the initial page has been loaded. They are often used for dynamic navigation within a single-page application (SPA) or to redirect users after certain client-side events.
- *Common Methods:* Client-side redirects can be achieved using JavaScript, the `window.location` object, or by modifying the HTML `meta` tag.
- *Example (JavaScript):*
```javascript
// Using JavaScript for client-side redirect
window.location.href = "https://new-site.com";
```

```html
<!-- Using meta tag for client-side redirect after 5 seconds -->
<meta http-equiv="refresh" content="5;url=https://new-site.com">

```


**Key Differences:**

- _Timing of Execution:_
    - _Server-Side Redirects:_ Occur during the initial request-response cycle before the page content is sent to the browser.
    - _Client-Side Redirects:_ Occur after the initial page has been loaded, often in response to user interactions or JavaScript events.
- _Initiation Source:_
    - _Server-Side Redirects:_ Initiated by the web server based on server-side configurations or rules.
    - _Client-Side Redirects:_ Initiated by the browser or by client-side scripts (e.g., JavaScript).
- _Visibility to Users:_
    - _Server-Side Redirects:_ Users can typically see the redirect in the browser's address bar.
    - _Client-Side Redirects:_ Users may or may not see the redirect in the address bar, depending on how it's implemented.
