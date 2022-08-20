// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/Quiz.sol";
import "../src/ERC20TestToken.sol";

contract QuizTest is Test {
    Quiz quiz;
    IERC20 token;

    function setUp() public {
        quiz = new Quiz("Test Quiz");
        token = new ERC20TestToken();
    }

    function testQuiz() public {
        emit log_address(address(quiz));
        emit log_address(address(this));
        emit log_address(address(token));
        emit log(quiz.id());
        assertEq(quiz.owner(), address(this));
    }

    function testQuizFundingAndRewards() public {
        uint balance = token.balanceOf(address(this));
        emit log_uint(balance);

        token.transfer(address(quiz), 10000);
        balance = token.balanceOf(address(this));
        emit log_uint(balance);

        assertEq(token.balanceOf(address(quiz)), 10000);
        
        quiz.sendReward(token, address(this), 500);
        assertEq(token.balanceOf(address(quiz)), 10000 - 500);
        assertEq(token.balanceOf(address(this)), balance + 500);

        emit log_uint(token.balanceOf(address(this)));
        emit log_uint(token.balanceOf(address(quiz)));
    }
}
