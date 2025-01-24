// SPDX-License-Identifier: BUSL-1.1

pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {SafeTransferLib} from "@solmate/utils/SafeTransferLib.sol";



contract RewardsVault {
    address token;

    constructor(address _token){
        token = _token;
    }

    function stake(uint256 _amount) external {
        ERC20(token).transferFrom(msg.sender, address(this), _amount);
    }

    function withdraw(uint256 _amount) external {
        ERC20(token).transfer(msg.sender, _amount);
    }
}
