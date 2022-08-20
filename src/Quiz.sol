//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract Quiz is Ownable {

    string public id;

    event TransferReceived(address _from, uint _amount);
    event TransferSent(address _from, address _destAddr, uint _amount);

    constructor(string memory _id) {
        id = _id;
    }

    receive() external payable {
        emit TransferReceived(msg.sender, msg.value);
    }

    fallback() external payable {}

    function sendReward(IERC20 _token, address _receiver, uint256 _amount) public onlyOwner {
        uint256 erc20balance = _token.balanceOf(address(this));
        require(_amount <= erc20balance, "No enough funds to send reward!");
        require(_token.transfer(_receiver, _amount));
        emit TransferSent(msg.sender, _receiver, _amount);
    }

    function getBalance(IERC20 _token) public view returns (uint256) {
        return _token.balanceOf(address(this));
    }

}