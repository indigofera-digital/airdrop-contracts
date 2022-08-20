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
        factory.createQuizContract(_id);

        Quiz quiz = factory.getQuiz(_id);
        // Quiz quiz = factory.quizzes()["test"];
        emit log_address(address(quiz));
        emit log_address(address(factory));
        emit log_address(quiz.owner());
        assertEq(quiz.owner(), address(factory));
        assertEq(factory.owner(), address(this));

        assertEq(_id, quiz.id());

        // quiz.setid("New id");
        emit log(quiz.id());
    }

    function triggerReward() public {
        string memory _id = "Quiz Test";
        factory.createQuizContract(_id);
        Quiz quiz = factory.getQuiz(_id);

        assertEq(token.balanceOf(address(quiz)), 0);
        factory.quizTriggerReward(_id, token, address(this), 10);

        assertEq(token.balanceOf(address(this)), 0);


        token.transfer(address(quiz), 100);
        assertEq(token.balanceOf(address(this)), 100);
    }

}
