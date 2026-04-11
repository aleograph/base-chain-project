// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract HabitTracker {
    struct Habit {
        string name;
        uint256 streak;
        uint256 lastCompleted;
    }
    
    mapping(address => Habit[]) public userHabits;
    
    function addHabit(string memory _name) public {
        userHabits[msg.sender].push(Habit(_name, 0, 0));
    }
    
    function completeHabit(uint256 _habitIndex) public {
        Habit[] storage habits = userHabits[msg.sender];
        require(_habitIndex < habits.length, "Habit does not exist");
        
        Habit storage habit = habits[_habitIndex];
        // Simple daily check (in real use, consider timestamps more carefully)
        if (block.timestamp - habit.lastCompleted > 1 days) {
            if (block.timestamp - habit.lastCompleted < 2 days) {
                habit.streak++;
            } else {
                habit.streak = 1; // Reset streak if missed
            }
        }
        habit.lastCompleted = block.timestamp;
    }
    
    function getMyHabits() public view returns (Habit[] memory) {
        return userHabits[msg.sender];
    }
}