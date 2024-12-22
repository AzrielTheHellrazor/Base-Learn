// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract UnburnableToken {
    mapping(address => uint) public balances;
    uint public totalSupply;
    uint public totalClaimed;
    mapping(address => bool) private isClaimed;

    error TokensClaimed();
    error AllTokensClaimed();
    error UnsafeTransfer(address to);

    constructor() {
        totalSupply = 100_000_000;
    }

    function claim() public {
        if (totalClaimed >= totalSupply) {
            revert AllTokensClaimed();
        }
        if (isClaimed[msg.sender]) {
            revert TokensClaimed();
        }

        balances[msg.sender] += 1000;
        totalClaimed += 1000;
        isClaimed[msg.sender] = true;
    }

    function safeTransfer(address _to, uint _amount) public {
        if (address(_to).balance == 0) {
            revert UnsafeTransfer(_to);
        }
        if (_to == address(0)) {
            revert UnsafeTransfer(_to);
        }
        if (balances[msg.sender] < _amount) {
            revert UnsafeTransfer(_to);
        }
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}
