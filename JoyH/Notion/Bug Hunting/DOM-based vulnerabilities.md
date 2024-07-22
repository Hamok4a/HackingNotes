E	 `## What is the DOM?E3ZSQQZ                                                                  QSSszsqZDZE

// DOM = DOCUMENT OBJECT MODEL 
// Object{} that represents the page you see in the web browser 
// and provides you with an API to interact with it. 
// Web browser constructs the DOM when it loads an HTML document,
// and structures all the elements in a tree-like representation. 
// JavaScript can access the DOM to dynamically 
// change the content, structure, and style of a web page.
# What is DOM for portswigger ? 
- DOM is Document object model  
- It is a web browser’s hierarchical representation of the elements on the page 
- Website can use JS to manipulate  the nodes and objects of the DOM 
- As well as their properties .
- The Dom attacks  are arises when the website contains JS that takes a controllable values from the attacker ( user for the website )
- It is the ( source ) and ( sink )
# Taint-flow vulnerabilites 
- Many Dom based vulnerabilities can be traced back  to know that the cause of them are the way the client side code manipulates attacker–controllable data. 
# What is Taint-flow ? 
- To understand the taint-flow vulns we need to understand the taint flow at first  ( it make sense ) 
- The taint flow is a flow between  the source and the sink as i said in my notes . 
- The Source is a vuln JS property that  is takes input inside it from the attacker  
- The user  sink is  a  Function in JS that is potentially dangerous LIKE the eval () 
- Example of html sink is  `document. Body.innerHTML `
- Fundamentally dom based vulnerabilities arise when a website passes data
----
# Continue : 
- The most common source is the URL 
- The url is typically accessed by the  location object . 
- The attacker can build a link to  send the victim to a vulnerable page with payload in the query string and fragment portions of the url consider the following code : 
``` javascript
goto = location.hash.slice(1)
if (goto.startswith('https:')){location = goto;}
```
- This is vulnerable to DOM-based open redirection 
- Because the `location.hash` source is handled in an unsafe way.
- This is vulnerable to [DOM-based open redirection](https://portswigger.net/web-security/dom-based/open-redirection) because the `location.hash` source is handled in an unsafe way. If the URL contains a hash fragment that starts with `https:`, this code extracts the value of the `location.hash` property and sets it as the `location` property of the `window`. An attacker could exploit this vulnerability by constructing the following URL:

`https://www.innocent-website.com/example#https://www.evil-user.net`

When a victim visits this URL, the JavaScript sets the value of the `location` property to `https://www.evil-user.net`, which automatically redirects the victim to the malicious site. This behavior could easily be exploited to construct a phishing attack, for example.

### Common sources

The following are typical sources that can be used to exploit a variety of taint-flow vulnerabilities:

`document.URL document.documentURI document.URLUnencoded document.baseURI location document.cookie document.referrer window.name history.pushState history.replaceState localStorage sessionStorage IndexedDB (mozIndexedDB, webkitIndexedDB, msIndexedDB) Database`

The following kinds of data can also be used as sources to exploit taint-flow vulnerabilities:

- [Reflected data](https://portswigger.net/web-security/cross-site-scripting/dom-based#dom-xss-combined-with-reflected-and-stored-data) LABS
- [Stored data](https://portswigger.net/web-security/cross-site-scripting/dom-based#dom-xss-combined-with-reflected-and-stored-data) LABS
- [Web messages](https://portswigger.net/web-security/dom-based/controlling-the-web-message-source) LABS

### Which sinks can lead to DOM-based vulnerabilities?

The following list provides a quick overview of common DOM-based vulnerabilities and an example of a sink that can lead to each one. For a more comprehensive list of relevant sinks, please refer to the vulnerability-specific pages by clicking the links b
