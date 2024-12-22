// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AddressBook is Ownable {
    constructor() Ownable(msg.sender) { }

    struct Contact {
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
    }

    error ContactNotFound(uint id);

    Contact[] private contacts;
    mapping(uint => uint) private idToIndex;
    mapping(uint => bool) private deleted;

    function addContact(
        uint _id,
        string memory _firstName,
        string memory _lastName,
        uint[] memory _phoneNumbers
    ) public onlyOwner {
        require(idToIndex[_id] == 0 && contacts.length == 0 || !deleted[_id], "ID already exists");
        contacts.push(Contact(_id, _firstName, _lastName, _phoneNumbers));
        idToIndex[_id] = contacts.length - 1;
    }

    function deleteContact(uint _id) public onlyOwner {
        uint index = idToIndex[_id];
        if (index >= contacts.length || deleted[_id]) {
            revert ContactNotFound(_id);
        }

        deleted[_id] = true;
    }

    function getContact(uint _id) public view returns (Contact memory) {
        uint index = idToIndex[_id];
        if (index >= contacts.length || deleted[_id]) {
            revert ContactNotFound(_id);
        }
        return contacts[index];
    }

    function getAllContacts() public view returns (Contact[] memory) {
        uint count = 0;

        for (uint i = 0; i < contacts.length; i++) {
            if (!deleted[contacts[i].id]) {
                count++;
            }
        }

        Contact[] memory activeContacts = new Contact[](count);
        uint index = 0;

        for (uint i = 0; i < contacts.length; i++) {
            if (!deleted[contacts[i].id]) {
                activeContacts[index] = contacts[i];
                index++;
            }
        }

        return activeContacts;
    }

    // Bonus Question:
    // Why can't we just use the automatically generated getter for `contacts`?
    // - The automatically generated getter would return the entire array, including deleted entries,
    //   which is inefficient and exposes potentially unnecessary data.
    // - Our implementation allows filtering of non-deleted entries and adds proper error handling.
    // Note: I used ChatGPT for bonus question
}

