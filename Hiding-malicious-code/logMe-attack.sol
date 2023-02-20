//SPDX-License-Identifier: No-license

pragma solidity ^0.8.17;

contract A {
    event Log(string message);

    function log() public {
        emit Log("A was called");
    }
}

contract B {
    A public a;

    constructor(A _address) {
        a = A(_address);
    }

    function callA() public {
        a.log();
    }
}


contract Malicious {
    event Log(string message);

    function log() public {
        emit Log("A was called");
        emit Log("Malicious code!");
        // malicious code goes here...
    }
}