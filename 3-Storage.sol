// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmployeeStorage {
    error TooManyShares(uint totalShares);

    uint16 private shares; 
    uint32 private salary; 
    uint256 public idNumber;
    string public name;

    constructor(
        uint16 _shares,
        uint32 _salary,
        uint256 _idNumber,
        string memory _name
    ) {
        require(_shares <= 5000, "Too many shares");
        require(_salary <= 1_000_000, "Salary exceeds limit");

        shares = _shares;
        salary = _salary;
        idNumber = _idNumber;
        name = _name;
    }

    function viewSalary() public view returns (uint32) {
        return salary;
    }

    function viewShares() public view returns (uint16) {
        return shares;
    }

    function grantShares(uint16 _newShares) public {
        uint16 newTotalShares = shares + _newShares;

        if (_newShares > 5000) {
            revert("Too many shares");
        } else if (newTotalShares > 5000) {
            revert TooManyShares(newTotalShares);
        }

        shares = newTotalShares;
    }

    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload(_slot)
        }
    }

    function debugResetShares() public {
        shares = 1000;
    }
}
