// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {

    function transfer(
        address to,
        uint256 amount
    ) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    function balanceOf(
        address account
    ) external view returns (uint256);
}

contract MiniSwapDEXV1 {

    IERC20 public ecoToken;

    IERC20 public usdzToken;

    uint256 public ecoReserve;

    uint256 public usdzReserve;

    constructor(
        address ecoAddress,
        address usdzAddress
    ) {

        ecoToken = IERC20(ecoAddress);

        usdzToken = IERC20(usdzAddress);
    }

    function addLiquidity(
        uint256 ecoAmount,
        uint256 usdzAmount
    ) external {

        require(
            ecoAmount > 0 &&
            usdzAmount > 0,
            "Invalid amounts"
        );

        ecoToken.transferFrom(
            msg.sender,
            address(this),
            ecoAmount
        );

        usdzToken.transferFrom(
            msg.sender,
            address(this),
            usdzAmount
        );

        ecoReserve += ecoAmount;

        usdzReserve += usdzAmount;
    }

    function removeLiquidity(
        uint256 ecoAmount,
        uint256 usdzAmount
    ) external {

        require(
            ecoAmount <= ecoReserve,
            "Not enough ECO reserve"
        );

        require(
            usdzAmount <= usdzReserve,
            "Not enough USDZ reserve"
        );

        ecoReserve -= ecoAmount;

        usdzReserve -= usdzAmount;

        ecoToken.transfer(
            msg.sender,
            ecoAmount
        );

        usdzToken.transfer(
            msg.sender,
            usdzAmount
        );
    }

    function swapEcoForUSDZ(
        uint256 ecoInput
    ) external {

        require(
            ecoInput > 0,
            "Invalid input"
        );

        uint256 usdzOutput =
            (ecoInput * usdzReserve)
            /
            (ecoReserve + ecoInput);

        require(
            usdzOutput <= usdzReserve,
            "Insufficient liquidity"
        );

        ecoToken.transferFrom(
            msg.sender,
            address(this),
            ecoInput
        );

        usdzToken.transfer(
            msg.sender,
            usdzOutput
        );

        ecoReserve += ecoInput;

        usdzReserve -= usdzOutput;
    }

    function swapUSDZForEco(
        uint256 usdzInput
    ) external {

        require(
            usdzInput > 0,
            "Invalid input"
        );

        uint256 ecoOutput =
            (usdzInput * ecoReserve)
            /
            (usdzReserve + usdzInput);

        require(
            ecoOutput <= ecoReserve,
            "Insufficient liquidity"
        );

        usdzToken.transferFrom(
            msg.sender,
            address(this),
            usdzInput
        );

        ecoToken.transfer(
            msg.sender,
            ecoOutput
        );

        usdzReserve += usdzInput;

        ecoReserve -= ecoOutput;
    }

    function getReserves()
        external
        view
        returns (
            uint256 eco,
            uint256 usdz
        )
    {

        return (
            ecoReserve,
            usdzReserve
        );
    }

    function getPrice()
        external
        view
        returns (uint256)
    {

        require(
            ecoReserve > 0,
            "No liquidity"
        );

        return
            (usdzReserve * 1e18)
            /
            ecoReserve;
    }
}
