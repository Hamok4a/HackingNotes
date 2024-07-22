# Lab: Username enumeration via response timing

PRACTITIONER

LAB Not solved

- This lab is vulnerable to username enumeration using its response times. To solve the lab, enumerate a valid username, brute-force this user's password, then access their account page.

- Your credentials: `wiener:peter`
- [Candidate usernames](https://portswigger.net/web-security/authentication/auth-lab-usernames)
- [Candidate passwords](https://portswigger.net/web-security/authentication/auth-lab-passwords)

#### Hint

To add to the challenge, the lab also implements a form of IP-based brute-force protection. However, this can be easily bypassed by manipulating HTTP request headers.

# Ans : 
- we used our users_wordlist that we had and then used the burp intruder to brute force for the users name and then we noticed that the time the wa took to response for our requests is more than the other requests time so we can understand that it is a correct  username  and the logic here is  that the website checks the username if it is wrong it stops and gives us the response but if the username is correct it will go to the  password param and checks it so if we used a password which is near to 100 character we will find that if the username is correct the response will get delayed because it will be checking for the big password and by that we can detect the correct username and start to brute force for the password.







