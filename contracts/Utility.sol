// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// A smart contract to hold the utility functions

contract Utility {
        // The owner of the current instance of this smart contract
    address owner;

    // Event which will be raised anytime the current album information is updated.
    event errorEvent(string errorEvent_Description);

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
}
