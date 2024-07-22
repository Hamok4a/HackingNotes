- [](https://portswigger.net/web-security/authentication/password-based/lab-broken-bruteforce-protection-ip-block)

# Lab: Broken brute-force protection, IP block

This lab is vulnerable due to a logic flaw in its password brute-force protection. To solve the lab, brute-force the victim's password, then log in and access their account page.

- Your credentials: `wiener:peter`
- Victim's username: `carlos`
- [Candidate passwords](https://portswigger.net/web-security/authentication/auth-lab-passwords)

#### Hint

Advanced users may want to solve this lab by using a macro or the Turbo Intruder extension. However, it is possible to solve the lab without using these advanced features.




# Ans : 
- we will get block  after trying to log in with carlos for two times and at the third time we get blocked  for 1 min so to bypass that and as we found that  if we logged in correctly the failed log in counter getts reseted we will  log in our main account (wiener:peter) after each wrong login in carlos account so that the counter never  gets to the limit and makes us blocked . 