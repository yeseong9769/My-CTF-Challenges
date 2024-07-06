// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract Is_contract {
    function isContract(address account) public view returns (bool) {
        uint size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    bool public solved = false;

    function protected() external {
        if (tx.origin != msg.sender) {
            require(!isContract(msg.sender), "no contract allowed");
            solved = true;
        }
    }
}