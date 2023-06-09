// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    constructor() ERC20("Degen", "DGN") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }

    function getBalance() external view returns (uint256) {
        return this.balanceOf(msg.sender);
    }

    function transferTokens(address _receiver, uint256 _value) external {
        require(
            balanceOf(msg.sender) >= _value,
            "You do not have enough Degen Tokens"
        );
        approve(msg.sender, _value);
        transferFrom(msg.sender, _receiver, _value);
    }

    function burnTokens(uint256 _value) external {
        require(
            balanceOf(msg.sender) >= _value,
            "You do not have enough Degen Tokens"
        );
        burn(_value);
    }

    function showStoreItems() external view returns (string memory) {
        console.log("The following items are available for purchase:");
        console.log("Selection 1: Butterfly Knife");
        console.log("Selection 2: Karambit Knife");
        console.log("Selection 3: Huntsman Knife");
        return
            "The following items are available for purchase:\nSelection 1. Butterfly Knife\nSelection 2. Karambit Knife\nSelection 3. Huntsman Knife";
    }

    function redeemTokens(uint8 _userChoice) external payable returns (bool) {
        if (_userChoice == 1) {
            require(
                this.balanceOf(msg.sender) >= 100,
                "You do not have enough Degen Tokens"
            );
            approve(msg.sender, 100);
            transferFrom(msg.sender, owner(), 100);
            console.log("You have redeemed for a Butterfly Knife!");
            return true;
        } else if (_userChoice == 2) {
            require(
                this.balanceOf(msg.sender) >= 75,
                "You do not have enough Degen Tokens"
            );
            approve(msg.sender, 75);
            transferFrom(msg.sender, owner(), 75);
            console.log("You have redeemed for a Karambit Knife!");
            return true;
        } else if (_userChoice == 3) {
            require(
                this.balanceOf(msg.sender) >= 50,
                "You do not have enough Degen Tokens"
            );
            approve(msg.sender, 50);
            transferFrom(msg.sender, owner(), 50);
            console.log("You have redeemed for a Huntsman Knife!");
            return true;
        } else {
            console.log("That is not a valid choice");
            return false;
        }
    }
}
