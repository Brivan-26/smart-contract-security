# Smart Contract Security - Reentrancy attack

**Reentracy** is one of the most famous attacks in smart contracts. The first kind of this attack was in 2016, known as `The DAO hack` which resulted in *3.6 Million ETH being stolen*, and because of that, the famous hard fork of Ethereum happened.

### The Attack

The `./Reentrancy-attack.sol` demonstrates a case of a reentrancy attack. Two contracts were created: **ETHStore** contract(the vulnerable one), and the **Attack** contract.

The **ETHStore** contract simply allows users to store ethers, and withdraw them later. 
An attacker may exploit the contract as following:
- Creating the **Attack** contract
- Invoking the *attack* function, and sending along 1 Ether for example
  - The attack function deposits that 1 Ether to *ETHStore* contract
    - As result, in the **ETHStore** contract, a new record is adding on the `balances state`(Attack's contract address => 1)
  - The attack function then calls the *withdraw* function
  - The **ETHStore** starts executing the withdraw function: checking *Attack's* balance, then sending back ether via the low level `call method`, ***and here starts the attack(line 17)***
- After sending back ether(line 17 **ETHStore**), the **Attack** contract executes the **receive** fallback, which invokes again the **ETHStore's** withdraw function
- The recursion starts happening, the `require(balance > 0, "You have no balance stored");` will always be true as **updating state is only after finishing the `.call function(line 20)`, which gonna happen AFTER the recursion**

### The solution

Two possible solutions to avoid this kind of attacks:
- Updating the state **before** the calling of external functions
- Executing external functions in **mutual exclusion**

Both solutions are applied in `./contract-fixed.sol`

[Read more](https://github.com/ethereumbook/ethereumbook/blob/develop/09smart-contracts-security.asciidoc#reentrancy)
