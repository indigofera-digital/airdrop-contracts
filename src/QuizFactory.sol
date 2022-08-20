//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./Quiz.sol";


contract QuizFactory is Ownable {
    
    mapping(string => Quiz) public quizzes;

    function getQuiz(string memory _id) public view returns (Quiz) {
        return quizzes[_id];
    }

    function createQuizContract(string memory _id) public onlyOwner {
        Quiz newQuiz = new Quiz(_id);            
        quizzes[_id] = newQuiz;
    }

    function quizTriggerReward(string memory _id, IERC20 _token, address _receiver, uint256 _amount) public onlyOwner {
        Quiz quiz = quizzes[_id];
        quiz.sendReward(_token, _receiver, _amount);
    }

    function quizGetBalance(string memory _id, IERC20 _token) public view returns (uint256) {
        Quiz quiz = quizzes[_id];
        return quiz.getBalance(_token);
    }
}