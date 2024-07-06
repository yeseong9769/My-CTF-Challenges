// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Adolescent {
    bool public solved;

    function solve(uint256 age) external {
        require(age >= 9 && age <= 24, "Only MZ generation access it.");
        solved = true;
    }
}