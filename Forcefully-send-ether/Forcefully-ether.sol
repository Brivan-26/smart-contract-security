//SPDX-License-Identifier: No-License

pragma solidity ^0.8.17;

contract A {

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}

contract B {
    function destruct(address _recipient) payable external {
        selfdestruct(payable(_recipient));
    }
}