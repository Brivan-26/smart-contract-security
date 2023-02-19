//SPDX-License-Identifier: No-License

pragma solidity ^0.8.17;

contract FindTheHash {

    bytes32 constant public hash = 0x69868b59cab0f269284b96acca5549ab804095fcb452d64aba3c904bc82117bc;

    constructor() payable {}

    function solve(string memory _solution) external {
        require(hash == keccak256(abi.encodePacked(_solution)), "Incorrect value!");

        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("Congrats!");
        require(success, "Transfer failed!");
    }
}
