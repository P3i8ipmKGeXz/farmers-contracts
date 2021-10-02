// SPDX-License-Identifier: MIT
// CONTRACT ORIGINALLY MADE BY RUGDOC

pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract FarmersOnlyLiqLocker {
    address public FarmersOnlyDev = 0xeE68753bD98d29D20C8768b05f90c95D66AEf1a8;
    uint256 public unlockTimestamp;
    
    constructor() {
        unlockTimestamp = block.timestamp + 60 * 60 * 24 * 365; // 1 year lock
    }
    
    function withdraw(IERC20 token) external {
        require(msg.sender == FarmersOnlyDev, "withdraw: message sender is not FarmersOnlyDev");
        require(block.timestamp > unlockTimestamp, "withdraw: the token is still locked");
        token.transfer(msg.sender, token.balanceOf(address(this)));
    }
    
}