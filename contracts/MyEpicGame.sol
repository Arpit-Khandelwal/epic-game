//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "./libraries/Base64.sol";


contract MyEpicGame is ERC721{
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

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIDs;

    CharacterAttributes[] characters;

    mapping(uint256 => CharacterAttributes) private nftHoldersAttributes;
    mapping(address => uint256) private nftHolders;

    constructor(
        string[] memory _charactersNames,
        string[] memory _charactersImageURIs,
        uint[] memory _charactersHp,
        uint[] memory _charactersAttackDamage
    )
    ERC721("Attack on Titan","AOT"){
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
        _tokenIDs.increment();
    }

    function mintCharacterNFT(uint _characterIndex) external{

        uint256 newItemID = _tokenIDs.current();

        _safeMint(msg.sender, newItemID);

        nftHoldersAttributes[newItemID] = CharacterAttributes({
            characterIndex: _characterIndex,
            name: characters[_characterIndex].name,
            imageURI: characters[_characterIndex].imageURI,
            hp: characters[_characterIndex].hp,
            maxHp: characters[_characterIndex].maxHp,
            attackDamage: characters[_characterIndex].attackDamage
        });

        console.log("Minted %s NFT: %s and ",characters[newItemID].name ,newItemID);

        nftHolders[msg.sender] = newItemID;

        _tokenIDs.increment();
    }

    function tokenURI(uint256 _tokenID) public view override returns (string memory)
    {
        CharacterAttributes memory charAttr = nftHoldersAttributes[_tokenID];

        string memory strHp = Strings.toString(charAttr.hp);
        string memory strMaxHp = Strings.toString(charAttr.maxHp);
        string memory strAttackDamage = Strings.toString(charAttr.attackDamage);

        string memory json = Base64.encode(
            abi.encodePacked(
                '{"name: "', charAttr.name,
                '", NFT #: "', Strings.toString(_tokenID),
                '",imageURI: "', charAttr.imageURI,
                '",description": "Attack On Titan based game where you have to beat the boss using your minted character NFT"',
                 '", "attributes": [ { "trait_type": "Health Points", "value": ',strHp,', "max_value":',strMaxHp,'}, { "trait_type": "Attack Damage", "value": ',  strAttackDamage,'} ]}'
            )
        );

        string memory output = string(abi.encodePacked("data:application/json;base64,", json));
        
        return output;
    }

}
