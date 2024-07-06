// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract GoldToken is Ownable {
    using Address for address;
    using Address for address payable;

    string public constant name = "Gold Token";
    string public constant symbol = "GOLD";
    uint8 public constant decimals = 18;

    event Approval(address indexed src, address indexed dst, uint256 amt);
    event Transfer(address indexed src, address indexed dst, uint256 amt);
    event Deposit(address indexed dst, uint256 amt);
    event Withdrawal(address indexed src, uint256 amt);

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor() Ownable(msg.sender) {}

    receive() external payable {
        revert("GOLD: Do not send ETH directly");
    }

    function deposit(address _userAddress) public payable onlyOwner {
        _mint(_userAddress, msg.value);
        emit Deposit(_userAddress, msg.value);
    }

    function withdraw(address _userAddress, uint256 _amount) public onlyOwner {
        payable(_userAddress).sendValue(_amount);
        _burn(_userAddress, _amount);
        emit Withdrawal(_userAddress, _amount);
    }

    function withdrawAll(address _userAddress) public onlyOwner {
        uint256 amount = balanceOf[_userAddress];
        payable(_userAddress).sendValue(amount);
        _burnAll(_userAddress);
        emit Withdrawal(_userAddress, amount);
    }

    function totalSupply() public view returns (uint256) {
        return address(this).balance;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transfer(address dst, uint256 amount) public returns (bool) {
        return transferFrom(msg.sender, dst, amount);
    }

    function transferFrom(address src, address dst, uint256 amount) public returns (bool) {
        require(balanceOf[src] >= amount, "Insufficient balance");
        if (src != msg.sender && allowance[src][msg.sender] != type(uint256).max) {
            require(allowance[src][msg.sender] >= amount, "Insufficient allowance");
            allowance[src][msg.sender] -= amount;
        }
        balanceOf[src] -= amount;
        balanceOf[dst] += amount;
        emit Transfer(src, dst, amount);
        return true;
    }

    function _mint(address dst, uint256 amount) internal {
        balanceOf[dst] += amount;
    }

    function _burn(address src, uint256 amount) internal {
        require(balanceOf[src] >= amount, "Insufficient balance");
        balanceOf[src] -= amount;
    }

    function _burnAll(address _userAddress) internal {
        _burn(_userAddress, balanceOf[_userAddress]);
    }
}

contract SecureVault is ReentrancyGuard {
    GoldToken public immutable goldToken;
    bool public solved;

    constructor() payable {
        goldToken = new GoldToken();
        goldToken.deposit{value: msg.value}(address(this));
    }

    function deposit() public payable nonReentrant {
        goldToken.deposit{value: msg.value}(msg.sender);
    }

    function withdraw(uint256 amount) public nonReentrant {
        goldToken.withdraw(msg.sender, amount);
    }

    function withdrawAll() public nonReentrant {
        goldToken.withdrawAll(msg.sender);
    }

    function solve() external {
        require(msg.sender.balance >= 50 ether);
        solved = true;
    }

    receive() external payable {}
}