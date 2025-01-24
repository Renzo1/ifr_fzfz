// ```js
// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.23;

// import "@openzeppelin/contracts/utils/Strings.sol";

// import "forge-std/Test.sol";

// // run from base project directory with:
// // forge test --match-contract ErrorTest -vvv
// contract ErrorRaiser {
//     error SecondError();
//     error ThirdError();

//     function generateError(uint8 input) external pure {
//         if(input == 0) revert("First error");

//         revert SecondError();
//     }
// }

// contract ErrorTest is Test {
//     using Strings for string;
//     ErrorRaiser errorRaiser;

//     function setUp() public {
//         errorRaiser = new ErrorRaiser();

//         targetContract(address(this));

//         bytes4[] memory selectors = new bytes4[](1);
//         selectors[0] = this.fake_handler.selector;

//         targetSelector(FuzzSelector({addr: address(this), selectors: selectors}));
//     }

//     function invariant_always_true() public pure {
//         assert(true);
//     }

//     function fake_handler(uint8 input) public {
//         try errorRaiser.generateError(input) {}
//         // handle `require` text-based errors
//         catch Error(string memory err) {
//             string[] memory allowedErrors = new string[](1);
//             allowedErrors[0] = "First error";

//             _assertTextErrorsAllowed(err, allowedErrors);
//         }
//         // handle custom errors
//         catch(bytes memory err) {
//             bytes4[] memory allowedErrors = new bytes4[](1);
//             allowedErrors[0] = ErrorRaiser.SecondError.selector;

//             _assertCustomErrorsAllowed(err, allowedErrors);
//         }
        
//     }

//     // used to filter for allowed text errors during functions
//     // if a function fails with an error that is not allowed,
//     // this can indicate a potential DoS attack vector
//     event UnexpectedTextError(string);
//     function _assertTextErrorsAllowed(string memory err, string[] memory allowedErrors) private {
//         bool allowed;
//         uint256 allowedErrorsLength = allowedErrors.length;

//         for (uint256 i; i < allowedErrorsLength;) {
//             if (err.equal(allowedErrors[i])) {
//                 allowed = true;
//                 break;
//             }
//             unchecked {++i;}
//         }

//         if(!allowed) {
//             emit UnexpectedTextError(err);
//             assert(false);
//         }
//     }

//     // used to filter for allowed custom errors during functions
//     // if a function fails with an error that is not allowed,
//     // this can indicate a potential DoS attack vector
//     event UnexpectedCustomError(bytes);
//     function _assertCustomErrorsAllowed(bytes memory err, bytes4[] memory allowedErrors) private {
//         bool allowed;
//         bytes4 errorSelector = bytes4(err);
//         uint256 allowedErrorsLength = allowedErrors.length;

//         for (uint256 i; i < allowedErrorsLength;) {
//             if (errorSelector == allowedErrors[i]) {
//                 allowed = true;
//                 break;
//             }
//             unchecked {++i;}
//         }

//         if(!allowed) {
//             emit UnexpectedCustomError(err);
//             assert(false);
//         }
//     }
// }
// ```

