# Project Tracking:

1. xmind

1. vim
2. notepad++
3. XLS

  

MISSIONS:

![[Screenshot_from_2023-09-18_03-48-57.png]]

![[TOOLS.pdf]]

  

  

  

  

  

  

  

  

# Links for write ups:

[https://hackerone.com/hacktivity/overview](https://hackerone.com/hacktivity/overview)

[medium.com](http://medium.com)

[https://infosecwriteups.com/](https://infosecwriteups.com/)

  

# best website ever

[https://book.hacktricks.xyz/welcome/getting-started-in-hacking](https://book.hacktricks.xyz/welcome/getting-started-in-hacking)

  

# imp advice from linked in hacker:

[Sameh Mohamed  
  
](https://www.linkedin.com/in/ACoAAD3dDp4Bgv5fY0cA1Miog2xaajpaahLK61I)  
  
  
  
  
6:09 PM

Zseano's methodology, it will help you how to think like hackers . Not about xss only

# helpful

💡

machine helpful commands:

واحدة من المشاكل الي كانت بتقابلني و انا بحل علي

[TryHackMe](https://www.linkedin.com/company/tryhackme/)

و هي ان لما كنت باخد intial access علي machine مكنتش بعرف اعمل ايه و هنا مش بتكلم عن ال privilege escalation مثلا .

انا اقصد ازاي اجمع information او اعمل enumeration لل system بعد ما عملت foothold علي ال machine ؟!

عشان كدة جمعت شوية commands الي ممكن تساعدك لو انت محتار تدور فين او تبدا من فين (for Linux) .

بص في تقسيمة جامدة لل commands و هي تنقسم ل 5 categories :

1- System

2- Users

3- Networking

4- Services

5- Password

[#System_Commands](https://www.linkedin.com/feed/hashtag/?keywords=system_commands&highlightedUpdateUrns=urn%3Ali%3Aactivity%3A7116584468747853824)

:

1- cat ==> /etc/*-release

==> /var/mail

==> /proc/version

==> /etc/issue

==> /etc/passwd

==> /etc/group

==> /etc/shadow

2- hostname

3- env

4- history

5- uname -a

6- ls /usr/bin

7- dpkg -l ( for debian !)

8- find (اي حاجة بقا)

9- ls ==> /home

==> /root ( ساعات بننساهم برضو)

____________________

[#User_Commands](https://www.linkedin.com/feed/hashtag/?keywords=user_commands&highlightedUpdateUrns=urn%3Ali%3Aactivity%3A7116584468747853824)

:

1- who , w , whoami

2- id

3- last

4- sudo -l

__________________

[#Networking_Commands](https://www.linkedin.com/feed/hashtag/?keywords=networking_commands&highlightedUpdateUrns=urn%3Ali%3Aactivity%3A7116584468747853824)

:

1- ip a s

2- cat /etc/resolv.conf

3- netstat -atupn

4- lsof -i

______________________

[#Services_Commands](https://www.linkedin.com/feed/hashtag/?keywords=services_commands&highlightedUpdateUrns=urn%3Ali%3Aactivity%3A7116584468747853824)

:

1- ps -elf

2- ps aux

3- ps axjf

______________________

[#Passwords_Commands](https://www.linkedin.com/feed/hashtag/?keywords=passwords_commands&highlightedUpdateUrns=urn%3Ali%3Aactivity%3A7116584468747853824)

:

1-  grep --color=auto -rnw '/' -ie "PASSWORD" --color=always 2>/dev/null

2- locate password | more

و بس كدة

  

# Zseano’s Methodology

[[Zseano’s Methodology]]