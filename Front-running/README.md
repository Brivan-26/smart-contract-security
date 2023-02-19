# Smart Contract Security -Front Running

Front-running is a common issue on public blockchains such as Ethereum. A smart contract can have zero bugs but it can be still vulnerable to this attack.

### The Attack

Since all transactions are visisble in the mempool before getting executed, anyone in the network can observe those transactions and react to them before they get included in a block. This attack is commonly performed by increasing the `gasPrice` higher than the network average so the miners will mostly mine the attack transaction first.

One of the scenarios that this attack can be used is the one mentioned in `./FindHash-attack.sol`, the idea of the contract is simple:

- A pre-calculated hash is set on the contract.
- The one who figures the input that originated the hash will receive all the contract's ether via calling the function `solve` and passing the solution as a parameter.
  
Considering **A** found the solution, so he submits a transaction(invoking the function `solve(_solution)`). This transaction **will enter a mempool before it gets mined into a block**. And due to the fact that all transactions are visible in the mempool, network observers can see **A's** transaction, so they can see the *solution*. **B**(the attacker) after he sees the transaction, sends immediately an other transaction(`solve(_solution)`) and **increases the gasPrice** so mostly his transaction will be included in a block **before A's transaction**.


