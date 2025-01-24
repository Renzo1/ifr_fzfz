
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseSetup} from "@chimera/BaseSetup.sol";

import {MockERC20} from "./mocks/MockERC20.sol";
import {Infrared} from "./mocks/Infrared.sol";
import {RewardsVault} from "./mocks/RewardsVault.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

import "../../src/core/InfraredVault.sol";
import "../../src/core/MultiRewards.sol";

import {IRewardVault as IBerachainRewardsVault} from
    "@berachain/pol/interfaces/IRewardVault.sol";

interface IHevm {
  // Set block.timestamp to newTimestamp
  function warp(uint256 newTimestamp) external;

  // Sets block.number
  function roll(uint256 newNumber) external;

  // Sets the eth balance of usr to amt
  function deal(address usr, uint256 amt) external;

  // Gets address for a given private key
  function addr(uint256 privateKey) external returns (address addr);

  // Performs the next smart contract call with specified `msg.sender`
  function prank(address newSender) external;

}


abstract contract Setup is BaseSetup {
  using Math for uint256;

  IHevm hevm = IHevm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));

  /*//////////////////////////////////////////////////////////////////////////
                                    VARIABLES
  //////////////////////////////////////////////////////////////////////////*/

    IInfraredVault infraredVault;
    IBerachainRewardsVault rewardsVault;
    Infrared infrared;

    uint256 internal constant INITIAL_BALANCE = 1_000_000;

    ///////////////////// TOKENS ////////////////////
    MockERC20 stakingToken;

    address[] rewardTokens;
    MockERC20 rewardToken1;
    MockERC20 rewardToken2;
    MockERC20 rewardToken3;


    address[] USERS;
    address internal constant BOB = 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf;
    address internal constant ALICE = 0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF;
    address internal constant JAKE = 0x6813Eb9362372EEF6200f3b1dbC3f819671cBA69;
  

    function setup() internal virtual override {
      uint256 rewardsDuration = 7 days;
      stakingToken = new MockERC20("ST", "ST", 18);
      
      // reward tokens
      rewardToken1 = new MockERC20("RWT1", "RWT1", 18);
      rewardToken2 = new MockERC20("RWT2", "RWT2", 18);
      rewardToken3 = new MockERC20("RWT3", "RWT2", 18);

      RewardsVault rewardsVaultAddr = new RewardsVault(address(stakingToken));
      rewardsVault = IBerachainRewardsVault(address(rewardsVaultAddr));

      InfraredVault infraredVaultContract = new InfraredVault(address(stakingToken), rewardsDuration);
      infraredVaultContract.setRewardsVault(rewardsVault);
      infraredVault = IInfraredVault(address(infraredVaultContract));


      infrared = new Infrared(infraredVault);
      infraredVaultContract.setInfrared(address(infrared));

      infraredVault.addReward(address(rewardToken1), 7 days);
      infraredVault.addReward(address(rewardToken2), 6 days);
      infraredVault.addReward(address(rewardToken3), 5 days);

      rewardTokens = new address[](3);
      rewardTokens[0] = address(rewardToken1);
      rewardTokens[1] = address(rewardToken2);
      rewardTokens[2] = address(rewardToken3);

      setupActors();
    }


  function setupActors() internal {
    USERS = new address[](3);
    USERS[0] = BOB;
    USERS[1] = ALICE;
    USERS[2] = JAKE;

    _topUpUsers();

    // set approval for all tokens
    for (uint256 i = 0; i < USERS.length; i++) {
      hevm.prank(USERS[i]);
      stakingToken.approve(address(infraredVault), type(uint256).max);
      hevm.prank(USERS[i]);
      stakingToken.approve(address(infrared), type(uint256).max);
      hevm.prank(USERS[i]);
      rewardToken1.approve(address(infraredVault), type(uint256).max);
      hevm.prank(USERS[i]);
      rewardToken1.approve(address(infrared), type(uint256).max);
      hevm.prank(USERS[i]);
      rewardToken2.approve(address(infraredVault), type(uint256).max);
      hevm.prank(USERS[i]);
      rewardToken2.approve(address(infrared), type(uint256).max);
      hevm.prank(USERS[i]);
      rewardToken3.approve(address(infraredVault), type(uint256).max);
      hevm.prank(USERS[i]);
      rewardToken3.approve(address(infrared), type(uint256).max);
    }
  }

  function _topUpUsers() internal {
    address user;
    for (uint256 i = 0; i < USERS.length; i++) {
      user = USERS[i];

      MockERC20(rewardTokens[0]).mint(user, INITIAL_BALANCE * (10 ** MockERC20(rewardTokens[0]).decimals())); 
      MockERC20(rewardTokens[1]).mint(user, INITIAL_BALANCE * (10 ** MockERC20(rewardTokens[1]).decimals())); 
      MockERC20(rewardTokens[2]).mint(user, INITIAL_BALANCE * (10 ** MockERC20(rewardTokens[2]).decimals()));
      stakingToken.mint(user, INITIAL_BALANCE * (10 ** stakingToken.decimals()));
    }
  }


}
