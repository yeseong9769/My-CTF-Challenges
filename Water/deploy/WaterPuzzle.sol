// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
#### 비커에 물 채우기 ####
1. 4L, 7L, 8L 비커를 가지고 10L 비커를 채우면 성공
2. 10L 비커에는 이미 3L의 물이 들어있다.
3. 물은 4L 비커에서 7L 비커로, 7L 비커에서 8L 비커로, 8L 비커에서 10L 비커로만 옮길 수 있다.
4. 다른 비커로 물을 옮길 때마다 1L가 증발
5. 비커는 꽉 채우지 않아도 물을 옮길 수 있다.
6. 4L 비커는 처음부터 꽉 채워져 있으며, 비울 때마다 자동으로 4L 채워진다.
*/

contract WaterPuzzle {
    uint256 public beaker4;
    uint256 public beaker7;
    uint256 public beaker8;
    uint256 public beaker10;

    bool public solved;

    constructor() {
        beaker4 = 4;
        beaker7 = 0;
        beaker8 = 0;
        beaker10 = 3;
        solved = false;
    }

    function pour4to7() public {
        require(beaker4 > 0, "4L beaker is empty");
        require(beaker7 < 7, "7L beaker is full");

        uint256 pourAmount = min(beaker4 - 1, 7 - beaker7);
        beaker4 -= (pourAmount + 1);
        beaker7 += pourAmount;

        beaker4 = 4;
    }

    function pour7to8() public {
        require(beaker7 > 0, "7L beaker is empty");
        require(beaker8 < 8, "8L beaker is full");

        uint256 pourAmount = min(beaker7 - 1, 8 - beaker8);
        beaker7 -= (pourAmount + 1);
        beaker8 += pourAmount;
    }

    function pour8to10() public {
        require(beaker8 > 0, "8L beaker is empty");
        require(beaker10 < 10, "10L beaker is full");

        uint256 pourAmount = min(beaker8 - 1, 10 - beaker10);
        beaker8 -= (pourAmount + 1);
        beaker10 += pourAmount;
    }

    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }

    function solve() external {
        if (beaker10 == 10)
            solved = true;
    }
}
