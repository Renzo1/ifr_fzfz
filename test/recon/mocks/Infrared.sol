// SPDX-License-Identifier: BUSL-1.1

pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {SafeTransferLib} from "@solmate/utils/SafeTransferLib.sol";
import {IInfraredVault} from "src/interfaces/IInfraredVault.sol";
import {Errors} from "src/utils/Errors.sol";


contract Infrared {
    IInfraredVault vault;

    constructor(IInfraredVault _vault) {
        vault = _vault;
    }


    function addIncentives(
        address _rewardsToken,
        uint256 _amount
    ) external {

        (, uint256 _vaultRewardsDuration,,,,,) = vault.rewardData(_rewardsToken);
        // if (_vaultRewardsDuration == 0) {
        //     revert Errors.RewardTokenNotWhitelisted();
        // }
        require(_vaultRewardsDuration != 0, "Cannot add 0");
        require(ERC20(_rewardsToken).balanceOf(msg.sender) >= _amount, "insufficient-balance");

        ERC20(_rewardsToken).transferFrom(msg.sender, address(this), _amount);
        ERC20(_rewardsToken).approve(address(vault), _amount);

        vault.notifyRewardAmount(_rewardsToken, _amount);
    }


    // function harvestVault(address asset) external returns (uint256 bgtAmt) {

    //     uint256 _amt = 
    //     if (_amt > 0) {
    //         ERC20(ibgt).safeApprove(address(vault), _amt);
    //         vault.notifyRewardAmount(ibgt, _amt);
    //     }
    // }

}
