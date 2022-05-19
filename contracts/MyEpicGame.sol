//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MyEpicGame{
    // constructor(){
    //     console.log("Game Contract");
    // }

    struct CharacterAttributes{
        uint characterIndex;
        string name;
        string imageURI;
        uint hp;
        uint maxHp;
        uint attackDamage;
    }

    CharacterAttributes[] characters;

    constructor(
        string[] memory _charactersNames,
        string[] memory _charactersImageURIs,
        uint[] memory _charactersHp,
        uint[] memory _charactersAttackDamage
    ){
        for(uint i = 0; i < _charactersNames.length; i++){
            characters.push(
                CharacterAttributes({
                    characterIndex: i,
                    name: _charactersNames[i],
                    imageURI: _charactersImageURIs[i],
                    hp: _charactersHp[i],
                    maxHp: _charactersHp[i],
                    attackDamage: _charactersAttackDamage[i]
                })
            );
            CharacterAttributes memory c = characters[i];
            console.log("Character: %s, HP: %s, Attack damage: %s" , c.name , c.hp , c.attackDamage);            
        }
    }

}