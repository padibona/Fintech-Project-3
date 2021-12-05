pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";

contract Character is ERC721Full {
    constructor() public ERC721Full("Character", "KITC") {}

    struct Character {
        string char_name;
        string char_class;
        uint strength;
        uint agility;
        uint generation;
    }

    mapping(uint => Character) public characters;

    function mint_character(address owner, string memory char_name, string memory char_class, uint strength, uint agility, uint generation)
        public
        returns (uint)
    {
        uint256 characterId = totalSupply() + 1; //NOTE: totalSupply() is built into ERC-721
        string memory tokenURI = "";
        // _char_name = char_name;
        // _char_class = char_class;
        // _strength = strength;
        // _agility = agility;
        // _generation = generation;
        _mint(owner, characterId);  // mint function takes in the address of where it will be minted and the Token ID.
        _setTokenURI(characterId, tokenURI);  // Required to mint.  Takes in the Token ID & Token URI.

        characters[characterId] = Character(char_name, char_class, strength, agility, generation);  // Add new Character to mapping.

        return characterId;
    }
}