  

# 1. Common Web Vulnerabilities:

- If we were performing a penetration test on an internally developed web  
    application or did not find any public exploits for a public web  
    application, we may manually identify several vulnerabilities. We may  
    also uncover vulnerabilities **==caused by misconfigurations==**, even in  
    publicly available web applications, since these types of  
    vulnerabilities are not caused by the public version of the web  
    application but by a misconfiguration made by the developers. The below  
    examples are some of the most common vulnerability types for web  
    applications, part of [OWASP Top 10](https://owasp.org/www-project-top-ten/) vulnerabilities for web applications.
    - **Broken Authentication/Access Control**
        - For example, `College Management System 1.2` has a simple [Auth Bypass](https://www.exploit-db.com/exploits/47388) vulnerability that allows us to login without having an account, by inputting the following for the email field: `' or 0=0 #`, and using any password with it.
    - **Malicious File Upload**
        
        - Another common way to gain control over web applications is through  
            uploading malicious scripts. If the web application has a file upload  
            feature and does not properly validate the uploaded files, we may upload  
            a malicious script (i.e., a `PHP` script), which will allow us to execute commands on the remote server.
        - Even though this is a basic vulnerability, many developers are not  
            aware of these threats, so they do not properly check and validate  
            uploaded files. Furthermore, some developers do perform checks and  
            attempt to validate uploaded files, but these checks can often be  
            bypassed, which would still allow us to upload malicious scripts.
        - For example, the WordPress Plugin `Responsive Thumbnail Slider 1.0` can be exploited to upload any arbitrary file, including malicious scripts, by uploading a file with a double extension (i.e. `shell.php.jpg`). There's even a [Metasploit Module](https://www.rapid7.com/db/modules/exploit/multi/http/wp_responsive_thumbnail_slider_upload/) that allows us to exploit this vulnerability easily.
        
        ---
        
    - **Command Injection**
        - Many web applications execute local Operating System commands to  
            perform certain processes. For example, a web application may install a  
            plugin of our choosing by executing an OS command that downloads that  
            plugin, using the plugin name provided. If not properly filtered and  
            sanitized, attackers may be able to inject another command to be  
            executed alongside the originally intended command (i.e., as the plugin  
            name), which allows them to directly execute commands on the back end  
            server and gain control over it. This type of vulnerability is called [command injection](https://owasp.org/www-community/attacks/Command_Injection).
        - This vulnerability is widespread, as developers may not properly  
            sanitize user input or use weak tests to do so, allowing attackers to  
            bypass any checks or filtering put in place and execute their commands.
        - For example, the WordPress Plugin `Plainview Activity Monitor 20161228` has a [vulnerability](https://www.exploit-db.com/exploits/45274) that allows attackers to inject their command in the `ip` value, by simply adding `| COMMAND...` after the `ip` value.
    - **SQL Injection (SQLi)**

# 2. Public Vulnerabilities:

# Public Vulnerabilities

---

The most critical back end component vulnerabilities are those that  
can be attacked externally and can be leveraged to take control over the  
back end server without needing local access to that server (i.e.,  
external penetration testing). These vulnerabilities are usually caused  
by coding mistakes made during the development of a web application's  
back-end components. So, there is a wide variety of vulnerability types  
in this area, ranging from basic vulnerabilities that can be exploited  
with relative ease to sophisticated vulnerabilities requiring deep  
knowledge of the entire web application.

## Public CVE

As many organizations deploy web applications that are publicly used,  
like open-source and proprietary web applications, these web  
applications tend to be tested by many organizations and experts around  
the world. This leads to frequently uncovering a large number of  
vulnerabilities, most of which get patched and then shared publicly and  
assigned a CVE ([Common Vulnerabilities and Exposures](https://en.wikipedia.org/wiki/Common_Vulnerabilities_and_Exposures)) record and score.

Many penetration testers also make proof of concept exploits to test  
whether a certain public vulnerability can be exploited and usually make  
these exploits available for public use, for testing and educational  
purposes. This makes searching for public exploits the very first step  
we must go through for web applications.

Tip: The first step is to identify the version of the  
web application. This can be found in many locations, like the source  
code of the web application. For open source web applications, we can  
check the repository of the web application and identify where the  
version number is shown (e.g,. in (version.php) page), and then check  
the same page on our target web application to confirm.

Once we identify the web application version, we can search Google  
for public exploits for this version of the web application. We can also  
utilize online exploit databases, like [Exploit DB](https://www.exploit-db.com/), [Rapid7 DB](https://www.rapid7.com/db/), or [Vulnerability Lab](https://www.vulnerability-lab.com/). The following example shows a search for WordPress public exploits in [Rapid7 DB](https://www.rapid7.com/db/):

[![](https://academy.hackthebox.com/storage/modules/75/rapid7-db.jpg)](https://academy.hackthebox.com/storage/modules/75/rapid7-db.jpg)

We would usually be interested in exploits with a CVE score of 8-10 or exploits that lead to `Remote Code Execution`. Other types of public exploits should also be considered if none of the above is available.

Furthermore, these vulnerabilities are not exclusive to web  
applications and apply to components utilized by the web application. If  
a web application uses external components (e.g., a plugin), we should  
also search for vulnerabilities for these external components.
