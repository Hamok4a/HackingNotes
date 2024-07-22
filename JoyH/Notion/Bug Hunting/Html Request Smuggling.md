# we are going to talk about 
- something called request smuggling  attacks 
- http request smuggling is techniques for interfering with the way a website processes sequence of request so it process the 2nd before the 1st and so on . 
- request smuggling is primarily associated with http/1
- However websites that are  using the http/2 may also be vulnerable to http request smuggling 
# what happens in an HTTP request smuggling attack ? 
- users send request to a front end server ( sometimes called a load balancer or  reverse proxy ) and this server forwads requests to one or more back end servers .  this type of architecture  is increasingly common and in some cases unavoidable , in modern cloud-based applications 
- when the front-end forwards HTTP requests to a back-end server, it typically sends serveral requests over the same back-end network connection , because this is much more efficient and performant the protocol is very simple ; HTTP requsts  are sent one after another and the receiveing server has to determine where one request ends and the next one begins: ![[Html Request Smuggling-20231205134736762.webp|415]]
- so there should be boundaries at that  connection between the  front-end and the back-end servers during the  HTTP requests exchanging 
- ![[Html Request Smuggling-20231205134910022.webp]]
- the attacker causes part of their front-end request to be interpreted by the back-end server as the start of the next request . it is effectively prepended to the next request, and so can interfere with the way the application processes that request smuggling attack , and it can have devastating results . 
## how do HTTP request smuggling vulnerabilities arise ? 
content-length  transfer-encoding  -> are two headers that are specified by the HTTP/1 request  . 
those two headers specify where the request ends. 
the content-length => specify   the length of the *message body* in bytes . for example  :
```
Post /search HTTP /1.1
`Host: normal-website.com Content-Type: application/x-www-form-urlencoded Content-Length: 11 q=smuggling`
```



