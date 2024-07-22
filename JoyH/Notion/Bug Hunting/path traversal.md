
## what is path traversal ? 

- ![[Pasted image 20231124133959.png]]
- path traversal is also known as  directory traversal 
- path traversal = directory traversal : allows the attacker to read arbitrary files on the system like 
	`/etc/passwd`
- and read other files like 
 
1. Application code and data 
	2. Credentials for back-end system 
	3. Sensitive operating system files 

in some other cases attacker may be able to write in the arbitrary files and take over the server . \
## Reading arbitrary files via path traversal

Imagine a shopping application that displays images of items for sale. This might load an image using the following HTML:

`<img src="/loadImage?filename=218.png">`

The `loadImage` URL takes a `filename` parameter and returns the contents of the specified file. The image files are stored on disk in the location `/var/www/images/`. To return an image, the application appends the requested filename to this base directory and uses a filesystem API to read the contents of the file. In other words, the application reads from the following file path:

`/var/www/images/218.png`

This application implements no defenses against path traversal attacks. As a result, an attacker can request the following URL to retrieve the `/etc/passwd` file from the server's filesystem:

`https://insecure-website.com/loadImage?filename=../../../etc/passwd`

This causes the application to read from the following file path:

`/var/www/images/../../../etc/passwd`

The sequence `../` is valid within a file path, and means to step up one level in the directory structure. The three consecutive `../` sequences step up from `/var/www/images/` to the filesystem root, and so the file that is actually read is:

`/etc/passwd`

On Unix-based operating systems, this is a standard file containing details of the users that are registered on the server, but an attacker could retrieve other arbitrary files using the same technique.

On Windows, both `../` and `..\` are valid directory traversal sequences. The following is an example of an equivalent attack against a Windows-based server:

`https://insecure-website.com/loadImage?filename=..\..\..\windows\win.ini`

### Common obstacles to exploiting path traversal vulnerabilities 
- many application that places user's input in a file paths implement  defenses against path traversal attacks this can often be bypassed  . 
- the obstacle  : how to bypass it 
	the target application blocks the directory traversal sequences ( ../../../) : how to bypass that ? 
	ans :  first way : try to directly use the absolute path from the filesystem root , without any traversal sequances . 
	we might also use another way 
	second way: nested traversal sequances , such as (....//)or (....\/) this will be something like alalertert that is used when the application  just uses a black list and delete them  but not comming to check again at the result of the  final input . 
 in some other contexts , such as in GET ( url path of filename param) of a multipart /form-data request , the webservers may  strip any directory traversal sequencds before passing your input to the application . so we may try to url encode our payload or even double url encoding  
 some other  cases the  application may require the user-supplied filename to start with the expected  base folder  , such as `/var/www/images`  in this case , it might be possible toinclude the required base folder followed by suitable traversal sequences . for example: 
	 filename=/var/www/images/../../../etc/passwd
 another case : 
 some applications may require the user-supplied filename to end with an expected file extension such as `.png`  in this case , it might be possible to use a null byte ( %00) to effectively terminate  the file path before the required extension . for example 
 `filename=../../../etc/passwd%00.png` 
 what is a null byte and what does it do ? 
 - null byte is often used as a string terminator 
 - /0 is the null terminator in c language but in the context of the url encoding  it is  %00  so take care of the null terminator because it is a very powerfull method . 
 - 
