// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GarageManager {
    struct Car{
        string make;
        string model;
        string color;
        uint numberOfDoors;
    }
    
    error BadCarIndex(uint index);

    mapping(address => Car[]) public garage;

    function addCar(string memory _make, string memory _model, string memory _color, uint _numberOfDoors) public {
        garage[msg.sender].push(Car(_make, _model, _color, _numberOfDoors));
    }

    function getMyCars() public view returns (Car[] memory) {
        return garage[msg.sender];
    }

    function getUserCars(address _user) public view returns (Car[] memory) {
        return garage[_user];
    }

    function updateCar(uint index, string memory _make, string memory _model, string memory _color, uint _numberOfDoors) public {
        if (index >= garage[msg.sender].length) {
            revert BadCarIndex(index);
        }

        garage[msg.sender][index] = Car(_make, _model, _color, _numberOfDoors);
    }

    function resetMyGarage() public {
        delete garage[msg.sender];
    }
}