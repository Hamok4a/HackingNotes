  

so the payloads of XSS till now are

1. `<script>alert(window.origin)</script>`
2. `<script><plaintext></script>`
3. `<script>print()</script>`
4. `<script>alert(document.cookie)</script>`

# Introduction for XSS

- cross-site-scripting vulnerabilities .
- i think that xss are bunch of vulenrabilies not just one .
- the XSS vulnerabilities → takes advantage of a flaw in user input sanitization (filterization )
- in another words the developer who programed the web app didnot manage the input place right so we then send
    
    - maliciouse codes written in JavaScript and using them we can do many things .
        - steal users cookies and using them we can enter without signing in
        - or redirect users to another pages
        - or make users download files that are dangerouse that makes us manipulate their devices .
        - API calls that lead to maliciouse actions like :
            - changing the user’s password to a password of the attackers choosing .
            
        - if we could aschive admin account and had his abilies we will be like having the site working for us .
        - write JS code and excute it on the client side , leading to several types of attacks .
    
      
    
      
    

  

- what is XSS ?
    
    - the typical web application works by :
        - recieving the HTML code from the back-end server .
        - then render those HTML codes on the client-side (browser).
        - the Hacker acts as a user and then inputs a malicouse JS code in the input field and then
        - when a normal user visit this site..
        - the malicouse JS code will be excuted on his browser.
        
    
    ---
    
    ## Types of XSS
    
    There are three main types of XSS vulnerabilities:
    
    |   |   |
    |---|---|
    |Type|Description|
    |`Stored (Persistent) XSS`|The most critical type of XSS, which occurs when user input is  <br>stored on the back-end database and then displayed upon retrieval (e.g.,  <br>posts or comments)|
    |`Reflected (Non-Persistent) XSS`|Occurs when user input is displayed on the page after being  <br>processed by the backend server, but without being stored (e.g., search  <br>result or error message)|
    |`DOM-based XSS`|Another Non-Persistent XSS type that occurs when user input is  <br>directly shown in the browser and is completely processed on the  <br>client-side, without reaching the back-end server (e.g., through  <br>client-side HTTP parameters or anchor tags)|
    
      
    
    💡
    
    what is the difference between (stored , reflectted and DOM )XSS
    
    - we will see the difference to knew :
    - which to use in which attack:
    
    # Stored XSS:
    
    ## how to Discover Stored XSS vulnerabilities:
    
    1. Stored XSS :
        
        1. if the injected XSS payload is stored in the back-end database and retrived upon visiting the page
        2. this will mean that our XSS attack is presistent and may affect any user that visits the page .
        3. and thats why the stored XSS type is the most critical type .
        4. mroe than the harm it casue the stored XSS is hard to be deleted as it requires to be removed by the back-end database.
        
          
        
        💡
        
        we can test if the website is infected by XSS vulenerabilties by just using this simple code in the input bar …
        
        ```
        <script>alert(window.origin)</script>
        As some modern browsers may block the 
        alert() JavaScript function in specific 
        locations, it may be handy to know a few
         other basic XSS payloads to verify the 
        existence of XSS. One such XSS payload is
         <plaintext>, which will stop rendering 
        the HTML code that comes after it and display
         it as plaintext. Another easy-to-spot payload 
        is <script>print()</script> that will pop up the
         browser print dialog, which is unlikely to be 
        blocked by any browsers.
         Try using these payloads to see how each works.
         You may use the reset button to remove any current payloads.
        ```
        
    
    ## how to utilize Stored XSS vulnerabilities for various attacks :
    
      
    
    so the payloads of XSS till now are
    
    1. `<script>alert(window.origin)</script>`
    2. `<script><plaintext></script>`
    3. `<script>print()</script>`
    4. `<script>alert(document.cookie)</script>`
    
    # Reflected XSS:
    
    There are two types of `Non-Persistent XSS` vulnerabilities: `Reflected XSS`, which gets processed by the back-end server, and `DOM-based XSS`, which is completely processed on the client-side and never reaches the back-end server.
    
    ## Non-presistent XSS :
    
    - this depends on which HTTP request Method.
    - is used to send our input to the server we can check this through the [developer tools] by clicking ctlr + I and selecting Network tab then we can put our test payload again and click add to send it .
    - the request was get for this example so this means that the request sends their parameters adn data as a part of the url
    - so to target a user we just send him a url containing a payload in its url .
        
        - this is available for us to make if the HTTP request Method is GET.
        
        💡
        
        we can by easily way → go to the devtools/network_tab and then after we click add to our task whatever it is we will find that a new HTTP request is sent from our device we will see that on the network tab and by doing that we will have the ability to just click on this new http request that we saw using GET as a method and of course we will not be just wrote any thing in the tasks place and then press add no we will type the whole payload that we want to run on the target and by doing this we will just copy the http request that we will find that it appears in the network tab when we click add button on our page . then by send ing this link to the victum he will be forwarded to the website and then he will not knew but the payload will beexcuted on his webbrowser and pol.aaaaaa.
        
          
        
    
    # Dom XSS:
    
    - it is also a non-presistant type
    - called DOM-based XSS
    - while the reflected XSS is reflected to the back end server through the HTTP requests , the Dom XSS is completely processed on the client server through JavaScript
    - when does Dom XSS occurs ?
        - dom XSS occurs when JS is used to change the page source through the dom
    - in the dom xss we dont find in the network tab a HTTP request .
    - the input parameter in the is using a hashtag # for the item we added , which means that this is a client-side parameter that is completely processed on the browser.This indicates that the input is being processed at the client-side through JS and never reaches the back end ; hence it is a DOM based XSS.
    
    - If the `Sink` function does not properly sanitize the  
        user input, it would be vulnerable to an XSS attack. Some of the  
        commonly used JavaScript functions to write to DOM objects are:
        
        - `document.write()`
        - `DOM.innerHTML`
        - `DOM.outerHTML`
        
          
        
    
    ## DOM ATTACKs:
    
    to use and find XSS Dom vulenrability use this :
    
    `<img src="" onerror=alert(window.origin)>`
    
      
    

