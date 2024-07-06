// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract WONa is ERC20, Ownable {
    constructor() ERC20("WONA", "WONA") Ownable(msg.sender) {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}

contract WONb is ERC20, Ownable {
    constructor() ERC20("WONB", "WONB") Ownable(msg.sender) {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}

contract ExchangeBank is Ownable, ReentrancyGuard {
    WONa public token1;
    WONb public token2;
    bool public solved;
    mapping(address => bool) public hasClaimedReward;

    constructor() Ownable(msg.sender) {
        token1 = new WONa();
        token2 = new WONb();
        token1.mint(address(this), 10000 ether);
        token2.mint(address(this), 10000 ether);
    }

    function claimInitialReward() external nonReentrant {
        require(!hasClaimedReward[tx.origin], "Reward already claimed");
        require(token1.balanceOf(address(this)) >= 10 ether, "Not enough tokens for reward");    
        hasClaimedReward[tx.origin] = true;
        require(token1.transfer(msg.sender, 10 ether), "Reward transfer failed");
    }

    function getPrice() public view returns (uint256) {
        uint256 token1Amount = token1.balanceOf(address(this));
        uint256 token2Amount = token2.balanceOf(address(this));
        require(token1Amount > 0 && token2Amount > 0, "Insufficient liquidity");
        return (token2Amount * 1 ether) / token1Amount;
    }

    function flashLoan(uint256 amount, bytes calldata data) public nonReentrant {
        uint256 balanceBefore = token1.balanceOf(address(this));
        require(balanceBefore >= amount, "Not enough tokens in pool");
        token1.transfer(msg.sender, amount);
        (bool success, ) = msg.sender.call(data);
        require(success, "Callback failed");
        uint256 balanceAfter = token1.balanceOf(address(this));
        require(balanceAfter >= balanceBefore, "Flash loan not repaid");
    }

    function swap(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");    
        require(token1.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        uint256 price = getPrice();
        require(price > 0, "Price cannot be zero");
        uint256 swapAmount = (amount * price) / 1 ether;
        require(token2.transfer(msg.sender, swapAmount), "Payout transfer failed");
    }

    function solve() external {
        require(token2.balanceOf(msg.sender) >= 20 ether, "Need more token to solve");
        solved = true;
    }
}