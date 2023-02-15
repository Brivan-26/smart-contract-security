# Smart Contract Security - Forcefully send Ether to a contract

In solidity, for a contract to be able to receive ether, it should have eiterh a **payable function**, **fallback payable function**, or **receive payable** function.

### The Attack

Ether can be sent forcefully to a contract that doesn't have any of the mentioned functions using `selfdestruct`.
**`sefldestruct` does not trigger a Smart Contract’s fallback function**, it removes the contract from the blockchain and sends the remaining balance to a payable address that is passed as parametere.
