**preparing for the Lab**:
- servers aren't always fussy about whether they receive a GET or POST request to a given endpoint . 
- we just need to make the victim send a GET request ( eliciting a GET request form the victim's browser )
- as long as the request method is GET 
- and the request involves a top-level navigation , the browser will still include the victim's session cookie . 
- Top-Level navigation refers to 
	- when a script or  a code  initiates navigation to a new URL 
- even if the user can't send a get request  as if it is not allowed we still can make it send by using a  conversion in the middle  
	- we will send a normal POST but we will make it convert it self after the  sending  
```html
<form action="https://vulnerable-website.com/account/transfer-payment" method="POST"> <input type="hidden" name="_method" value="GET"> <input type="hidden" name="recipient" value="hacker"> <input type="hidden" name="amount" value="1000000"> </form>
```
- as we saw it converted it self by using 
  `<input type="hidden"  name="_method" value="GET"> `
- in the normal cases we use 
```JS
<script> document.location ='https://vulnerable-website.com/account/transfer-payment?recipient=hacker&amount=1000000'; 
</script>
```
document.location="targeted_url";


---
## what did we did ? to solve the lab ??
1. we found at the end that the request of post is getting accepted but the request of get is not accepted to  we used the `_method` to change the request that we are sending into a post because the request  of the post is only the one who gets accepted but the get request is not so   we made the request  a get request but after that get request gets sent the website will give it the  cookies we are aiming for and then the request will get converted into  POST  because we said  that it's method is post  `_method=POST`
	and here is a couple of photos 
only the post method is getting accepted for the email-change functionality to get work
![[Pasted image 20231126225832.png]]
but the GET method is not allowed 
![[Pasted image 20231126225934.png]]

# but 
we bypassed that refuse by using the conversion in the middle using `_method=POST` 
![[Pasted image 20231126230025.png]]
and wlaaaa it got accepted and here we will use it in a  JS crafted attack 
and here is the 
JS
```JS
<script> document.location = "https://YOUR-LAB-ID.web-security-academy.net/my-account/change-email?email=pwned@web-security-academy.net&_method=POST"; </script>
```