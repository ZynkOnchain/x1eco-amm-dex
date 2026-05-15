// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract USDZ is ERC20, Ownable {

    uint256 public constant MAX_SUPPLY =
        1000000000 * 10**18;

    constructor()
        ERC20("USD Zynk", "USDZ")
        Ownable(msg.sender)
    {
        _mint(
            msg.sender,
            MAX_SUPPLY
        );
    }

    function burn(uint256 amount)
        external
    {
        _burn(
            msg.sender,
            amount
        );
    }
}
