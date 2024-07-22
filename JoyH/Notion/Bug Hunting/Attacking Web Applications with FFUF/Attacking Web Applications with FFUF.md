# intorduction

- fuzzing VS brute-forcing are they the same thing .
    - Fuzzing : sending unexpected input to a system to find Vulnerabilies.
    - Brute-forcing : trying all possible combinations of characters to guess a password or other secret.
    - so they are not the same thing :**Fuzzing is about finding bugs, brute-forcing is about guessing secrets.**
- there are many tools to utilize/use for directory and parameter fuzzing /brute-forcing.
- But , we will focus on the ffuf tool for web fuzzing , as it si one of the most common and reliable tools available for web fuzzing .
- tools like **ffuf** → provide us an:
    - automated way to fuzz the WA
        - individual components or a webpage .
        - small or big we have the two options when fuzzing with ffuf .
- **ffuf** : can be used as burp-suite intruder ( burp intruder ) to automate directory fuzzing . but the main difference is nothing they both do the same thing maybe each of them has another things that they can do as another things to make each of them special .
- ffuf is free to use with its full potential not like burp-intruder.

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

  

# The following topics will be discussed :

  

# Fuzzing for directories :

## Basics for using ffuf to fuzz :

- we will learn the basics of using **ffuf** in fuzzing website directories .
- we do fuzzing direcotories when we want to get to more directory pages but there is no GUI for that in the website .
- we usually utilize a **pre-defined** wordlists of commonly used terms for each type of test for website fuzzing to see which of them will be accepted by the website .
- of course accepted = access granted :) .
- so lets talk now about the **word-lists** :
    
    - it is something like password dictionaries .
    - we will discuss it later in the same module btw.
    - website fuzzing returns the majority of pages as we use a word list and there maybe some directories named randomly .
    
    💡
    
    We will not have to reinvent the wheel by manually creating these  
    wordlists, as great efforts have been made to search the web and  
    determine the most commonly used words for each type of fuzzing. Some of  
    the most commonly used wordlists can be found under the GitHub ==[SecLists](https://github.com/danielmiessler/SecLists)== repository
    
    - we will find that i made a folder in

  

## Directory Fuzzing

- now that we understand :
    - [fuzzing concept]
    - the wordlist

### Ffuf:

- `ffuf -h` this to get help
- the main two options are
    
    1. `ffuf -w` for Word_List
    2. `ffuf -u` for URL
    
    - **very important thing**: when you write the command put FUZZ after the
        - `fuff -w /opt/wordlist.txt:FUZZ -u https://www.test.com/FUZZ` THIS is the way of fuzzing a directory with ffuf awesome tool .
- **Fuzzing for files and extensions** is a technique used to  
    find hidden files and directories on a web server. It works by sending  
    unexpected characters or sequences of characters to the server in the  
    URL, such as spaces, special characters, and multiple extensions. If the  
    server responds with a 200 OK status code, then the file or directory  
    exists.

# Fuzzing for files and extensions(web page types) :

- we now have access to a /forum which is a directory found in the website we could get it by fuzzing the main website [http://94.237.59.206:48922/forum/](http://94.237.59.206:48922/forum/) now we will utilize webFuzzing to see if the directory ( /forum ) contains any hidden pages
- to knew if the directory contains any hidden pages we must first knew
    - what types of pages the webstie uses .
        - .html
        - .aspx
        - .php
        - or something else .
- we can knew the ==type of pages== the website uses by
    - by finding the ==server type== —→ through HTTP ==resoponse== headers .
    - |server|page type(extenstion)|
        |---|---|
        |apache|.php|
        |IIS|.asp or .aspx|
        
- this method is not that good cause it is not 100 accurate so we will instead utilize ffuf to page fuzzing by putting .FUZZ keyword which will lead to fuzz in the place of dot which will lead to us knewing the page types the website is using .
- the page type is called extenstion which is .
- we will use the web-extenstions.txt file from SecLists
- Before we start fuzzing, we must specify which file that extension would  
    be at the end of! We can always use two wordlists and have a unique  
    keyword for each, and then do `FUZZ_1.FUZZ_2` to fuzz for both. However, there is one file we can always find in most websites, which is `index.*`, so we will use it as our file and fuzz extensions on it.
- Note: The wordlist we chose already contains a dot (.), so we will not have to add the dot after "index" in our fuzzing.

Now, we can rerun our command, carefully placing our `FUZZ` keyword where the extension would be after `index`:

```
KareemAlsadeq@htb[/htb]$ ffuf -w /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ -u http://SERVER_IP:PORT/blog/indexFUZZ        /'___\  /'___\           /'___\
       /\ \__/ /\ \__/  __  __  /\ \__/
       \ \ ,__\\ \ ,__\/\ \/\ \ \ \ ,__\
        \ \ \_/ \ \ \_/\ \ \_\ \ \ \ \_/
         \ \_\   \ \_\  \ \____/  \ \_\
          \/_/    \/_/   \/___/    \/_/

       v1.1.0-git
________________________________________________

 :: Method           : GET
 :: URL              : http://SERVER_IP:PORT/blog/indexFUZZ
 :: Wordlist         : FUZZ: /opt/useful/SecLists/Discovery/Web-Content/web-extensions.txt
 :: Follow redirects : false
 :: Calibration      : false
 :: Timeout          : 10
 :: Threads          : 5
 :: Matcher          : Response status: 200,204,301,302,307,401,403
________________________________________________

.php                    [Status: 200, Size: 0, Words: 1, Lines: 1]
.phps                   [Status: 403, Size: 283, Words: 20, Lines: 10]
:: Progress: [39/39] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Errors: 0 ::
```

We do get a couple of hits, but only `.php` gives us a response with code `200`.  
Great! We now know that this website runs on `PHP` to start fuzzing for `PHP` files.

  

- now that we knew the page type ( extension )
- and we knew that it is .php
- we wil be fuzzing for pages under the directory we knew but with adding its extensions
- ffuf -w …. :FUZZ -u https://serverIP:port/FUZZ.php

## recursive Fuzzing

- it is an automation for :
    - fuzzing —> many_dir /many_sub_dir/many_files/
    - as you saw if we dont use recursive fuzzing for a process like this to automate this process we will take a very long time to finish without autmation but with automation ( recursive fuzzing ) this will be faster to be done .
- recursive flags :
    - `ffuf -w ...:FUZZ -u... -recursion`
        - `-recursion` this tells ffuf to use the recursion method while fuzzing
            - `-recursion-depth` to specify for what depth should it fuzz usally we use 1
            - `-recursion-depth 1` this will lead to fuzz directories/subdirectories only it will not fuzz more than that .
- `ffuf -w -u -recursion -recursion-depth 1 -e .php` we use the -e to specify the extension
- `-v` we also use -v to output the full URLS instead of collecting them manually after fuzzing . [it will be very hard if we forgot to use it ] .

### lets talk about DNS records :

- we can go to any local ip by putting it with the an opened port .
- but , when it comes for the DNS you should have a DNS record for this website with the ip of it and the port they should all of them be in the
    
    - /etc/hosts if they are not there then they should be at google DNS records but as we are talking about a local ip adress under a local domain name then it will not be there in google dns records .
    - so to make it work we have two options
        1. to search for the serverIP:port
        2. or to add the DNS record manually to our /etc/hosts file
    
      
    

### Sub-domain Fuzzing :

- we learned fuzzing a directory - sub_directories -pages
- we will learn fuzzing for subdomains [not sub_directories]
- A sub-domain is any website underlying another domain. For example, `https://photos.google.com` is the `photos` sub-domain of `google.com`.

  

# Identifying hidden Vhosts :

- we utilize Vhosting in an IP that we already have .
- we run the scan on an IP
- and we test the scan also on that IP s DNS records cause they will not be in the googles.DNS record or even in our etc/hosts .
- doing the Vhost fuzzing is better cause as an example if we Vhost-fuzzing [www.tesla.com](http://www.tesla.com) this will make it goes for doing the fuzzing process and search on teslas own DNS records which will lead to → getting the public and also the private domain and subdomains .

# Fuzzing for PHP parameters :

- no access ⇒ you dont have the required key .
    
    ![[Screenshot_from_2023-09-10_14-50-33.png]]
    
- Such keys would usually be passed as a `parameter`.
- using either a `GET` or a `POST`  
    HTTP request. This section will discuss how to fuzz for such parameters  
    until we identify a parameter that can be accepted by the page.
- In the context of HTTP requests, a parameter is a piece of data that is passed to the server along with the request. The parameter is usually specified in the URL, but it can also be specified in the request body.

- For example, if the page has a parameter called "username", the user could try to fuzz the parameter by passing different values for the username, such as "admin", "root", or "password". If the page accepts one of these values, then the user has found a parameter that can be used to exploit the page.
- Here are some examples of parameters that might be passed to a web page:
    
    - username
    - password
    - page_id
    - search_term
    - sort_order
    - filter_criteria
    
    The specific parameters that are used will vary depending on the web page.
    
- post rerquest are not passed in the url like get request .
- to fuzz the data field with ffuf ,
- we can use the -d flag ,
- as we saw previously in the output of ffuf -h we also have to add -X POST to send POST request
- sow -X POST -d ‘FUZZ=key’ -H ‘Content-Type: application/x-www-form-urlencoded’
- okay so this will give us the key of course we will filter the results by default size.
- after that we will be having the key but we canot enter with the key only becasue we need also the value of that key to enter so we will fuzz the value of the key

## GET Request Fuzzing

Similarly to how we have been fuzzing various parts of a website, we will use `ffuf` to enumerate parameters. Let us first start with fuzzing for `GET` requests, which are usually passed right after the URL, with a `?` symbol, like:

- `http://admin.academy.htb:PORT/admin/admin.php?param1=key`.

# Fuzzing for parameter values :

`for i in $(seq 1 1000); do echo $i >> ids.txt; done` this will make file txt called ids.txt that will contain the numbers from 1 till 1000 .