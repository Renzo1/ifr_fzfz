
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Setup} from "./Setup.sol";

abstract contract BeforeAfter is Setup {

    // struct Vars {
    //     uint256 infraredVault_MAX_NUM_REWARD_TOKENS;

    //     uint256 infraredVault_balanceOf;

    //     uint256 infraredVault_earned;

    //     address[] infraredVault_getAllRewardTokens;

    //     tuple[] infraredVault_getAllRewardsForUser;

    //     uint256 infraredVault_getRewardForDuration;

    //     address infraredVault_infrared;

    //     uint256 infraredVault_lastTimeRewardApplicable;

    //     bool infraredVault_paused;

    //     uint256 infraredVault_rewardPerToken;

    //     address infraredVault_rewardTokens;

    //     uint256 infraredVault_rewards;

    //     address infraredVault_rewardsVault;

    //     address infraredVault_stakingToken;

    //     uint256 infraredVault_totalSupply;

    //     uint256 infraredVault_userRewardPerTokenPaid;

    // }

    // Vars internal _before;
    // Vars internal _after;

    // function __before() internal {
    //     _before.infraredVault_MAX_NUM_REWARD_TOKENS = infraredVault.MAX_NUM_REWARD_TOKENS();
    //     _before.infraredVault_balanceOf = infraredVault.balanceOf();
    //     _before.infraredVault_earned = infraredVault.earned();
    //     _before.infraredVault_getAllRewardTokens = infraredVault.getAllRewardTokens();
    //     _before.infraredVault_getAllRewardsForUser = infraredVault.getAllRewardsForUser();
    //     _before.infraredVault_getRewardForDuration = infraredVault.getRewardForDuration();
    //     _before.infraredVault_infrared = infraredVault.infrared();
    //     _before.infraredVault_lastTimeRewardApplicable = infraredVault.lastTimeRewardApplicable();
    //     _before.infraredVault_paused = infraredVault.paused();
    //     _before.infraredVault_rewardPerToken = infraredVault.rewardPerToken();
    //     _before.infraredVault_rewardTokens = infraredVault.rewardTokens();
    //     _before.infraredVault_rewards = infraredVault.rewards();
    //     _before.infraredVault_rewardsVault = infraredVault.rewardsVault();
    //     _before.infraredVault_stakingToken = infraredVault.stakingToken();
    //     _before.infraredVault_totalSupply = infraredVault.totalSupply();
    //     _before.infraredVault_userRewardPerTokenPaid = infraredVault.userRewardPerTokenPaid();
    // }

    // function __after() internal {
    //     _after.infraredVault_MAX_NUM_REWARD_TOKENS = infraredVault.MAX_NUM_REWARD_TOKENS();
    //     _after.infraredVault_balanceOf = infraredVault.balanceOf();
    //     _after.infraredVault_earned = infraredVault.earned();
    //     _after.infraredVault_getAllRewardTokens = infraredVault.getAllRewardTokens();
    //     _after.infraredVault_getAllRewardsForUser = infraredVault.getAllRewardsForUser();
    //     _after.infraredVault_getRewardForDuration = infraredVault.getRewardForDuration();
    //     _after.infraredVault_infrared = infraredVault.infrared();
    //     _after.infraredVault_lastTimeRewardApplicable = infraredVault.lastTimeRewardApplicable();
    //     _after.infraredVault_paused = infraredVault.paused();
    //     _after.infraredVault_rewardPerToken = infraredVault.rewardPerToken();
    //     _after.infraredVault_rewardTokens = infraredVault.rewardTokens();
    //     _after.infraredVault_rewards = infraredVault.rewards();
    //     _after.infraredVault_rewardsVault = infraredVault.rewardsVault();
    //     _after.infraredVault_stakingToken = infraredVault.stakingToken();
    //     _after.infraredVault_totalSupply = infraredVault.totalSupply();
    //     _after.infraredVault_userRewardPerTokenPaid = infraredVault.userRewardPerTokenPaid();
    // }
}
