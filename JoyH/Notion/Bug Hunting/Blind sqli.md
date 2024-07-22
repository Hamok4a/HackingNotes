	what do blind sqli means ? 
[[API-Key]]


actually it means ( blind ) so lets make it much more deeper -> it dont accept the using of the UNION way . 
as they are not effective . 
because UNION way depends on the ability to see the response of the requests sent to the server  so as they always said ( you can see the response sent by the request  as it is displayed  for the  normal user ( talking about the response not request )) 
so ...
# How to  exploit and detect a Blind SQL injection vulnerability  ? 
ans:  we trigger a conditional responses 
i think  from my old  information and experience we will just send a request that is maliciouse and contain an order to  sleep the response for  a 10 seconds and if we saw that result  ( in the responsing of the server ) we will  make sure that it is really infected with this kind of vulnerability . 
## looks like they used another way . . 
instead of target a normal parameter  that we think it may has a relation that relates it with the database  . 
- we target the cookie header that we are able to see  ( )
`Cookie: TrackingId=u5YD3PapBcR4lN3e7Tj4`
this is the cookie header we are talking about . 
when a request contains a TrackingID cookie is processed the application uses a SQL query to determine whether that value of it is presented in the database like this idea can be used every where i think with most  of the other values . 

-  if the query  we send ( in the value ) contains a positive value ( which means   found inside the DB) then we will get a msg "welcome back " 
- so we do a little mean thing which is we send 
- anyvalue' AND '1'='1  
- so it returns true so we get the welcome msg as if the  value is in the DB
- if we used a false condition this will result in no answer ( no " welcome back " msg will return back )
- 

table users 
columns username , password 
`anything' AND substring((select password from users where username='Administrator'), 1, 1 )'m

# Explain the blind sql injection vulnerability : 

## Exploiting blind SQL injection by triggering conditional responses
	`Cookie: TrackingId=u5YD3PapBcR4lN3e7Tj4`

### How to know if the cookie's token is vulnerable to blind sqli ? 
the thing that the WA is using in the normal case for the  normal case is 
`SELECT TrackingId FROM TrackedUsers WHERE TrackingId = 'u5YD3PapBcR4lN3e7Tj4'`  they use the  `u5YD3PapBcR4lN3e7Tj4` as the value of 
the tracking id token then  we will try to  use this token for a attacking vector . 

to check if the cookie's token is vulnerable to  sqli we will use  
`u5YD3PapBcR4lN3e7Tj4' and '1'='1` we will not put the other quotation because it is already in the place by the normal WA query  phrase . 

and also to check for the change of the response  after we used a condition that will reset a True value  then we will use another   one that will reset a False value to see the difference in the page  . 

### How to  know if a specific DB branches is  presented in the  system ? 



we are going to do that by assuming and trying a payload that contains our assumptions lets say that : 
table -> users 
columns -> username , password 
item -> Administrator  in  username column and of course he will have a corrisponding value in the password column and all of those stuff are in the users table . 
so lets see the payload : 
`cookie_token' AND  SUBSTRING() > 'm' `
so now we are saying that to get a welcome back msg for we have two conditions here 
1. that the cookie_token is valid 
 **AND** 
2. the sub_string ( which means a string that we get from a bigger string )  we are comparing that sub_string with the other string that we get from our  mind  and then we we compare them so in order for the second condition to  work probably we will need for the sub_string to present first and second the comparison to be valid i mean for the comparison to be working  in another word 2 will not be greater than  100 so if we put it as a comparison then we will  not get the welcome back response . 
#### how to use substring() to get a substring from a password that is presented inside of the users table in the column of password when the column of username contains the value ( Administrator) ? 

`cookie_token' AND substring((the payload that returns the bigger string ),the character number in the bigger  string ,the number of characters we are asking for    )`

so lets use the concept with our payload to fetch  the first one character from  the table users at column password when the column username is equal to Administrator 

`cookie_token' AND substring((select password from users where username='Administrator'),1,1)`
okay so this is a 10/10 explanation of it 
lets try to  get that into our token place in our real attack 
`u5YD3PapBcR4lN3e7Tj4' AND substring((select passwords from users where username='Administrator'),1,1)`
so by this it will fetch the first character and print it ( pass it ) in the response for the request 

BUT and as we are dealing with a blind sqli vulnerability ( there will no response_data  that we will see the response will be only the action of our condition if it is accepted(true) or refused(false) and we know that by seeing the length of the response_action  when false and when true ) 

so we will put another condition in the second part of the and logical operator if it got passed and we got accepted response action then the condition is true  and we will use that to check for what letter character did we got accepted as a comparison between it and the  substring extracted character 
so , 

In many query languages, the expression `'a' > 'a'` would evaluate to `False` or `0`. This is because you are comparing two identical values, 'a' and 'a', and in many programming languages, including SQL, when you compare two equal values using the greater than (`>`) operator, the result is `False` or `0`. This indicates that the two values are not in an order where one is greater than the other.

So, `'a' > 'a'` means that the character 'a' is not greater than the character 'a'; they are considered equal.

- **Objective of the Payload:**
    
    - The goal of the payload is to extract characters of the 'Administrator' account's password in a blind SQL injection attack.
- **Conditional Check:**
    
    - The payload includes a condition that compares the first character of the password with 'm' using the `> (greater than)` operator.
    - The condition is constructed to be true if the first character of the password is greater than 'm' in the ASCII or Unicode character encoding.
- **True vs. False:**
    
    - If the condition is true, it indicates that the first character of the password is indeed greater than 'm' (according to character encoding).
    - If the condition is false, it suggests that the first character of the password is not greater than 'm'.
- **Systematic Testing:**
    
    - The attacker uses tools like Burp Intruder to systematically test the condition by trying all alphabetic characters from 'a' to 'z'.
    - By doing this, they can identify the correct character of the password.
- **Inference from Responses:**
    
    - The application's response to the condition being true or false is what provides the attacker with information.
    - When the condition is true, the response might be different from when it's false, allowing the attacker to infer whether they've found the correct character.
- **Patience and Analysis:**
    
    - Successfully extracting the password character by character requires patience and a good understanding of SQL and the application's behavior.
    - It involves careful analysis of responses to make correct inferences.





### I found them using another payload so ...
`' AND (SELECT SUBSTRING(password,1,1) FROM users WHERE username='administrator')='u`

say said that the other condition is  select `somthing` from users where username='administrator' and they said that the output of that selection is equal to  the character 'u' .

so as we see the comparison is between something and a  only one characterized string  so  we are going to  compare it of course with another character not a string so we will extract that character  and  as the best  use of it in our current situation we will extract the passwords  character  that we want from the user administrator and compare it with the character we are thinking about  and  happy for my mind to not get exploded  that they used the equal operator instead of making the comparison greater or smaller which is really making sense this time  rather than the other time knowing that it also may be working . 