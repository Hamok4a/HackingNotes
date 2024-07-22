---
tags:
  - Testing-Features
---
1. Is there any CSRF protection? => `try to send a blank CSRF token, or a token with the same length`
	
2. Any second confirmation for changing your email/password? => `If no. chain this with XSS for account takeover`
      
3. How do they handle basic `< > “ '` characters and where are they reflected?
	
4. If I can input my own URL on my profile, what filtering is in place to prevent something such as javascript:alert(0)?
    
5. Is it a different process on the mobile app?
    
6. How do they handle photo/video uploads (if available)?
    
- What information is actually available on my public profile that I can control?  
    what I can control and how and where it’s reflected
#Zseanos-Methodology