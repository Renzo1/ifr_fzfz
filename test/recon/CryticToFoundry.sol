// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {TargetFunctions} from "./TargetFunctions.sol";
import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";
import "forge-std/console2.sol";
import {MockERC20} from "./mocks/MockERC20.sol";

contract CryticToFoundry is Test, TargetFunctions, FoundryAsserts {
    address internal user;
    address internal user2 = 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf;

    function setUp() public {
        setup();

        user = msg.sender;

        MockERC20(rewardTokens[0]).mint(user, INITIAL_BALANCE * (10 ** MockERC20(rewardTokens[0]).decimals())); 
        // rewardTokens[0].mint(user2, INITIAL_BALANCE * (10 ** rewardTokens[0].decimals())); 
        MockERC20(rewardTokens[1]).mint(user, INITIAL_BALANCE * (10 ** MockERC20(rewardTokens[1]).decimals())); 
        // rewardTokens[1].mint(user2, INITIAL_BALANCE * (10 ** rewardTokens[1].decimals())); 
        MockERC20(rewardTokens[2]).mint(user, INITIAL_BALANCE * (10 ** MockERC20(rewardTokens[2]).decimals()));
        // rewardTokens[2].mint(user2, INITIAL_BALANCE * (10 ** rewardTokens[2].decimals()));
        stakingToken.mint(user, INITIAL_BALANCE * (10 ** MockERC20(stakingToken).decimals()));
        // stakingToken.mint(user2, INITIAL_BALANCE * (10 ** stakingToken.decimals()));

            hevm.prank(user);
            stakingToken.approve(address(infraredVault), type(uint256).max);
            hevm.prank(user);
            stakingToken.approve(address(infrared), type(uint256).max);

            hevm.prank(user);
            rewardToken1.approve(address(infraredVault), type(uint256).max);
            hevm.prank(user);
            rewardToken1.approve(address(infrared), type(uint256).max);
            hevm.prank(user);
            rewardToken2.approve(address(infraredVault), type(uint256).max);
            hevm.prank(user);
            rewardToken2.approve(address(infrared), type(uint256).max);
            hevm.prank(user);
            rewardToken3.approve(address(infraredVault), type(uint256).max);
            hevm.prank(user);
            rewardToken3.approve(address(infrared), type(uint256).max);
        
    }

    function test_crytic() public {
        // TODO: add failing property tests here for debugging
    }
    
    function testCoverage() public {
        uint256 amount1 = 1000 * (10 ** stakingToken.decimals());
        uint256 rewardAmount = 500 * (10 ** rewardToken1.decimals());
        uint256 tokenId = 100;
        uint256 withdrawAmount1 = 500 * (10 ** stakingToken.decimals());
        uint256 userId = 10;


        // user1 stakes
        infraredVault_stake(amount1);

        // // user2 stakes
        // infraredVault_stake(uint256 amount);

        infrared_addIncentives(rewardAmount, tokenId);

        infraredVault_withdraw(withdrawAmount1);

        infraredVault_getReward();

        infraredVault_exit();

        infraredVault_getRewardForUser(userId);
    }

}
