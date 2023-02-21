# Smart Contract Security - Hiding Malicious Code
One of the ambiguities out there is the difference between `msg.sender` and `tx.origin` globlal variables, and some think that their use cases are changeable, **while this is NOT true**, the following attack will demonstrate that.

### The Attack

Take a look at the [Donate contract](./Donate-attack.sol), anyone can send ether to the contract but **it seems** that only the owner can call the `withdraw` function due to the verification on the first instruction inside the `withdraw` function (`require(tx.origin == owner)`). However, **this is not true** because `tx.origin` refers to the **account address that initiated the function**.  <br />
So if for example: `user => contract A => contract B`, meaning that a user invokes a function in the contract A which invokes a function located in the contract B, the `tx.origin` in the invoked function in the contract B will refer to the **user's address** as he is the one who **initiated the transaction**, while `msg.sender` will refer to the **Contract A's address** because it is the one who **invoked the function**.<br />

Going back to our [Donate contract](./Donate-attack.sol), a `contract Attack` is created with a `phish` function, which calls the withdraw function located inside the `Donate` contract, passing as argument the attacker's address.<br/> If the *owner of the `Donate` contract* invokes the `phish()` function, the `require` statement inside the `withdraw` function will pass because the owner(tx.origin) is the one who initiated the transaction, and as a result, ***the attacker will receive all the contract's balance***.

### The solution

The solution is simple: **if a verification is needed to konw who `invoked` a function, `msg.sender` must be used instead of `tx.origin`**.