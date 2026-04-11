// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DailyTodo {
    struct Task {
        string description;
        bool completed;
        uint256 createdAt;
    }
    
    Task[] public tasks;
    address public owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }
    
    function addTask(string memory _desc) public onlyOwner {
        tasks.push(Task(_desc, false, block.timestamp));
    }
    
    function completeTask(uint256 _index) public onlyOwner {
        require(_index < tasks.length, "Task does not exist");
        tasks[_index].completed = true;
    }
    
    function getTaskCount() public view returns (uint256) {
        return tasks.length;
    }
    
    function getPendingTasks() public view returns (string[] memory) {
        uint256 pendingCount = 0;
        for (uint256 i = 0; i < tasks.length; i++) {
            if (!tasks[i].completed) pendingCount++;
        }
        
        string[] memory pending = new string[](pendingCount);
        uint256 counter = 0;
        for (uint256 i = 0; i < tasks.length; i++) {
            if (!tasks[i].completed) {
                pending[counter] = tasks[i].description;
                counter++;
            }
        }
        return pending;
    }
}