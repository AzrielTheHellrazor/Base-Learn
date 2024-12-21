// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FavoriteRecords {
    mapping(string => bool) public approvedRecords;
    mapping(address => mapping(string => bool)) public userFavorites;
    string[] private approvedAlbumList;

    error NotApproved(string albumName);

    constructor() {
        string[9] memory albums = [
            "Thriller",
            "Back in Black",
            "The Bodyguard",
            "The Dark Side of the Moon",
            "Their Greatest Hits (1971-1975)",
            "Hotel California",
            "Come On Over",
            "Rumours",
            "Saturday Night Fever"
        ];

        for (uint i = 0; i < albums.length; i++) {
            approvedRecords[albums[i]] = true;
            approvedAlbumList.push(albums[i]);
        }
    }

    function getApprovedRecords() public view returns (string[] memory) {
        return approvedAlbumList;
    }

    function addRecord(string memory albumName) public {
        if (!approvedRecords[albumName]) {
            revert NotApproved(albumName);
        }

        userFavorites[msg.sender][albumName] = true;
    }

    function getUserFavorites(address user) public view returns (string[] memory) {
        uint favoriteCount = 0;
        for (uint i = 0; i < approvedAlbumList.length; i++) {
            if (userFavorites[user][approvedAlbumList[i]]) {
                favoriteCount++;
            }
        }

        string[] memory favorites = new string[](favoriteCount);
        uint index = 0;

        for (uint i = 0; i < approvedAlbumList.length; i++) {
            if (userFavorites[user][approvedAlbumList[i]]) {
                favorites[index] = approvedAlbumList[i];
                index++;
            }
        }

        return favorites;
    }

    function resetUserFavorites() public {
        for (uint i = 0; i < approvedAlbumList.length; i++) {
            if (userFavorites[msg.sender][approvedAlbumList[i]]) {
                userFavorites[msg.sender][approvedAlbumList[i]] = false;
            }
        }
    }
}
