# BlackHat usa 2015 (SSTI) 
- [Research link](https://portswigger.net/research/server-side-template-injection)
- 
![[Pasted image 20240209175143.png|459]]

# Detect
- ![[Pasted image 20240209184124.png|451]]
- ![[Pasted image 20240209184252.png|443]]
- 
# IDENTIFY
- ![[Pasted image 20240209191409.png]], 


# EXPLOIT:
## Exploit.read
- read the docs of the template you detected 
- ![[Pasted image 20240209185656.png|487]]
## Exploit.explore
![[Pasted image 20240209190039.png|579]]
## Exploit.attack
![[Pasted image 20240209190057.png|579]] 
- - - 
# What is server side template injection ? 
- server side template injection is when attacker is able to use native template syntax  to inject a malicious payload into a template which will then be executed server side ( inside the server ).
- attacker → payload(maliciuous)→ template→ executed in the server side .
- template engines   produce web pages from combining ( fixed template + volatile data(user inputs)) .
- so the attacker injects  arbitrary template directives  in order to manipulate the template engine. 
- enabling attackers to take full control over the server .  
- as name  say SSTI is server side executive attack . 
- More dangerouse than  typical client-side template injection ( csti )
- from SSTI attacker may get RCE  on the server . 
- or even get access to sensitive data (read sensitive files in the server )
# How do server side template injections arises ? 
- SSTI arises when the user input is concatenated into templates rather than being passed in as data . 
- save way : pass user’s input as data to the location you want to use it in . 
- vulnerable way: concatenate user’s input in the location you want to use it in . 
- `$output = $twig->render("Dear{first_name},",array("first_name" => $user.first_name));`
- as we can see  this is not vulnerable  it is safe as the first name is the name and it is passed as data not as inputs from the user so  they are already stored in the system and now they are going to be passed to the location of functioniong msg they want to be used at . 
- while here : 
- ` $output= $twig->render("Dear". $_GET['name']);`
- as you see here the user’s input data is being  concatenated directly into the  output value and here this will be vulnerable to server side template injection . 
- so the user’s input will  be through the get  in a link as following ( `http://target.com/?name={{bad-stuff-here}})
- this is actually similar to sqli .
#  Constructing a server-side template injection attack
- As with any vulnerability, the first step towards exploitation is being able to find it. Perhaps the simplest initial approach is to try fuzzing the template by injecting a sequence of special characters commonly used in template expressions, such as `${{<%[%'"}}%\`. If an exception is raised, this indicates that the injected template syntax is potentially being interpreted by the server in some way. This is one sign that a vulnerability to server-side template injection may exist.
- Plaintext contex : 
	Most template languages allow you to freely input content either by using HTML tags directly or by using the template's native syntax, which will be rendered to HTML on the back-end before the HTTP response is sent. For example, in Freemarker, the line `render('Hello ' + username)` would render to something like `Hello Carlos`.
	
	This can sometimes be exploited for [XSS](https://portswigger.net/web-security/cross-site-scripting) and is in fact often mistaken for a simple XSS vulnerability. However, by setting mathematical operations as the value of the parameter, we can test whether this is also a potential entry point for a server-side template injection attack.
	
	For example, consider a template that contains the following vulnerable code:
	
	`render('Hello ' + username)`
	
	During auditing, we might test for server-side template injection by requesting a URL such as:
	
	`http://vulnerable-website.com/?username=${7*7}`
	
	If the resulting output contains `Hello 49`, this shows that the mathematical operation is being evaluated server-side. This is a good proof of concept for a server-side template injection vulnerability.
	
	Note that the specific syntax required to successfully evaluate the mathematical operation will vary depending on which template engine is being used. We'll discuss this in more detail in the [Identify](https://portswigger.net/web-security/server-side-template-injection#identify) step.
# Exploiting [server-side template injection](https://portswigger.net/web-security/server-side-template-injection) vulnerabilities
-  i found that the template used is erb so i searched for  how to use system commands in erb template and i found a method called `system()`  i gave it  the `ls`  and the result was me getting an eye on all the files in my place then i used rm to remove the moral.txt file and solved the lab . 
- 