  

![[Untitled 13.png|Untitled 13.png]]

  

  

- what is ssrf ?
    - it is a vulnerability that occur when an application is fetching a remote resource without first validating the user-supplied URL
    - which means that we act as if we are the trusted service and this happens simply when ..
    - we find a service that the database for example is trusting and then we use this service to forgery its request by intercepting the request by burp proxy and then modifying the thing it asks for to be for example instead of the product ID instead the admin pannel and when we use any of the buttons in the admin pannel it will also get regicted so we will come again to the trusted service and gett the link of the button and make it as a url path through the trusted service intercepted request .
        
        ![[Untitled 1 3.png|Untitled 1 3.png]]
        
- How to find SSRF vulnerabilities ?
    - balck box testing :
        1. map the application : look at every single function on the app and also keep burp in silent intercepting all the requests .
            1. do that with any request parameters that contain hostnames, ip addresses or full URLs.
        2. for each request parameter , modify its value to specify an alternative resource instead of its value and observe how the application responds
            
            if it is vulnerable you will find the requested resources displayed 😲
            
            if there is a defense we will try to bypass it via known payloads for ssrf.
            
        3. for each request parameter modify its value to a server on the internet that you can control like a python3 server for example and monitor the server for incoming requests.
            1. if no incoming connections are received , monitor the time take for the application to respond
                
                  
                
- How to Exploit SSRF ?
    
    Bypasses:
    
    ![[Untitled 2 4.png|Untitled 2 4.png]]
    
    ![[Untitled 3 3.png|Untitled 3 3.png]]