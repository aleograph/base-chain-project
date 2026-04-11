// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVoting {
    string public proposal = "Should we proceed?";
    uint256 public yesVotes = 0;
    uint256 public noVotes = 0;
    mapping(address => bool) public hasVoted;

    function voteYes() public {
        require(!hasVoted[msg.sender], "Already voted");
        yesVotes += 1;
        hasVoted[msg.sender] = true;
    }

    function voteNo() public {
        require(!hasVoted[msg.sender], "Already voted");
        noVotes += 1;
        hasVoted[msg.sender] = true;
    }

    function getResults() public view returns (uint256, uint256) {
        return (yesVotes, noVotes);
    }
}