---
tags:
  - Testing-Features
---
1. Is there a redirect parameter used? => `returnUrl |  goto |  return_url |  returnUri |  cancelUrl |  back |  returnTo`
2. What happens if I try login with myemail%00@email.com ? => try signup with my%00email@email.com and try for an account takeover
3. Can I login with my social media account?
    - via Oauth?
    - allowed accounts ?
    - same for all countries?
4. Mobile login flow differ from desktop?
    
5. Reset Password used parameters? => `Rate Limiting | Host header injection`
#Zseanos-Methodology