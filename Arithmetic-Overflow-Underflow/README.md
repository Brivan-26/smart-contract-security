# Smart Contract Security - Arithmetic Overflow & Underflow

**Arithmetic Overflow** is an attack that existed in previous Solidity versions(< 0.8.0), because Solidity **does not care how you operate your math operations**. However, the newer versions of Solidity(>= 0.8.0) fixed that.

### The Attack

**Arithmetic Overflow** happens when we increase the value of the variable and as a result, the value exceeds the limit. 
Example: Supposing we have the following state variable `uint8 public totalSupply = 250`, the **uint8** means that the values range that totalSupply can take is between **0, and 2^8 - 1**, in another way between **0 and 255**. The initial value is 250 which is fine as it is included in the range.
Imagine now we have a function that increases the totalSupply value:
```
function increaseTotalSupply(uint8 _amount) external {
    totalSupply += _amount
}
```
If we invoke the `increaseTotalSupply(7)`, the totalySupply value will be__*logically* **257**, but **257 is greater than the maximum value of a uint8**, so as a result, the value of the variable will start over from **0**, which leads to having a value of **1**.

**Arithmetic underflow** is the same as **Overflow**, only that it is in the inverse way(we decrease the value, so it is no longer >=0, which leads to start from the **maximum value**).
For the last given example(`uint8 public totalySupply = 250`), if we have a function that decreases the totalSupply value by a given amount and we invoke it like: `decreaseTotalSupply(251)`, the totalSupply value will be updated to **255**.

### The solution

- The easiest and **recommended** solution is to upgrade to a newer version of Solidity(**>=0.8.0**) and the problem will be solved by the core Solidity as it automatically checks for overflows and underflows
- Use the **SafeMath** library provided by **OpenZeppelin* for older versions.

