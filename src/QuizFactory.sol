//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./Quiz.sol";


interface QuizInterface {
    function sendReward(IERC20 _token, address _receiver, uint256 _amount) external;
    function getBalance(IERC20 _token) external;
}

contract QuizFactory is Ownable {
    
    mapping(string => address) public quizzes;

    function createQuiz(string memory _id) public onlyOwner {
        require(quizzes[_id] == address(0), "Quiz already exists!");
        Quiz newQuiz = new Quiz(_id);            
        quizzes[_id] = address(newQuiz);
    }

    function sendQuizReward(string memory _id, IERC20 _token, address _receiver, uint256 _amount) public onlyOwner {
        address quiz = quizzes[_id];
        QuizInterface quizInterface = QuizInterface(quiz);
        quizInterface.sendReward(_token, _receiver, _amount);
    }

    function getQuizBalance(string memory _id, IERC20 _token) public view returns (uint256) {
        address quiz = quizzes[_id];
        return _token.balanceOf(quiz);
    }
}