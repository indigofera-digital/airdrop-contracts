// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/QuizFactory.sol";
import "../src/ERC20TestToken.sol";

contract QuizTest is Test {
    QuizFactory factory;
    IERC20 token;

    function setUp() public {
        factory = new QuizFactory();
        token = new ERC20TestToken();
    }

    function testCreateQuiz() public {
        
        string memory _id = "Quiz Test";
        factory.createQuiz(_id);

        address quiz = factory.quizzes(_id);

        assertEq(token.balanceOf(quiz), 0);
        assertEq(factory.owner(), address(this));

        try factory.createQuiz(_id) {
            assertTrue(false);
        } catch {
            assertTrue(true);
        }
        
    }

    function triggerReward() public {
        string memory _id = "Quiz Test";
        factory.createQuiz(_id);

        address quiz = factory.quizzes(_id);

        assertEq(token.balanceOf(quiz), 0);
        factory.sendQuizReward(_id, token, address(this), 10);

        assertEq(token.balanceOf(address(this)), 0);

        token.transfer(quiz, 100);
        assertEq(token.balanceOf(address(this)), 100);
    }

}
