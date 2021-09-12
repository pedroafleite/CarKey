// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

contract CarKey {
    
    enum Statuses { Vacant, Occupied }
    Statuses currentStatus;
    
    event Occupy(address _occupant, uint _value);
    
    address payable public owner;
    
    constructor() public {
        owner = msg.sender;
        currentStatus = Statuses.Vacant;
    }
    
    modifier onlyWhileVacant {
        require(currentStatus == Statuses.Vacant, "Currently occupied");
        _;
    }
    
    modifier costs (uint _amount) {
        require(msg.value >= _amount, "Not enough Ether provided.");
        _;
    }
    
    receive() external payable onlyWhileVacant costs(2 ether) {
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
    }
}
