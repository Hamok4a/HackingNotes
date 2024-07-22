# Concept
- Race condition closely related to business logic flaws .
- happens when websites process requests concurrently without adequate safeguards. 
![[Race Condition-20240124142114554.webp]]
- The period of time during which a collision is possible is known as the "race window".
- This could be the fraction of a second between two interactions with the database
- ## someTypes:
	- ## Limit overrun race conditions
		- it is about exceeding some kind of limit imposed by business logic of the applicationl.
		- for example: one time discount coupon send it multiple times at the same time  via  many requests at the same time  and by that it got accepted multiple times. 
		 ![[Race Condition-20240124151337155.webp]]
		 after the race condition  (limit over run  race condition)
		 ![[Race Condition-20240124151511735.webp]]

		- 
---
# Exploitation
- we found that  request :
![[Race Condition-20240124153639691.webp]]
-  i made  ( group reqests tabs ) and send them all in send group ( parallel ) which leaded into  the request  leading into multiple times 17 times discount by 20 percent of the real value of the jacket which was 1377 dollar and at the end i got the jacket in less than 50 dollar . and this is limitation over-run race condition 

---
# Cases
- Sometimes you will find that the first request sent to the server takes much longer time to be processed so  you will need to make connection warming before attempting to send the  parallel requests  via  putting get / at the begging of the parallel requests you are trying to send in the group tab 
- when you find that your data (activity you are trying to use race condition on and want to know if there might be collision possibility ) You will need to check that via deleting the cookies from you request and this will lead to you noticing if the response is still the same then no collision as the data is depending on client side which is your browser so no collision , else you can find collision here if the response became empty as this means that the data is server side dependent which will lead to possibility of collision  true .
- # multi-endpoint race condition : 
	![[Race Condition-20240125071831939.webp]]
- # single Endpoint race condition 
	- sending parallel requests with different values to a single endpoint. 
	- Email address confirmations, or any email-based operations, are generally a good target for single-endpoint race conditions.
	- if : password reset mechanism  stores ( userID , Pass_reset_token) inside the user's session.
# Labs:
![[Race Condition-20240126103037572.webp]]
- we got two requests sending the  the Post/change email   and through them if we send the request multiple times in a tab via parallel way but each request contains a different email the  result will be  they will both be depending on the same token that will be sent to both of them .
- ![[Race Condition-20240126103432515.webp]]
- the request will be sent to the email of us  containing the token of the victim and its token .
- ![[Race Condition-20240126103628728.webp]]
---
---
## Session-based locking mechanisms

Some frameworks attempt to prevent accidental data corruption by using some form of request locking. For example, PHP's native session handler module only processes one request per session at a time.

It's extremely important to spot this kind of behavior as it can otherwise mask trivially exploitable vulnerabilities. If you notice that all of your requests are being processed sequentially, try sending each of them using a different session token.

### if the phpsessionid  is present and correct : 
![[Race Condition-20240126113648749.webp]]
### but if it is not : 
- then the website will put it using   set-cookie  header and then it will make us  able to use it and also it will give us csrf header if required . 
- ![[Race Condition-20240126113813929.webp]]
- as you see  and the csrf value set to that phpsessionid is  : 
- ![[Race Condition-20240126113910583.webp]]
- we will use them in there .