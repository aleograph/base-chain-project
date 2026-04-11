// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PomodoroTracker {
    struct Session {
        uint256 duration; // in minutes
        string taskDescription;
        uint256 timestamp;
    }
    
    mapping(address => Session[]) public sessions;
    uint256 public totalSessions;
    
    event SessionLogged(address user, uint256 duration, string task);
    
    function logSession(uint256 _minutes, string memory _task) public {
        require(_minutes > 0 && _minutes <= 120, "Invalid duration");
        sessions[msg.sender].push(Session(_minutes, _task, block.timestamp));
        totalSessions++;
        emit SessionLogged(msg.sender, _minutes, _task);
    }
    
    function getMySessions() public view returns (Session[] memory) {
        return sessions[msg.sender];
    }
    
    function getTotalFocusTime() public view returns (uint256) {
        uint256 total = 0;
        Session[] memory mySessions = sessions[msg.sender];
        for (uint256 i = 0; i < mySessions.length; i++) {
            total += mySessions[i].duration;
        }
        return total;
    }
}