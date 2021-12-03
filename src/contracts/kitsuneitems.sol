
// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract KitsunItems is ERC1155 {
    uint256 public constant SWORD= 0;
    uint256 public constant JEWEL = 1;
    uint256 public constant MIRROR = 2;
    uint256 public constant GOLD = 3;
    uint256 public constant SILVER = 4;

    constructor() ERC1155("https://game.example/api/item/{id}.json") {
        _mint(msg.sender, SWORD, 1, "");
        _mint(msg.sender, JEWEL, 1, "");
        _mint(msg.sender, MIRROR, 1, "");
        _mint(msg.sender, GOLD,10**8,"" );
        _mint(msg.sender, SILVER,10**8,"");
       }
    function quest (address owner, string memory name, uint tokenID ) public {
        
    }
}