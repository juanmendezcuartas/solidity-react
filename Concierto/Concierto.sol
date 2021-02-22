// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.8.0;


contract Concierto {
    
    struct Person {
        string name;
        uint age;
        bool active;
    }
    
    uint fee;
    uint loss= 80; // si la persona pide de vuelta el dinero de la boleta entonces se le devuelve solo el 80%
    
    mapping(address=>Person) public attendantsPersons;
    
    
    function register(string memory _name, uint _age) public payable {
        if(msg.value == fee){
            attendantsPersons[msg.sender] =  Person({
                name: _name,
                age: _age,
                active: true
                });
        }
        else {
            revert();
        }
    }
    
    function setRegistrationFree(uint _fee) public{
        fee = _fee;
    }
    
    function cancelRegistration() public{
        attendantsPersons[msg.sender].active = false;
        msg.sender.transfer((fee*loss)/100);
    }
}