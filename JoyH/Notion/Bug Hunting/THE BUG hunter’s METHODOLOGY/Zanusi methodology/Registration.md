- Dorks => `site:example.com inurl:join inurl:& | site:example.com inurl:signup inurl:& | site:example.com inurl:register inurl:&`
        
1. What's required to sign up and where is it reflected ?

    - Uploading a photo
        1. determine file type
        2. change extension
    - name & description => `allowed characters only | XSS prevention? | test he mobile app`
2. Can I register with my social media account?
    - via Oauth?
    - allowed accounts ?
    - trusted info?
3. What characters are allowed? Is <> “ ' allowed in my name?
    
    - XSS
        - unicode, %00, %0d
    - test he mobile app
        
4. Can I sign up using @target.com or is it blacklisted?
    
5. What happens if I revisit the register page after signing up?
    - redirect parameter?
    - re-sign up as an authenticated user
6. Used parameters
    
7. Hunting in .js files
    - https://www.youtube.com/watch?v=0jM8dDVifaI
#Testing-Features
#Zseanos-Methodology