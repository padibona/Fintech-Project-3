pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";

contract Character is ERC721Full {
    constructor() public ERC721Full("Character", "KITC") {}

    struct Character {
        string name;
        string class;
        uint strength;
        uint agility;
        uint generation;
    }

    mapping(uint => Character) public characters;

    function mint_character(address owner, string memory name, string memory class, uint strength, uint agility, uint generation, string memory tokenURI)
        public
        returns (uint)
    {
        uint256 characterId = totalSupply() + 1; //NOTE: totalSupply() is built into ERC-721
        _mint(owner, characterId);  // mint function takes in the address of where it will be minted and the Token ID.
        _setTokenURI(characterId, tokenURI);  // Required to mint.  Takes in the Token ID & Token URI.

        return characterId;
    }
}
