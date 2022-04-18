# What is the difference between CORS and CSPs

question source: <https://github.com/trimstray/test-your-sysadmin-skills>

What is the difference between CORS and CSPs?

CORS allows the Same Origin Policy to be relaxed for a domain.

e.g. normally if the user logs into both example.com and example.org, the Same Origin Policy prevents example.com from making an AJAX request to example.org/current_user/full_user_details and gaining access to the response.

This is the default policy of the web and prevents the user's data from being leaked when logged into multiple sites at the same time.

Now with CORS, example.org could set a policy to say it will allow the origin <https://example.com> to read responses made by AJAX. This would be done if both example.com and example.org are ran by the same company and data sharing between the origins is to be allowed in the user's browser. It only affects the client-side of things, not the server-side.

CSPs on the other hand set a policy of what content can run on the current site. For example, if JavaScript can be executed inline, or which domains .js files can be loaded from. This can be beneficial to act as another line of defense against XSS attacks, where the attacker will try and inject script into the HTML page. Normally output would be encoded, however say the developer had forgotten only on one output field. Because the policy is preventing in-line script from executing, the attack is thwarted.
