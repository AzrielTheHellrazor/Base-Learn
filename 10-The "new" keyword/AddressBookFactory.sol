// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./10-The new keyword.sol";

contract AddressBookFactory{

    function deploy() public returns (address) {
        AddressBook addressBook = new AddressBook();
        addressBook.transferOwnership(msg.sender);
        return address(this);
    }
}