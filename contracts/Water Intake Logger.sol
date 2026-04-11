// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract WaterLogger {
    mapping(address => uint256) public dailyIntake; // in ml
    mapping(address => uint256) public lastLogDate;
    
    event WaterLogged(address user, uint256 amount, uint256 date);
    
    function logWater(uint256 _ml) public {
        uint256 today = block.timestamp / 1 days; // Rough day bucket
        require(_ml > 0 && _ml <= 10000, "Invalid amount");
        
        if (lastLogDate[msg.sender] != today) {
            dailyIntake[msg.sender] = 0; // Reset for new day
            lastLogDate[msg.sender] = today;
        }
        
        dailyIntake[msg.sender] += _ml;
        emit WaterLogged(msg.sender, _ml, today);
    }
    
    function getTodayIntake() public view returns (uint256) {
        uint256 today = block.timestamp / 1 days;
        if (lastLogDate[msg.sender] == today) {
            return dailyIntake[msg.sender];
        }
        return 0;
    }
}