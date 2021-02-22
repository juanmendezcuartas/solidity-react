// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.8.0;

contract Billetera {
    
    address payable owner;
    
    event UpdateStatus(string msg);
    event UserStatus(string msg, address user, uint amout);
    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    
    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }
    
    constructor() {
        owner = msg.sender;
        emit OwnerSet(address(0), owner);
    }
    
    function depositFunds(uint _amount) public payable {
        if(owner.send(_amount)){
            emit UserStatus("User has deposited some money", msg.sender, msg.value);    
        }
    }
    
    function withdrawnFunds(uint _amount) public payable isOwner {
        if(owner.send(_amount)){
            UpdateStatus("User withdraw some money");
        }
    }
    
    function getFunds() public view isOwner returns(uint){
        return address(this).balance;
    }
    
    function _kill() private isOwner {
        selfdestruct(owner);
    }
}