// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GratitudeJournal {
    struct Entry {
        string note;
        uint256 timestamp;
    }
    
    mapping(address => Entry[]) public journals;
    
    function addGratitude(string memory _note) public {
        require(bytes(_note).length > 0, "Note cannot be empty");
        journals[msg.sender].push(Entry(_note, block.timestamp));
    }
    
    function getMyEntries() public view returns (Entry[] memory) {
        return journals[msg.sender];
    }
    
    function getEntryCount() public view returns (uint256) {
        return journals[msg.sender].length;
    }
}