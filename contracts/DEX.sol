// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

import "./BCD.sol";

contract DEX {
    
    IERC20 public token;

    event Bought(uint amount);
    event Sold(uint amount);

    constructor() public {
        token = new BCD();
    }

    function buy() payable public {
        uint buyAmount = msg.value;
        uint dexBalance = token.balanceOf(address(this));

        require(buyAmount > 0, "Number of ether must be > 0");
        require(buyAmount <= dexBalance, "Not enough tokens in the reserve");

        token.transfer(msg.sender, buyAmount);
        emit Bought(buyAmount);
    }

    function sell(uint amount) public {
        require(amount > 0, "Number of token must be > 0");
        uint256 allowance = token.allowance(msg.sender, address(this));
        require(allowance >= amount, "Check the token allowance");
        token.transferFrom(msg.sender, address(this), amount);
        msg.sender.transfer(amount);
        emit Sold(amount);
    }

    function balanceOf(address account) view public {
        token.balanceOf(account);
    }
}