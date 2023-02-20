# Smart Contract Security - Hiding Malicious Code

A smart contract code can be easily verified using `Etherscan.io`, so it creates a sort of trust for the contract. **However, attackers are smart and there is a way to hide a malicious code**.

### The Attack

To better explain the attack, a [smart contract](./logMe-attack.sol) written will be analyzed:

Someone reading the `Contract B` will tell that invoking the function `callA()` will result in invoking the function `log()` which is defined on the `contract A` because the state variable `a` is initialized by the **A's contract address** passed as argument in the constructor.

An attacker may exploit the contract as following:

- Writes the `Malicious Contract` and **deploy it first**.
  - `notice that it has a log() function with the same signature of the contract A's log() function`
- **Deploy the Contract B and passes the deployed Malicious contract address to the constructor**
- Putting both Contract A & Contract B codes inside the `Etherscan.io`

So after someone calls the `callA` function in contract B, he thinks that he is interacting with the contract A, while he is interacting with the `Malicious contract`. Keep in mind: 
` Solidity doesn't guarentee that calling a.log() will result in calling the log() function inside the contract A, but it makes sure that the log() function will be called at the address a`

### The solution

The solution is simple: **Never trust outside addresses that are passed to the constructor, they must be checked before interacting with the contract.**