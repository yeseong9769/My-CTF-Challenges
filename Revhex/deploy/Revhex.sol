// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Revhex {
    address public immutable target;
    bool public solved = false;

    constructor() {
        bytes memory code = hex"3d602d80600a3d3981f363ffffffff80600143034016903a1681146017576033fe5b5060006000f3";
        address child;
        assembly {
            child := create(0, add(code, 0x20), mload(code))
        }
        target = child;
    }

    function flag() external {
        (bool succ,) = target.call(hex"");
        assert(succ);
        solved = true;
    }

    function isSolved() public view returns (bool) {
        return solved;
    }
}
