// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// A smart contract to model the Album

contract Album {

     // A custom data structure used to define a music album
    struct musicAlbum {
        // The artist/group who recorded the album
        string artist; 
        // The album's title
        string albumTitle;
        // The number of tracks on the album
        uint tracks;
    } // struct musicAlbum


     // The current album information
    musicAlbum public currentAlbum;

    // A mapping of every user's favorite album
    mapping(address => musicAlbum) public userAlbums;


    // the author of the smart contract
    string public constant contractAuthor = "Pritam Nikam";

    // The owner of the current instance of this smart contract
    address owner;

    // Event which will be raised anytime the current album information is updated.
    event errorEvent(string errorEvent_Description);

    // Event which will be raised anytime the current album information is updated.
    event albumEvent(string albumEvent_Description, string albumEvent_Artist, string albumEvent_Title, uint albumEvent_Tracks);

    // This function modifier ensures that the initiator of any transaction 
    //   it is attached to matches the address of the contract's owner.
    // Use this function modifier for functions that should only
    //   be performed by the owner of this contract instance.
    modifier onlyOwner {
        if (msg.sender != owner) {
            // The initiator of this transaction is NOT the contract instance's owner!
            emit errorEvent("Only the owner of this contract instance can perform this function!");
        } else {
            _;
        } // else
    } // modifier onlyOwner

    // Contract constructor.
    //   This code is called once when the contract instance is deployed to the Ethereum network
    constructor() {
        // Feel free to use your own preferred values below :)
        currentAlbum.artist = 'Nirvana';
        currentAlbum.albumTitle = 'Nevermind';
        currentAlbum.tracks = 13;
        // Set the owner property of this contract instance to the initiator of this contract deployment
        owner = msg.sender;
    } // constructor


    // Returns the current album information
    function getCurrentAlbum() public view returns (string memory, string memory, uint) {
        return (currentAlbum.artist, 
                currentAlbum.albumTitle, 
                currentAlbum.tracks);
    } // getCurrentAlbum

    // Set the current album information
    function setCurrentAlbum(string memory _artist, string memory _albumTitle, uint _tracks) onlyOwner public {
        currentAlbum.artist = _artist;
        currentAlbum.albumTitle = _albumTitle;
        currentAlbum.tracks = _tracks;
        
        // Raise the albumEvent to let any event subscribers know the current album information has changed.
        emit albumEvent("The current album information has been updated", _artist, _albumTitle, _tracks);
    } // setCurrentAlbum


    // Returns the current user's favorite album information
    function getUsersFavoriteAlbum() public view returns (string memory, string memory, uint) {
        return (userAlbums[msg.sender].artist, 
                userAlbums[msg.sender].albumTitle, 
                userAlbums[msg.sender].tracks);
    } // getUsersFavoriteAlbum

    // Set the current user's favorite album information
    function setUsersFavoriteAlbum(string memory _artist, string memory _albumTitle, uint _tracks) public {
        userAlbums[msg.sender].artist = _artist;
        userAlbums[msg.sender].albumTitle = _albumTitle;
        userAlbums[msg.sender].tracks = _tracks;
        
        // Raise the albumEvent to let any event subscribers know the current album information has changed.
        emit albumEvent("You have updated your personal favorite album information", _artist, _albumTitle, _tracks);
    } // setUsersFavoriteAlbum
}
