# Introduction

---

- [Web applications](https://en.wikipedia.org/wiki/Web_application) are interactive applications that run on web browsers
- Web applications usually adopt a [client-server architecture](https://cio-wiki.org/wiki/Client_Server_Architecture) to run and handle interactions
    
    - Client-server architecture : contains two computer types 1. client 2. server
    - clients are computer that request resources or services from servers.
    - servers are computers that provide the resources or services to clients .
    - in a WebApplication :
        - the client is → browser
        - the browser=client is used to view the website
        - the server is the computer that hosts the websites files and databases
    - when you visit a website (server) . your browser sends a request to the server.
    - the server then send the requested files and data back to your browser . and your browser display them.
    
    💡
    
    so this means that client-server architecture is the process that happens between the browser (client) - and the website connected to the (server). client asks server answers
    

  

  

- They typically have front end components (i.e., the website interface, or "what the user sees") that run on the client-side (browser) and other back end components (web application source code) that run on the server-side (back end server/databases).
- ==Normal web== applications are static, meaning that the content of the page does not change unless the page is refreshed. ==Typical web applications== are dynamic, meaning that the content of the page can change based on user input or other factors. This makes typical web applications more complex to develop and maintain.
    
    so the normal is like html+css while the typical web application is like html+css + PHP( a backend lang)
    

  

- These types of ==Normal web 1.0== static pages do not contain functions and, therefore, do  
    not produce real-time changes. That type of website is also known as [Web 1.0](https://en.wikipedia.org/wiki/Web_2.0#Web_1.0).

[![](https://academy.hackthebox.com/storage/modules/75/website_vs_webapps.jpg)](https://academy.hackthebox.com/storage/modules/75/website_vs_webapps.jpg)

On the other hand, most websites run web applications, or [Web 2.0](https://en.wikipedia.org/wiki/Web_2.0)  
presenting dynamic content based on user interaction. Another  
significant difference is that web applications are fully functional and  
can perform various functionalities for the end-user, while web sites  
lack this type of functionality. Other key differences between  
traditional websites and web applications include:

- Being modular
- Running on any display size
- Running on any platform without being optimized
- A ==framework==, in the context of software development, refers to a pre-built set of code to which a developer can add their own code to solve a specific problem or build a particular type of application. Essentially, it provides a foundation on which software applications can be developed.

## Web Application Distribution

There are many open-source web applications used by organizations  
worldwide that can be customized to meet each organization's needs. Some  
common open source web applications include:

- [WordPress](https://wordpress.com/)
- [OpenCart](https://www.opencart.com/)
- [Joomla](https://www.joomla.org/)

There are also proprietary 'closed source' web applications, which  
are usually developed by a certain organization and then sold to another  
organization or used by organizations through a subscription plan  
model. Some common closed source web applications include:

- [Wix](https://www.wix.com/)
- [Shopify](https://www.shopify.com/)
- [DotNetNuke](https://www.dnnsoftware.com/)

  

## Security Risks of Web Applications

- Web application attacks are pre.valent =widespread
- present a challenge for most organizations .
- as web applications become more complicated and advanced
- this leaded to increaseing the possibility of critical vulnerabilities
- hard to make = easy to break
- webapplications are run on servers
- the webapp servers may host other sensitive information
- the webapp servers are linked to database conatining sensitive user or corporate data.
- so webapp servers are connected to 1. sensitive informations 2. database
- so webapp server is connected to an imp sensitive data (data base)
- To properly pentest web applications,
    - we need to understand how they work,
    - how they are developed,
    - and what kind of risk lies at each layer and component of the application depending on the technologies in use.
- We will always come across various web applications that are designed  
    and configured differently. One of the most current and widely used  
    methods for testing web applications is the [OWASP Web Security Testing Guide](https://github.com/OWASP/wstg/tree/master/document/4-Web_Application_Security_Testing).
    - OWASP is a method for testing web app penetration.
- One of the most common procedures is to:
    1. start by reviewing a web application's front end components.
        
        1. such as `HTML`,
        2. `CSS`
        3. and `JavaScript`
        
        (also known as the front end trinity), and attempt to find vulnerabilities such as:
        
        [Sensitive Data Exposure](https://owasp.org/www-project-top-ten/2017/A3_2017-Sensitive_Data_Exposure)
        
        [Cross-Site Scripting (XSS)](https://owasp.org/www-project-top-ten/2017/A7_2017-Cross-Site_Scripting_(XSS)).
        
- WordPress is a Content Management System
- We often find SQL injection vulnerabilities on web applications that use Active Directory for authentication.
    - Active Directory: is a direcotry servece that provides authentication and authorization services.

This example shows the damage that can arise from a single web  
application vulnerability, especially when "chained" to extract data  
from one application that can be used to attack other portions of a  
company's external infrastructure.

**A well-rounded infosec professional**  
should have a ==deep understanding of web applications==

and be ==comfortable attacking web applications==

as ==performing network penetration testing==

and ==Active Directory attacks==.

A penetration tester with

**a strong foundation in web applications**

can often set themselves apart  
from their peers and find flaws that others may overlook. A few more  
real-world examples of web application attacks and the impact are as  
follows:

|   |   |
|---|---|
|Flaw|Real-world Scenario|
|[SQL injection](https://owasp.org/www-community/attacks/SQL_Injection)|Obtaining Active Directory usernames and performing a password spraying attack against a VPN or email portal.|
|[File Inclusion](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/07-Input_Validation_Testing/11.1-Testing_for_Local_File_Inclusion)|Reading source code to find a hidden page or directory which exposes  <br>additional functionality that can be used to gain remote code  <br>execution.|
|[Unrestricted File Upload](https://owasp.org/www-community/vulnerabilities/Unrestricted_File_Upload)|A web application that allows a user to upload a profile picture  <br>that allows any file type to be uploaded (not just images). This can be  <br>leveraged to gain full control of the web application server by  <br>uploading malicious code.|
|[Insecure Direct Object Referencing (IDOR)](https://cheatsheetseries.owasp.org/cheatsheets/Insecure_Direct_Object_Reference_Prevention_Cheat_Sheet.html)|When combined with a flaw such as broken access control, this can  <br>often be used to access another user's files or functionality. An  <br>example would be editing your user profile browsing to a page such as  <br>/user/701/edit-profile. If we can change the `701` to `702`, we may edit another user's profile!|
|[Broken Access Control](https://owasp.org/www-project-top-ten/2017/A5_2017-Broken_Access_Control)|Another example is an application that allows a user to register a  <br>new account. If the account registration functionality is designed  <br>poorly, a user may perform privilege escalation when registering.  <br>Consider the `POST` request when registering a new user, which submits the data `username=bjones&password=Welcome1&email=bjones@inlanefreight.local&roleid=3`. What if we can manipulate the `roleid` parameter and change it to `0` or `1`.  <br>We have seen real-world applications where this was the case, and it  <br>was possible to quickly register an admin user and access many  <br>unintended features of the web application.|

### Let's dive in and learn the structure/function of web applications to become better-informed attackers, set us apart from our peers, and find flaws that others may overlook.

  

## structure/function:

# Web Application Layout

---

- No two web applications are identical.
- It is important to understand the various ways web applications can run behind the scenes:
    - the structure of a web application.
    - its components,
    - and how they can be set up within a company's infrastructure.
- so the Structer is very important for us we need to start the pentest with the structure of the targeted website.

|   |   |
|---|---|
|**Category**|**Description**|
|`Web Application Infrastructure`|Describes the structure of required components, such as the  <br>==database==, needed for the web application to function as intended. Since  <br>the web application can be set up to run on a separate server, it is  <br>essential to know which database server it needs to access. [check the server that connect the web with the database ]|
|`Web Application Components`|The components that make up a web application represent all the  <br>components that the web application interacts with. These are divided  <br>into the following three areas: `UI/UX`, `Client`, and `Server` components.|
|`Web Application Architecture`|Architecture comprises all the relationships between the various web application components.|

  

## Web Application Infrastructure

- Web applications can use ==many different infrastructure setups.==
- the infrastructure ( the under building ) setups are called models .
- we have 4 models =4 infrastructure setups in a webapplication.
    1. client-server.
    2. one-server.
    3. Many-servers with one database.
    4. Many-servers with many databases.

  

### Client-Server:

- Web applications often depends on the client server model.
- the server hosts the web application in a client -server model and distributes it to any clients trying to access it .

Web applications often adopt the `client-server` model. A server hosts the web application in a client-server model and distributes it to any clients trying to access it.

[![](https://academy.hackthebox.com/storage/modules/75/client-server-model.jpg)](https://academy.hackthebox.com/storage/modules/75/client-server-model.jpg)

In this model

- web application has two types of components 1. front end 2. back end
- the front end appears to the client server after being executed and interpreted on the dclient0side (browser).
- while the back-end don't appear except for the hosting server after being compiled and executed and interpreted as what is done for the front but here it is for the back and to the host-server .
- when we click a button → the borwser sends an HTTP web request to the serveer which interprets this request and performs the necessary tasks to complete the request like log in the user. …..etc.
- any website is a web application but just developed and hosted by teh webserver .
- like [htb.com](http://htb.com) is a website = web application but developed and hosted by htb ( webhost ) .

  

### One-server:

- the web-application is hosted on only one-server ( we can knew that from the name ) .
- also we can have alot of websites with the same one-server they all use the same web-server that develop them all as one thing
- many as one → good target 😎

[![](https://academy.hackthebox.com/storage/modules/75/one-server-arch.jpg)](https://academy.hackthebox.com/storage/modules/75/one-server-arch.jpg)

If any web application hosted on this server is compromised in this  
architecture, then all web applications' data will be compromised. This  
design represents an "`all eggs in one basket`" approach since if any of the hosted web applications are vulnerable, the entire webserver becomes vulnerable.

  

  

- and also if the someone attacked the webserver with any way and then the server went down then all the webaplications hosted by this webserver will become entirely inaccessible until teh issue is resolved .

  

  

### Many Servers - One Database

- This model separates the database onto its own database server and  
    allows the web applications' hosting server to access the database  
    server to store and retrieve data.
- the many servers is from the name many host servers but it is with only one database for the one database version of many servers.
- as in the image:

[![](https://academy.hackthebox.com/storage/modules/75/many-server-one-db-arch.jpg)](https://academy.hackthebox.com/storage/modules/75/many-server-one-db-arch.jpg)

the many servers-one data base web application model :

- can allow serveral web applications to acess a single main database without any transfer of the data between the web-clients .
- which means no syncing of data between the web-application-clients for the [ Many servers - One Database Model setup].

  

  

### Many Servers - Many Databases

This model builds upon the `Many Servers, One Database`  
model. However, within the database server, each web application's data  
is hosted in a separate database. The web application can only access  
private data and only common data that is shared across web  
applications. It is also possible to host each web application's  
database on its separate database server.

[![](https://academy.hackthebox.com/storage/modules/75/many-server-many-db-arch.jpg)](https://academy.hackthebox.com/storage/modules/75/many-server-many-db-arch.jpg)

This design is also widely used for redundancy purposes, so if any  
web server or database goes offline, a backup will run in its place to  
reduce downtime as much as possible. Although this may be more difficult  
to implement and may require tools like [load balancers](https://en.wikipedia.org/wiki/Load_balancing_(computing))  
to function appropriately, this architecture is one of the best choices  
in terms of security due to its proper access control measures and  
proper asset segmentation.

  

  

- Aside from these models, there are other web application models available such as [serverless](https://aws.amazon.com/lambda/serverless-architectures-learn-more) web applications or web applications that utilize [microservices](https://aws.amazon.com/microservices).

  

  

## Web Application Components

Each web application can have a different number of components.  
Nevertheless, all of the components of the models mentioned previously  
can be broken down to:

1. `Client`
2. `Server`
    - Webserver
    - Web Application Logic
    - Database
3. `Services` (Microservices)
    - 3rd Party Integrations
    - Web Application Integrations
4. `Functions` (Serverless)

## Web Application Architecture :

---

- the componenets of a web application are divided into three different layers ( AKA Three Tier Architecture).
- so we have in the web application architecture a three tiers which means 3 layers in the web application architecture.

|   |   |
|---|---|
|**Layer**|**Description**|
|`Presentation Layer`|Consists of UI process components that enable communication with the  <br>application and the system. These can be accessed by the client via the  <br>web browser and are returned in the form of HTML, JavaScript, and CSS.|
|`Application Layer`|This layer ensures that all client requests (web requests) are  <br>correctly processed. Various criteria are checked, such as  <br>authorization, privileges, and data passed on to the client.|
|`Data Layer`|The data layer works closely with the application layer to determine  <br>exactly where the required data is stored and can be accessed.|

1. presentation layer :
    1. consists of the UI .
    2. the UI that presents in the presentation layer of the web application 3 tier architecture allow and enable the communication with the application and system .
    3. and the ui can be accessed by the client through the web browser .
    4. the UI proccess components are returned in the form of HTML , CSS and JavaScript from the host-server and they are excuted by the client-server .
2. Application Layer :
    1. deals with the web-Requests .
        1. authorization
        2. , privileges ,
        3. data passed on to the client server .
3. Data Layer :
    1. the data layer works closely with the application layer (which works on the requests ) .
    2. where the required data is stored and can they be accessed ?

  

|   |   |   |
|---|---|---|
|1|Presentation Layer|UI|
|2|Application Layer|Requests|
|3|Data Layer|Data storing|

An example of a web application architecture could look something like this:

[![](https://docs.microsoft.com/en-us/dotnet/architecture/modern-web-apps-azure/media/image5-12.png)](https://docs.microsoft.com/en-us/dotnet/architecture/modern-web-apps-azure/media/image5-12.png)

Source:

[Microsoft Docs](https://docs.microsoft.com/en-us/dotnet/architecture/modern-web-apps-azure/common-web-application-architectures)

Furthermore, some web ==servers== can run operating system calls and programs, like [IIS ISAPI](https://learn.microsoft.com/en-us/previous-versions/iis/6.0-sdk/ms525172(v=vs.90)) or [PHP-CGI](https://www.php.net/manual/en/install.unix.commandline.php).

---

### Microservices

We can think of microservices as independent components of the web  
application, which in most cases are programmed for one task only. For  
example, for an online store, we can decompose core tasks into the  
following components:

- Registration
- Search
- Payments
- Ratings
- Reviews

These components communicate with the client and with each other. The communication between these microservices is `stateless`, which means that the request and response are independent. This is because the stored data is `stored separately` from the respective microservices. The use of microservices is considered [service-oriented architecture (SOA)](https://en.wikipedia.org/wiki/Service-oriented_architecture),  
built as a collection of different automated functions focused on a  
single business goal. Nevertheless, these microservices depend on each  
other.

Another essential and efficient microservice component is that they  
can be written in different programming languages and still interact.  
Microservices benefit from easier scaling and faster development of  
applications, which encourages innovation and speeds upmarket delivery  
of new features. Some benefits of microservices include:

- Agility
- Flexible scaling
- Easy deployment
- Reusable code
- Resilience

This AWS [whitepaper](https://d1.awsstatic.com/whitepapers/microservices-on-aws.pdf) provides an excellent overview of microservice implementation.

---

### Serverless

Cloud providers such as AWS, GCP, Azure, among others, offer  
serverless architectures. These platforms provide application frameworks  
to build such web applications without having to worry about the  
servers themselves. These web applications then run in stateless  
computing containers (Docker, for example). This type of architecture  
gives a company the flexibility to build and deploy applications and  
services without having to manage infrastructure; all server management  
is done by the cloud provider, which gets rid of the need to provision,  
scale, and maintain servers needed to run applications and databases.

You can read more about serverless computing and its various use cases [here](https://aws.amazon.com/serverless).

---

## Architecture Security

Understanding the general architecture of web applications and each  
web application's specific design is important when performing a  
penetration test on any web application. In many cases, an individual  
web application's vulnerability may not necessarily be caused by a  
programming error but by a design error in its architecture.

For example, an individual web application may have all of its core  
functionality secure implemented. However, due to a lack of proper  
access control measures in its design, i.e., use of [Role-Based Access Control(RBAC)](https://en.wikipedia.org/wiki/Role-based_access_control),  
users may be able to access some admin features that are not intended  
to be directly accessible to them or even access other user's private  
information without having the privileges to do so. To fix this type of  
issue, a significant design change would need to be implemented, which  
would likely be both costly and time-consuming.

Another example would be if we cannot find the database after  
exploiting a vulnerability and gaining control over the back-end server,  
which may mean that the database is hosted on a separate server. We may  
only find part of the database data, which may mean there are several  
databases in use. This is why security must be considered at each phase  
of web application development, and penetration tests must be carried  
throughout the web application development lifecycle.

  

# Front End vs. Back End :

There are four main back end components for web applications:

|   |   |
|---|---|
|**Component**|**Description**|
|`Back end Servers`|The hardware and operating system that hosts all other components and are usually run on operating systems like `Linux`, `Windows`, or using `Containers`.|
|`Web Servers`|Web servers handle HTTP requests and connections. Some examples are `Apache`, `NGINX`, and `IIS`.|
|`Databases`|Databases (`DBs`) store and retrieve the web application data. Some examples of relational databases are `MySQL`, `MSSQL`, `Oracle`, `PostgreSQL`, while examples of non-relational databases include `NoSQL` and `MongoDB`.|
|`Development Frameworks`|Development Frameworks are used to develop the core Web Application. Some well-known frameworks include `Laravel` (`PHP`), `ASP.NET` (`C#`), `Spring` (`Java`), `Django` (`Python`), and `Express` (`NodeJS JavaScript`).|

[![](https://academy.hackthebox.com/storage/modules/75/backend-server.jpg)](https://academy.hackthebox.com/storage/modules/75/backend-server.jpg)

The `top 20` most common mistakes web developers make that are essential for us as penetration testers are:

|   |   |
|---|---|
|**No.**|**Mistake**|
|`1.`|Permitting Invalid Data to Enter the Database|
|`2.`|Focusing on the System as a Whole|
|`3.`|Establishing Personally Developed Security Methods|
|`4.`|Treating Security to be Your Last Step|
|`5.`|Developing Plain Text Password Storage|
|`6.`|Creating Weak Passwords|
|`7.`|Storing Unencrypted Data in the Database|
|`8.`|Depending Excessively on the Client Side|
|`9.`|Being Too Optimistic|
|`10.`|Permitting Variables via the URL Path Name|
|`11.`|Trusting third-party code|
|`12.`|Hard-coding backdoor accounts|
|`13.`|Unverified SQL injections|
|`14.`|Remote file inclusions|
|`15.`|Insecure data handling|
|`16.`|Failing to encrypt data properly|
|`17.`|Not using a secure cryptographic system|
|`18.`|Ignoring layer 8|
|`19.`|Review user actions|
|`20.`|Web Application Firewall misconfigurations|

These mistakes lead to the [OWASP Top 10](https://owasp.org/www-project-top-ten/) vulnerabilities for web applications, which we will discuss in other modules:

|   |   |
|---|---|
|**No.**|**Vulnerability**|
|`1.`|Broken Access Control|
|`2.`|Cryptographic Failures|
|`3.`|Injection|
|`4.`|Insecure Design|
|`5.`|Security Misconfiguration|
|`6.`|Vulnerable and Outdated Components|
|`7.`|Identification and Authentication Failures|
|`8.`|Software and Data Integrity Failures|
|`9.`|Security Logging and Monitoring Failures|
|`10.`|Server-Side Request Forgery (SSRF)|

It is important to begin to familiarize ourselves with these flaws  
and vulnerabilities as they form the basis for many of the issues we  
cover in future web and even non-web related modules. As pentesters, we  
must have the ability to competently identify, exploit, and explain  
these vulnerabilities for our clients.

  

  

  

  

💡

i took the part of [HTML , CSS and JavaScript ] without notes cause i knew morethan what they told me so 😊.

  

# **Front End Vulnerabilities**

[[Front End Vulnerabilities]]

  

  

# lets go to identify backend :

  

- A back-end server is the hardware and operating system on the back  
    end that hosts all of the applications necessary to run the web  
    application. It is the real system running all of the processes and  
    carrying out all of the tasks that make up the entire web application.  
    The back end server would fit in the [Data access layer](https://en.wikipedia.org/wiki/Data_access_layer).

## Software

The back end server contains the other 3 back end components:

- `Web Server`
- `Database`
- `Development Framework`

  

  

![[Screenshot_from_2023-09-05_04-10-15.png]]

  

  

  

[![](https://academy.hackthebox.com/storage/modules/75/backend-server.jpg)](https://academy.hackthebox.com/storage/modules/75/backend-server.jpg)

Other software components on the back end server may include [hypervisors](https://en.wikipedia.org/wiki/Hypervisor), containers, and WAFs.

There are many popular combinations of "stacks" for back-end servers,  
which contain a specific set of back end components. Some common  
examples include:

|   |   |
|---|---|
|Combinations|Components|
|[LAMP](https://en.wikipedia.org/wiki/LAMP_(software_bundle))|`Linux`, `Apache`, `MySQL`, and `PHP`.|
|[WAMP](https://en.wikipedia.org/wiki/LAMP_(software_bundle)\#WAMP)|`Windows`, `Apache`, `MySQL`, and `PHP`.|
|[WINS](https://en.wikipedia.org/wiki/Solution_stack)|`Windows`, `IIS`, `.NET`, and `SQL Server`|
|[MAMP](https://en.wikipedia.org/wiki/MAMP)|`macOS`, `Apache`, `MySQL`, and `PHP`.|
|[XAMPP](https://en.wikipedia.org/wiki/XAMPP)|Cross-Platform, `Apache`, `MySQL`, and `PHP/PERL`.|

  

We can find a comprehensive list of Web Solution Stacks in this [article](https://en.wikipedia.org/wiki/Solution_stack).

  

  

## Hardware

The back end server contains all of the necessary hardware. The power  
and performance capabilities of this hardware determine how stable and  
responsive the web application will be. As previously discussed in the `Architecture`  
section, many architectures, especially for huge web applications, are  
designed to distribute their load over many back end servers that  
collectively work together to perform the same tasks and deliver the web  
application to the end-user. Web applications do not have to run  
directly on a single back end server but may utilize data centers and  
cloud hosting services that provide virtual hosts for the web  
application.

  

# Web Servers

---

- A [web server](https://en.wikipedia.org/wiki/Web_server) is an application that runs on the back end server
- the ==**webserver**== handles all **==HTTP traffic==** from client side( browser)

  

![[Screenshot_from_2023-09-05_04-17-15.png]]

- Web servers usually run on TCP [ports](https://en.wikipedia.org/wiki/Port_(computer_networking)) `80` or `443`, tcp80 → http , tcp443 → https .
- connecting end-users to various parts of the web application, in addition to handling their various responses.

  

## Workflow

A typical web server accepts HTTP requests from the client-side.

  
responds with different HTTP responses and codes, like a code `200 OK` response for a successful request, a code `404 NOT FOUND` when requesting pages that do not exist, code `403 FORBIDDEN` for requesting access to restricted pages, and so on.

[![](https://academy.hackthebox.com/storage/modules/75/web-server-requests.jpg)](https://academy.hackthebox.com/storage/modules/75/web-server-requests.jpg)

The following are some of the most common [HTTP response codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status):

|   |   |
|---|---|
|Code|Description|
|**Successful responses**||
|`200 OK`|The request has succeeded|
|**Redirection messages**||
|`301 Moved Permanently`|The URL of the requested resource has been changed permanently|
|`302 Found`|The URL of the requested resource has been changed temporarily|
|**Client error responses**||
|`400 Bad Request`|The server could not understand the request due to invalid syntax|
|`401 Unauthorized`|Unauthenticated attempt to access page|
|`403 Forbidden`|The client does not have access rights to the content|
|`404 Not Found`|The server can not find the requested resource|
|`405 Method Not Allowed`|The request method is known by the server but has been disabled and cannot be used|
|`408 Request Timeout`|This response is sent on an idle connection by some servers, even without any previous request by the client|
|**Server error responses**||
|`500 Internal Server Error`|The server has encountered a situation it doesn't know how to handle|
|`502 Bad Gateway`|The server, while working as a gateway to get a response needed to handle the request, received an invalid response|
|`504 Gateway Timeout`|The server is acting as a gateway and cannot get a response in time|

  

  

### Web servers also accept various types of user input within HTTP requests:

1. text
2. JSON
3. binarydata

  

Once a web server receives a web request:

- it is then responsible for routing it to its destination.
- run any processes needed for that request.
- return the response to the user on the client-side.

  

The following shows an example of requesting a page in a Linux terminal using the [cURL](https://en.wikipedia.org/wiki/CURL) utility, and receiving the server response while using the `-I` flag, which displays the headers:

```
KareemAlsadeq@htb[/htb]$ curl -I https://academy.hackthebox.comHTTP/2 200
date: Tue, 15 Dec 2020 19:54:29 GMT
content-type: text/html; charset=UTF-8
...SNIP...
```

While this `cURL` command example shows us the source code of the webpage:

```
KareemAlsadeq@htb[/htb]$ curl https://academy.hackthebox.com<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Cyber Security Training : HTB Academy</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

  

![[Screenshot_from_2023-09-05_04-35-22.png]]

  

## Apache

[![](https://academy.hackthebox.com/storage/modules/75/apache.png)](https://academy.hackthebox.com/storage/modules/75/apache.png)

[Apache](https://www.apache.org/) 'or `httpd`' is the most common web server on the internet, hosting more than `40%` of all internet websites. `Apache` usually comes pre-installed in most `Linux` distributions and can also be installed on Windows and macOS servers.

  

- Apache usually used with PHP
- Apache also support .net , python , Perl and even OS langs like bash through CGI.
- modules for Apache is like libraries for python .

💡

Apache —————————————————> PHP in back_end_lang.

  

  

  

## NGINX

[![](https://academy.hackthebox.com/storage/modules/75/nginx.png)](https://academy.hackthebox.com/storage/modules/75/nginx.png)

[NGINX](https://www.nginx.com/) is the second most common web server on the internet, hosting roughly `30%` of all internet websites. `NGINX`  
focuses on serving many concurrent web requests with relatively low  
memory and CPU load by utilizing an async architecture to do so. This  
makes `NGINX` a very reliable web server for popular web  
applications and top businesses worldwide, which is why it is the most  
popular web server among high traffic websites, with around 60% of the  
top 100,000 websites using `NGINX`.

  

  

## IIS

[![](https://academy.hackthebox.com/storage/modules/75/iis.png)](https://academy.hackthebox.com/storage/modules/75/iis.png)

[IIS (Internet Information Services)](https://en.wikipedia.org/wiki/Internet_Information_Services) is the third most common web server on the internet, hosting around `15%` of all internet web sites. `IIS` is developed and maintained by Microsoft and mainly runs on Microsoft Windows Servers. `IIS`  
is usually used to host web applications developed for the Microsoft  
.NET framework, but can also be used to host web applications developed  
in other languages like `PHP`, or host other types of services like `FTP`. Furthermore, `IIS` is very well optimized for Active Directory integration and includes features like `Windows Auth` for authenticating users using Active Directory, allowing them to automatically sign in to web applications.

  

  

  

### note:

- Aside from these 3 web servers, there are many other commonly used web servers, like [Apache Tomcat](https://tomcat.apache.org/) for `Java` web applications, and [Node.JS](https://nodejs.org/en/) for web applications developed using `JavaScript` on the back end.

  

  

  

![[Screenshot_from_2023-09-05_04-53-52.png]]

  

  

  

# Databases:

- it containse the bases of data
    - txt
    - img
    - linkes
    - files
    - assets
    - content
    - posts
    - updates
    - user data
    - usernames
    - passwords
- This allows web applications to easily and quickly store and retrieve data .
- and enable ==dynamic content== that is **different for each user.**

  

- There are many different types of databases.
- each of which fits a certain type of use.
- Most developers look for certain characteristics in  
    a database such as:
    - `speed` in storing and retrieving data.
    - `size` when storing large amounts of data.
    - `scalability` as the web application grows.
    - `cost`.

## Relational (SQL)

[Relational](https://en.wikipedia.org/wiki/Relational_database)  
(SQL) databases store their data in tables, rows, and columns. Each  
table can have unique keys, which can link tables together and create  
relationships between tables.

For example, we can have a `users` table in a relational database containing columns like `id`, `username`, `first_name`, `last_name`, and so on. The `id` can be used as the table key. Another table, `posts`, may contain posts made by all users, with columns like `id`, `user_id`, `date`, `content`, and so on.

[![](https://academy.hackthebox.com/storage/modules/75/web_apps_relational_db.jpg)](https://academy.hackthebox.com/storage/modules/75/web_apps_relational_db.jpg)

We can link the `id` from the `users` table to the `user_id` in the `posts` table to easily retrieve the user details for each post, without having to store all user details with each post.

  

  

💡

The relationship between tables within a database is called a Schema.

![[Screenshot_from_2023-09-05_05-04-41.png]]

  

  

Some of the most common relational databases include:

|   |   |
|---|---|
|Type|Description|
|[MySQL](https://en.wikipedia.org/wiki/MySQL)|The most commonly used database around the internet. It is an open-source database and can be used completely free of charge|
|[MSSQL](https://en.wikipedia.org/wiki/Microsoft_SQL_Server)|Microsoft's implementation of a relational database. Widely used with Windows Servers and IIS web servers|
|[Oracle](https://en.wikipedia.org/wiki/Oracle_Database)|A very reliable database for big businesses, and is frequently  <br>updated with innovative database solutions to make it faster and more  <br>reliable. It can be costly, even for big businesses|
|[PostgreSQL](https://en.wikipedia.org/wiki/PostgreSQL)|Another free and open-source relational database. It is designed to  <br>be easily extensible, enabling adding advanced new features without  <br>needing a major change to the initial database design|

Other common SQL databases include: `SQLite`, `MariaDB`, `Amazon Aurora`, and `Azure SQL`.

  

![[Screenshot_from_2023-09-05_05-09-37.png]]

## Non-relational (NoSQL)

A [non-relational database](https://en.wikipedia.org/wiki/NoSQL) does not use tables, rows, columns, primary keys, relationships, or schemas. Instead, a `NoSQL` database stores data using various storage models, depending on the type of data stored.

Due to the lack of a defined structure for the database, `NoSQL` databases are very scalable and flexible. When dealing with datasets that are not very well defined and structured, a `NoSQL` database would be the best choice for storing our data.

There are 4 common storage models for `NoSQL` databases:

- Key-Value
- Document-Based
- Wide-Column
- Graph

Each of the above models has a different way of storing data. For example, the `Key-Value` model usually stores data in `JSON` or `XML`, and has a key for each pair, storing all of its data as its value:

[![](https://academy.hackthebox.com/storage/modules/75/web_apps_non-relational_db.jpg)](https://academy.hackthebox.com/storage/modules/75/web_apps_non-relational_db.jpg)

The above example can be represented using `JSON` as follows:

Code: json

```
{
  "100001": {
    "date": "01-01-2021",
    "content": "Welcome to this web application."
  },
  "100002": {
    "date": "02-01-2021",
    "content": "This is the first post on this web app."
  },
  "100003": {
    "date": "02-01-2021",
    "content": "Reminder: Tomorrow is the ..."
  }
}
```

It looks similar to a dictionary/map/key-value pair in languages like `Python` or `PHP` 'i.e. `{'key':'value'}`', where the `key` is usually a string, the `value` can be a string, dictionary, or any class object.

The `Document-Based` model stores data in complex `JSON` objects and each object has certain meta-data while storing the rest of the data similarly to the `Key-Value` model.

Some of the most common `NoSQL` databases include:

|   |   |
|---|---|
|Type|Description|
|[MongoDB](https://en.wikipedia.org/wiki/MongoDB)|The most common `NoSQL` database. It is free and open-source, uses the `Document-Based` model, and stores data in `JSON` objects|
|[ElasticSearch](https://en.wikipedia.org/wiki/Elasticsearch)|Another free and open-source `NoSQL` database. It is  <br>optimized for storing and analyzing huge datasets. As its name suggests,  <br>searching for data within this database is very fast and efficient|
|[Apache Cassandra](https://en.wikipedia.org/wiki/Apache_Cassandra)|Also free and open-source. It is very scalable and is optimized for gracefully handling faulty values|

Other common `NoSQL` databases include: `Redis`, `Neo4j`, `CouchDB`, and `Amazon DynamoDB`.

---

## Use in Web Applications

Most modern web development languages and frameworks make it easy to  
integrate, store, and retrieve data from various database types. But  
first, the database has to be installed and set up on the back end  
server, and once it is up and running, the web applications can start  
utilizing it to store and retrieve data.

For example, within a `PHP` web application, once `MySQL` is up and running, we can connect to the database server with:

Code: php

```
$conn = new mysqli("localhost", "user", "pass");
```

Then, we can create a new database with:

Code: php

```
$sql = "CREATE DATABASE database1";
$conn->query($sql)
```

After that, we can connect to our new database, and start using the `MySQL` database through `MySQL` syntax, right within `PHP`, as follows:

Code: php

```
$conn = new mysqli("localhost", "user", "pass", "database1");
$query = "select * from table_1";
$result = $conn->query($query);
```

Web applications usually use user-input when retrieving data. For  
example, when a user uses the search function to search for other users,  
their search input is passed to the web application, which uses the  
input to search within the database(s).

Code: php

```
$searchInput =  $_POST['findUser'];
$query = "select * from users where name like '%$searchInput%'";
$result = $conn->query($query);
```

Finally, the web application sends the result back to the user:

Code: php

```
while($row = $result->fetch_assoc() ){
	echo $row["name"]."<br>";
}
```

This basic example shows us how easy it is to utilize databases.  
However, if not securely coded, database code can lead to a variety of  
issues, like [SQL Injection vulnerabilities](https://owasp.org/www-community/attacks/SQL_Injection).

  

  

  

  

## Development Frameworks & APIs

  

---

In addition to web servers that can host web applications in various  
languages, there are many common web development frameworks that help in  
developing core web application files and functionality. With the  
increased complexity of web applications, it may be challenging to  
create a modern and sophisticated web application from scratch. Hence,  
most of the popular web applications are developed using web frameworks.

As most web applications share common functionality -such as user  
registration-, web development frameworks make it easy to quickly  
implement this functionality and link them to the front end components,  
making a fully functional web application. Some of the most common web  
development frameworks include:

- [Laravel](https://laravel.com/) (`PHP`): usually used by startups and smaller companies, as it is powerful yet easy to develop for.
- [Express](https://expressjs.com/) (`Node.JS`): used by `PayPal`, `Yahoo`, `Uber`, `IBM`, and `MySpace`.
- [Django](https://www.djangoproject.com/) (`Python`): used by `Google`, `YouTube`, `Instagram`, `Mozilla`, and `Pinterest`.
- [Rails](https://rubyonrails.org/) (`Ruby`): used by `GitHub`, `Hulu`, `Twitch`, `Airbnb`, and even `Twitter` in the past.

It must be noted that popular websites usually utilize a variety of frameworks and web servers, rather than just one.

  

  

## APIs

- An important aspect of back end web application development is the use of Web [APIs](https://en.wikipedia.org/wiki/API)  
    and HTTP Request parameters to connect the front end and the back end  
    to be able to send data back and forth between front end and back end  
    components and carry out various functions within the web application.
- trans data between front and back ends
- it is a parameter like the http request parameter also .

  

### Query Parameters

The default method of sending specific arguments to a web page is through `GET` and `POST` request parameters.

  

For example, a `/search.php` page would take an `item` parameter, which may be used to specify the search item. Passing a parameter through a `GET` request is done through the URL '`/search.php?item=apples`', while `POST` parameters are passed through `POST` data at the bottom of the `POST` `HTTP` request:

Code: http

```
POST /search.php HTTP/1.1
...SNIP...

item=apples
```

Query parameters allow a single page to receive various types of  
input, each of which can be processed differently. For certain other  
scenarios, Web APIs may be much quicker and more efficient to use. The [Web Requests module](https://academy.hackthebox.com/course/preview/web-requests) takes a deeper dive into `HTTP` requests.

  

Network protocols are **a set of rules outlining how connected devices communicate across a network to exchange information easily and safely**.  
Protocols serve as a common language for devices to enable  
communication irrespective of differences in software, hardware, or  
internal processes.

![[Screenshot_from_2023-09-05_05-36-04.png]]

  

[![](https://academy.hackthebox.com/storage/modules/75/api_examples.jpg)](https://academy.hackthebox.com/storage/modules/75/api_examples.jpg)

A weather web application, for example, may have a certain API to  
retrieve the current weather for a certain city. We can request the API  
URL and pass the city name or city id, and it would return the current  
weather in a `JSON` object. Another example is Twitter's API, which allows us to retrieve the latest Tweets from a certain account in `XML` or `JSON` formats, and even allows us to send a Tweet 'if authenticated', and so on.

  

  

  

  

- To enable the use of APIs within a web application, the developers have  
    to develop this functionality on the back end of the web application by  
    using the API standards like `SOAP` or `REST`.

  

  

what is the api standards ?

1. soap
2. rest

  

## SOAP

The `SOAP` ([Simple Objects Access](https://en.wikipedia.org/wiki/SOAP)) standard shares data through `XML`, where the request is made in `XML` through an HTTP request, and the response is also returned in `XML`. Front end components are designed to parse this `XML` output properly. The following is an example `SOAP` message:

Code: xml

```
<?xml version="1.0"?>

<soap:Envelope
xmlns:soap="http://www.example.com/soap/soap/"soap:encodingStyle="http://www.w3.org/soap/soap-encoding"><soap:Header></soap:Header><soap:Body><soap:Fault></soap:Fault></soap:Body></soap:Envelope>
```

`SOAP` is very useful for transferring structured data  
(i.e., an entire class object), or even binary data, and is often used  
with serialized objects, all of which enables sharing complex data  
between front end and back end components and parsing it properly. It is  
also very useful for sharing _stateful_ objects -i.e.,  
sharing/changing the current state of a web page-, which is becoming  
more common with modern web applications and mobile applications.

However, `SOAP` may be difficult to use for beginners or require long and complicated requests even for smaller queries, like basic `search` or `filter` queries. This is where the `REST` API standard is more useful.

  

  

![[Screenshot_from_2023-09-05_05-55-04.png]]

  

## REST

The `REST` ([Representational State Transfer](https://en.wikipedia.org/wiki/Representational_state_transfer)) standard shares data through the URL path 'i.e. `search/users/1`', and usually returns the output in `JSON` format 'i.e. userid `1`'.

Unlike Query Parameters, `REST` APIs usually focus on  
pages that expect one type of input passed directly through the URL  
path, without specifying its name or type. This is usually useful for  
queries like `search`, `sort`, or `filter`. This is why `REST`  
APIs usually break web application functionality into smaller APIs and  
utilize these smaller API requests to allow the web application to  
perform more advanced actions, making the web application more modular  
and scalable.

Responses to `REST` API requests are usually made in `JSON`  
format, and the front end components are then developed to handle this  
response and render it properly. Other output formats for `REST` include `XML`, `x-www-form-urlencoded`, or even raw data. As seen previously in the `database` section, the following is an example of a `JSON` response to the `GET /category/posts/` API request:

Code: json

```
{
  "100001": {
    "date": "01-01-2021",
    "content": "Welcome to this web application."
  },
  "100002": {
    "date": "02-01-2021",
    "content": "This is the first post on this web app."
  },
  "100003": {
    "date": "02-01-2021",
    "content": "Reminder: Tomorrow is the ..."
  }
}
```

`REST` uses various HTTP methods to perform different actions on the web application:

- `GET` request to retrieve data
- `POST` request to create data
- `PUT` request to change existing data
- `DELETE` request to remove data

  

  

  

# Back End Vulnerabilities :

[[Back End Vulnerabilities]]