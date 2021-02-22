// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.8.0;

contract Apuestas {
    address owner;
    uint payPercentaje = 90;
    
    event Status(string _msg, address user, uint amount);
    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    
    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }
    
    constructor() {
        owner = msg.sender;
        emit OwnerSet(address(0), owner);
    }
    
    function flipCoin() public payable {
        if((block.timestamp % 2) == 0){
            if(address(this).balance < ((msg.value*payPercentaje)/100)){
                emit Status("Conratulations, you won! sry we didnt have enought money, we will deposit everithing we have", msg.sender, address(this).balance);
                msg.sender.transfer(address(this).balance);
            } else {
                emit Status("Congratulations, you won!", msg.sender, msg.value * (100 + payPercentaje)/100);
                msg.sender.transfer(msg.value * (100 + payPercentaje)/100);
            }
        } else {
            emit Status("We are sorry, you lose, try again", msg.sender, msg.value);
        }
    }
}