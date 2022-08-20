// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/ERC20TestToken.sol";
import "../src/QuizFactory.sol";

contract QuizFactoryDeploy is Script {
    function run() external {
        vm.startBroadcast();

        // new ERC20TestToken();

        new QuizFactory();

        vm.stopBroadcast();
    }
}
