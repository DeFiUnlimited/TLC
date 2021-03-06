// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PreSale is Ownable {

    uint public bnbPerToken;
    address public tokenAddress;

    constructor(
        uint _bnbPerToken,
        address _tokenAddress
    ) {
        bnbPerToken = _bnbPerToken;
        tokenAddress = _tokenAddress;
    }

    receive() external payable {
        uint tokenAmount = (msg.value * 1e18) / bnbPerToken;
        IERC20(tokenAddress).transfer(msg.sender, tokenAmount);
    }

    function setBnbPerToken(uint _bnbPerToken) external onlyOwner {
        bnbPerToken = _bnbPerToken;
    }

    function sendBNB() external onlyOwner {
        Address.sendValue(payable(owner()), address(this).balance);
    }

    function sendToken(uint amount) external onlyOwner {
        IERC20(tokenAddress).transfer(owner(), amount);
    }

}