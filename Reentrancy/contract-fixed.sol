//SPDX-License-Identifier: No License
pragma solidity ^0.8.17;

// Two Possible fixes:
//     1. update the state before calling calling external functions
//     2. Executing the withdraw function on mutual exclusion

contract ETHStore {

    mapping(address => uint) private balances;
    bool isLocked = false; // fix 2

    function deposit() external payable {
        require(msg.value > 0);
        balances[msg.sender] += msg.value;
    }

    function withdraw() external mutex {
        uint balance = balances[msg.sender];
        balances[msg.sender] = 0; // fix 1


        require(balance > 0, "You have no balance stored");
        (bool success, ) =payable(msg.sender).call{value: balance}("");
        require(success, "Transfer failed");   
    }


    function getBalance() external view returns(uint){
        return address(this).balance;
    }

    // fix 2
    modifier mutex {
        require(!isLocked, "No re-entrancy attack");
        isLocked = true;
        _;
        isLocked = false;
    }
}