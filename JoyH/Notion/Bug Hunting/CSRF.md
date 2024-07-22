# Here we are going to talk about Cross Site Request Forgery 

## What is cross site request forgery ?
- a vulnerability that allows an attacker to send a link  to the victum , when the victum opens this link the victum unconsionsly send a request from his own account  to do something  that the attacker wants him to do (in another words it is just alink that do actions by the victum without there own knowledge )
- ![[Pasted image 20231125141751.png]]
- 
## How to  attack using cross site request forgery vulnerability ? 
- For a CSRF attack to be possible , three key conditions must be in place : 
 1. a relevant action : ( there is an actoin in the application that the attacker has a reason to induce such as changing email,name , password , critical info ->  modifying permissions for other users )
 2. Cookie-based session handling  : we need to understand that performing the action involves  issuing one or more HTTP  requests , and the application  relies solely on  session cookies ( sessions ) to identify the the user who has made the requests to change . 
 3. No unpredictable parameters in the request : the requests that perform the action do not contain  any parameters whose values the attacker cannot determine or guess. for example , when causing a user to change their password , the function is not vulnerable  if an attacker needs to know the value of the existing password . 
 
	HERE is an Example  that contains all the  conditions : 
	`POST /email/change HTTP/1.1 Host: vulnerable-website.com Content-Type: application/x-www-form-urlencoded Content-Length: 30 Cookie: session=yvthwsztyeQkAPzeQ5gHgTvlyxHfsAfE email=wiener@normal-user.com`
the attacker here can easily determine the values of the request parameters that are needed to perform the action with the following  HTML  code 


`<html> <body> <form action="https://vulnerable-website.com/email/change" method="POST"> <input type="hidden" name="email" value="pwned@evil-user.net" /> </form> <script> document.forms[0].submit(); </script> </body> </html>`


## Bypassing SameSite Cookie restrictions 
- same site is a browser security mechanism  that determines when a website's cookies are included in requests originating from other websites. 
- How  a SameSite cookie restriction works ? 
	- what is a site in the context of samesite cookies ? 
		- (.com & .net )sites  -> are both defined as TLD  ( top level domain ) sites 
		- + one additional level of the domain name which is revered to  as (TLD+1)
		- we take the URL scheme into our consideration  during the process of determining if the  request is a SameSite origin request this means that if https send a request to same site but (http) or vise versa  the request will be treated as  cross-site  request by most browsers. 
		- ![[Pasted image 20231126002817.png]]
	 - what is the difference between a ==site== and an ==origin== ? 
		 - the difference between a site and an origin is their scope . 
		 - a site encompasses multiple domain names . 
		 - an origin  only includes  one domain name . 
		 - so they are different from each other but the  site and the origin are both very related to each other . 
		 - okay so the word "site" is (less specific ) because it only refers to the scheme and the last part of the domain  .
		 - so by this we can say that cross-origin requests can be called same-site reuqest  but not the reverse 
		 - ex :(https://ahmed.google.com)(https://aya.google.com)  those two website are same-site but not same origin they are cross-origins
		 - https://aya.google.com:8080  vs  https://aya.google.com 
			 they will not be same-origin because of the port difference  so they will be cross-origin  but they are still same-site  as they both starts with same scheme and ends with same domain last part 
		- https://ahmed.google.com vs http://ahmed.google.com
			  they are not the same origin or even the same site because the ( scheme is dont the same ( https-http))
			  and this will happen also if they ( one is .com and the other is .co.uk for example)
  
   
   ## How to defense against CSRF ? 
the same site attribute is a security feature implemented in web browsers to mitigate the risk of cross site request forgery attacks  before samesite  , cookies  were sent automatically  with every request to the domain that issued  so if  you want to send a request to a domain  then the domain will need the cookie(csrf) that it already issued  ( produced) so by this way you need to be the same site ( domain) that in another words the domain puts a value in the csrf cookie when he send a request  so to make sure that it belongs to him he will look for the csrf cookie in the request that is going to be send to him  . 
same-site allows website owners to specify how cookies should be sent in corss-site request
==there are three possible values for the same-site attribute==  
1. **strict**: Cookies with this attribute will only be sent  in a first party-context . this means the cookie will only be sent if the request originates from the same site that set the cookie . 
2. **Lax**: cookies are sent with top-level navigation's  and same-site requests , but not with cross-site requests initiated  by third-party websites .
3. **None**: cookies are snet in all contexts , including cross-site requests . this is the least restrictive option and should be used with caution , as it opens up the potential for csrf attacks 
----
# Bypassing SameSite ==strict== restrictions 

## 1. Using on-site gadgets :
- if a cookie is set with `SameSite=strict`  attribute in the cookies section then -> browser will not include it in  cross-site  requests . 
- but we may be able to get around this limitation of strict  samesite attribute if we could find :
	- a gadget that results in a secondary request within the same site  
	- one possible gadget is a client-side  redirect that dynamically construct the redirection target using attacker-controllable input like url parameters . 
	- 

[[Redirection]]
- we used the Client-redirection as our first method to bypass the Same-Site strict attitude 
- the other method for the same_site strict  ( needs me to study websockets vulnerability because it will mix it with the csrf ) 

---
# Bypassing SameSite ==Lax== restrictions  

**two conditions for the browser to send the cookie in the LAX same_site restriction:**
1. The request should use the GET method
2. The request resulted from a top-level navigation  by the user , such as (clicking a link ) 
from those two conditions we can  understand that cookies  are not going to be found at the POST requests 
or even at any background requests . 
## Labs: 
- [[Bypassing SameSite Lax restrictions using GET requests]]
- [[Bypassing SameSite Lax restrictions with newly issued cookies]]
