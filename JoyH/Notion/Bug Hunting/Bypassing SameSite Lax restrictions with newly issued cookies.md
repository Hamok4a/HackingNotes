## General information before solving the lab : 
- cookies with Lax same_site restrictions are not normally sent in any cross-site POST request only the get , ==but there are some exceptions== . 
- as we mentioned before , if a website doesnot include a samesite attribute  when setting a cookie , chorme will automatically applies Lax restrictions by default . 
- However to avoid breaking (SSO) single sign-on  mechanisms , it does wait for 120 seconds=2 minutes before appling those instrections
- The mention of waiting for two minutes in the context you provided is related to a specific behavior in the handling of SameSite cookie attributes by web browsers, particularly Chrome.
	When a website sets a cookie and doesn't specify the SameSite attribute, Google Chrome automatically applies default SameSite=Lax restrictions. However, to avoid potential issues with Single Sign-On (SSO) mechanisms, Chrome introduces a delay in enforcing these restrictions specifically for the first 120 seconds (two minutes) on top-level POST requests.
	
	The reason behind this delay is to accommodate scenarios where a user might be navigating between different sites as part of a Single Sign-On process. During the initial two minutes, the browser allows the cookie to be sent with top-level POST requests to prevent disruptions to SSO workflows. After this window, stricter SameSite=Lax restrictions are applied.
	
	In summary, the two-minute delay is a compromise to maintain compatibility with existing SSO mechanisms while still enforcing more robust SameSite cookie policies to enhance security against certain types of cross-site attacks.
	
- This two-minute window does not apply to cookies that were explicitly set with the `SameSite=Lax` attribute.
- Cookies with `Lax` SameSite restrictions aren't normally sent in any cross-site `POST` requests, but there are some exceptions.

As mentioned earlier, if a website doesn't include a `SameSite` attribute when setting a cookie, Chrome automatically applies `Lax` restrictions by default. However, to avoid breaking single sign-on (SSO) mechanisms, it doesn't actually enforce these restrictions for the first 120 seconds on top-level `POST` requests. As a result, there is a two-minute window in which users may be susceptible to cross-site attacks.

#### Note

This two-minute window does not apply to cookies that were explicitly set with the `SameSite=Lax` attribute.

It's somewhat impractical to try timing the attack to fall within this short window. On the other hand, if you can find a gadget on the site that enables you to force the victim to be issued a new session cookie, you can preemptively refresh their cookie before following up with the main attack. For example, completing an OAuth-based login flow may result in a new session each time as the OAuth service doesn't necessarily know whether the user is still logged in to the target site.

To trigger the cookie refresh without the victim having to manually log in again, you need to use a top-level navigation, which ensures that the cookies associated with their current [OAuth](https://portswigger.net/web-security/oauth) session are included. This poses an additional challenge because you then need to redirect the user back to your site so that you can launch the CSRF attack.

Alternatively, you can trigger the cookie refresh from a new tab so the browser doesn't leave the page before you're able to deliver the final attack. A minor snag with this approach is that browsers block popup tabs unless they're opened via a manual interaction. For example, the following popup will be blocked by the browser by default:

`window.open('https://vulnerable-website.com/login/sso');`

To get around this, you can wrap the statement in an `onclick` event handler as follows:

`window.onclick = () => { window.open('https://vulnerable-website.com/login/sso'); }`

This way, the `window.open()` method is only invoked when the user clicks somewhere on the page.
