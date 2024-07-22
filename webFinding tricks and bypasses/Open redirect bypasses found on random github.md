### Open redirect bypasses

[](https://gist.github.com/0xblackbird/d7677a05ea50586cf2be0a601e665d1a#open-redirect-bypasses)

- Simply try to change the domain
    
    **Example: ?redirect=[https://example.com](https://example.com) --> ?redirect=[https://evil.com](https://evil.com)**
    
- Bypass the filter when protocol is blacklisted using `//`
    
    **Example: ?redirect=[https://example.com](https://example.com) --> ?redirect=//evil.com**
    
- Bypass the filter when double slash is blacklisted using `\\`
    
    **Example: ?redirect=[https://example.com](https://example.com) --> ?redirect=\evil.com**
    
- Bypass the filter when double slash is blacklisted using `http:` or `https:`
    
    **Example: ?redirect=[https://example.com](https://example.com) --> ?redirect=https:example.com**
    
- Bypass the filter using `%40`
    
    **Example: ?redirect=example.com --> ?redirect=example.com%40evil.com**
    
- Bypass the filter if it only checks for domain name
    
    **Example: ?redirect=example.com --> ?redirect=example.comevil.com**
    
- Bypass the filter if it only checks for domain name using a dot `%2e`
    
    **Example: ?redirect=example.com --> ?redirect=example.com%2eevil.com**
    
- Bypass the filter if it only checks for domain name using a query/question mark `?`
    
    **Example: ?redirect=example.com --> ?redirect=evil.com?example.com**
    
- Bypass the filter if it only checks for domain name using a hash `%23`
    
    **Example: ?redirect=example.com --> ?redirect=evil.com%23example.com**
    
- Bypass the filter using a `°` symbol
    
    **Example: ?redirect=example.com --> ?redirect=example.com/°evil.com**
    
- Bypass the filter using a url encoded Chinese dot `%E3%80%82`
    
    **Example: ?redirect=example.com --> ?redirect=evil.com%E3%80%82%23example.com**
    
- Bypass the filter if it only allows you to control the path using a nullbyte `%0d` or `%0a`
    
    **Example: ?redirect=/ --> ?redirect=/%0d/evil.com**