## XSS Discovery:

- so we must always manually verify the XSS injection.
    
    Some of the common open-source tools that can assist us in XSS discovery are [XSS Strike](https://github.com/s0md3v/XSStrike), [Brute XSS](https://github.com/rajeshmajumdar/BruteXSS), and [XSSer](https://github.com/epsylon/xsser). We can try `XSS Strike` by cloning it to our VM with `git clone`:
    
- so the tools that can automatically detect XSS vulnerabilites are :
    
    1. XSS Strike
    2. Brute XSS
    3. XSSer
    
      
    

---

## What is the diff between Dom and Reflected XSS??

reflected : the data are taken from http req and payloaded into the response

dom : the data are put into the js source and modified to work there

  

they ‘re both writtin in the Js as a payload lang.

## What is Dom-based cross-site scripting?

- the DOM arises when java script takes data from an attacker-controllable source
- such as the url
- and pass those data that are taken via the js pass them to a sink that support dynamic code excution

💡

so till now : js → takes data from attacker such as url

💡

so till now : js → send those attackers payloads to be excuted in a sink that excutes them

![[Untitled.png]]

  

- eval() and innerHTML → they are both ( sinks that enables attackers to execute malicious JS payloads which allow the attackers to hijack other user’s accounts .
- What is Sink ?
    
    A "sink" in this context refers to a function or method that can execute or render data in a way that might be unsafe. In the case of DOM-based XSS, a sink might be a JavaScript function or property like `eval()` or `innerHTML` that can execute or embed untrusted data as code.
    
- to deliver a Dom -based attack : i need to put the maliciouse javascript into the source code so i will search for any gate to the source code like :
    
    In the context of a DOM-based XSS attack, a "source" refers to any input location from which data can be read by the application. Common sources include:
    
    1. The URL, including the query string (`location.search`).
    2. The URL fragment (`location.hash`).
    3. HTML form inputs.
    4. Cookies.
    5. Local or session storage.
    
    Attackers aim to inject malicious data into these sources in hopes that the application's JavaScript will read this data and pass it to a vulnerable sink, leading to the execution of the attacker's code.
    
      
    

## How to test for Dom-based corss-site scripting ?