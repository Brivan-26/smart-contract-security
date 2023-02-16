# Smart Contract Security -Insecure Randomness

In most programming languages, if we want to generate a random number it is super trivial to do so by using built-in methods. But **in Solidity it is extermly difficult to generate a secure random number number**

### The Attack

A common technique to generate a random number is to hash together the `block.timestamp` and `block.number - 1` as they seem random, **while they are not**.

Why the `block.timestamp` and `block.number - 1` seem random input?

- At the time of calling a function*__creating a transaction*, the block is not yet mined, and it's mining time is unkown so the `block.timestamp` is hard to be guessed. Same thing with `block.number - 1`.

To demonstrate in a practical example, a vulnerable contract is created in `./Lottery-attack.sol`.
The contract's logic is simple:

```shell
Someone calls the guess function and passes a uint _guess parameter, the function calculates a *randomAnswer* number by hashing along the *block.timestamp* and *block.number - 1*.
```
If the `randomAnswer` equals the `_guess` the **msg.sender** receives the contract's balance.

However, the **Attack** contract may exploit easily the Lottery contract. Yes, it is hard for us*__humans* to predict the `block.timestamp` and `block.number - 1`, but for a smart contratc it is easy.
The attacker invokes the `attack` function, this function calculates the randomAnswer which will be **exactly the same** that will be caluclated in `Lottery.guessToWin`, **because both transactions will be mined in the same block**.
