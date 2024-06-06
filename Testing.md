## BWW Vue testing strategy (WIP)

![BWW-testing-strategy.drawio.png](/.attachments/BWW-testing-strategy.drawio-b65c3604-4802-4fb9-8c83-60f176d7b4a4.png)

We should aim for the majority of tests to be black-box tests using @testing-library/vue as it encourages writing tests from the user perspective. "I click here, I see this" instead of "I'm calling function, I observe internal state change".

Whitebox tests should be used when we're either testing some complex and critical logic that would require many-many tests to cover all cases that we care about.
If doing black-box testing requires too much setup and isn't easily achievable - perhaps we're trying to test something that we shouldn't be testing to begin with.

testing-library encourages us to write tests from the user perspective (click stuff, see stuff), which is blackbox because we don't care what happens inside of methods/state/etc.

test-utils allow us to actually call certain methods, see what they return, check internal state of components, etc. - hence whitebox.

So if you're trying to test internal state of component or data returned by a specific method - we can't test it with blackbox testing-library approach. And we only should be testing these things for very critical/important stuff, otherwise, every little refactoring will break tests which isn't great.

Refer to the flow chart below:
"Yes" path is always down, "No" path is always to the right. Stuff in the clouds is comments/examples for the path next to the cloud.
![BWW-testing-strategy-Page-2.drawio (4).png](/.attachments/BWW-testing-strategy-Page-2.drawio%20(4)-e4edd392-d283-41b2-a84f-0fe6d48f20cd.png)

https://docs.google.com/spreadsheets/d/1UytHl_1cJq48jiEU64cOl91qnyzI1yZHu_qyG-zSPcE/edit?usp=sharing