// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Gasgasgas {
    bool public solved;

    fallback() external payable {
        require(isContract(msg.sender), "It's Not contract!");
        for (uint i = 0; i < 1000; i++) {
        }
    }

    function solve() external {
        require(address(this).balance != 0, "recieved value is Zero");
        solved = true;
    }
    
    function isContract(address account) internal view returns (bool) {
        uint size;
        assembly { size := extcodesize(account) }
        return size > 0;
    }
}
