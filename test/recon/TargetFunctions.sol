
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {Properties} from "./Properties.sol";
import {vm} from "@chimera/Hevm.sol";
import { Debugger } from "./utils/Debugger.sol";
import { EchidnaUtils } from "./utils/EchidnaUtils.sol";
import { ERC20, IERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {MockERC20} from "./mocks/MockERC20.sol";
import {Errors} from "src/utils/Errors.sol";

abstract contract TargetFunctions is BaseTargetFunctions, Properties {
    using Strings for string;


    /*//////////////////////////////////////////////////////////////////////////
                            AUXILIARY FUNCTIONS AND MODIFIERS
    //////////////////////////////////////////////////////////////////////////*/

    // function getAllowedErrors() public pure returns (bytes4[] memory) {

    //   bytes4[] memory allowedErrors = new bytes4[](13);

    //   allowedErrors[0] = Errors.ZeroAddress.selector;
    //   allowedErrors[1] = Errors.ZeroAmount.selector;
    //   allowedErrors[2] = Errors.UnderFlow.selector;
    //   allowedErrors[3] = Errors.InvalidArrayLength.selector;
    //   allowedErrors[4] = Errors.AlreadySet.selector;
    //   allowedErrors[5] = Errors.MaxNumberOfRewards.selector;
    //   allowedErrors[6] = Errors.Unauthorized.selector;
    //   allowedErrors[7] = Errors.IBGTNotRewardToken.selector;
    //   allowedErrors[8] = Errors.IREDNotRewardToken.selector;
    //   allowedErrors[9] = Errors.StakedInRewardsVault.selector;
    //   allowedErrors[10] = Errors.NoRewardsVault.selector;
    //   allowedErrors[11] = Errors.RegistrationPaused.selector;
    //   allowedErrors[12] = Errors.RewardTokenNotWhitelisted.selector;


    //   return allowedErrors;
    // }

  ///////// DoS Catcher /////////
  // event UnexpectedCustomError(bytes);
  // function _assertCustomErrorsAllowed(bytes memory err, bytes4[] memory allowedErrors) private {
  //     bool allowed;
  //     bytes4 errorSelector = bytes4(err);
  //     uint256 allowedErrorsLength = allowedErrors.length;

  //     for (uint256 i; i < allowedErrorsLength;) {
  //         if (errorSelector == allowedErrors[i]) {
  //             allowed = true;
  //             break;
  //         }
  //         unchecked {++i;}
  //     }

  //     if(!allowed) {
  //         emit UnexpectedCustomError(err);
  //         assert(false);
  //     }
  // }

  event UnexpectedTextError(string);
  function _assertTextErrorsAllowed(string memory err, string[] memory allowedErrors) private {
      bool allowed;
      uint256 allowedErrorsLength = allowedErrors.length;

      for (uint256 i; i < allowedErrorsLength;) {
          if (err.equal(allowedErrors[i])) {
              allowed = true;
              break;
          }
          unchecked {++i;}
      }

      if(!allowed) {
          emit UnexpectedTextError(err);
          assert(false);
      }
  }

  ///////// Top Up User Balance /////////


  function topupUsers(uint256 _num) public {
    if (_num % 17 == 0) {
      _topUpUsers();
    }
  }



  /*//////////////////////////////////////////////////////////////////////////
                          HANDLER FUNCTIONS AND MODIFIERS
  //////////////////////////////////////////////////////////////////////////*/

  function infraredVault_exit() public {
      hevm.prank(msg.sender);
      try infraredVault.exit() {

      } catch Error(string memory err) {
        string[] memory allowedErrors = new string[](0);
        // allowedErrors[0] = "First error";

        _assertTextErrorsAllowed(err, allowedErrors);
      }
  }


  function infraredVault_getReward() public {
      hevm.prank(msg.sender);
      try infraredVault.getReward() {

      } catch Error(string memory err) {
        string[] memory allowedErrors = new string[](0);
        // allowedErrors[0] = "First error";

        _assertTextErrorsAllowed(err, allowedErrors);
      }
  }


  function infraredVault_getRewardForUser(uint256 _userId) public {
      address _user = USERS[EchidnaUtils.clampBetween(_userId, 0, USERS.length - 1)];

      hevm.prank(msg.sender);
      try infraredVault.getRewardForUser(_user) {

      } catch Error(string memory err) {
        string[] memory allowedErrors = new string[](0);
        // allowedErrors[0] = "First error";

        _assertTextErrorsAllowed(err, allowedErrors);
      }
  }



  function infraredVault_stake(uint256 amount) public {
      amount = EchidnaUtils.clampBetween(amount, 0, stakingToken.balanceOf(msg.sender));

      hevm.prank(msg.sender);
      try infraredVault.stake(amount) {

      }catch Error(string memory err) {
        string[] memory allowedErrors = new string[](2);
        allowedErrors[0] = "Cannot stake 0";
        allowedErrors[1] = "TRANSFER_FROM_FAILED";

        _assertTextErrorsAllowed(err, allowedErrors);
      }
  }


  function infraredVault_withdraw(uint256 amount) public {
      amount = EchidnaUtils.clampBetween(amount, 0, stakingToken.balanceOf(msg.sender));

      hevm.prank(msg.sender);
      try infraredVault.withdraw(amount) {

      } catch Error(string memory err) {
        string[] memory allowedErrors = new string[](2);
        allowedErrors[0] = "Cannot withdraw 0";
        allowedErrors[1] = "TRANSFER_FAILED";

        _assertTextErrorsAllowed(err, allowedErrors);
      }
  }


  function infrared_addIncentives(uint256 amount, uint256 tokenId) public {
      amount = EchidnaUtils.clampBetween(amount, 0, stakingToken.balanceOf(msg.sender));
      address token = rewardTokens[EchidnaUtils.clampBetween(
        tokenId, 0, rewardTokens.length - 1)];

      hevm.prank(msg.sender);
      try infrared.addIncentives(token, amount) {

      } catch Error(string memory err) {
        string[] memory allowedErrors = new string[](4);
        allowedErrors[0] = "Cannot add 0";
        allowedErrors[1] = "insufficient-balance";
        allowedErrors[2] = "Cannot be zero address";
        allowedErrors[3] = "Cannot be zero amount";

        _assertTextErrorsAllowed(err, allowedErrors);
      }
  }
}
