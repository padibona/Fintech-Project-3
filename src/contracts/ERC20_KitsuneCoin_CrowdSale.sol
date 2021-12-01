pragma solidity ^0.5.5;

import "./KitsuenCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";


// Bootstrap the KitsuenCoinCrowdsale contract by inheriting the following OpenZeppelin:
// * Crowdsale
// * MintedCrowdsale
contract KitsuenCoinCrowdsale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {
    
    // Provide parameters for all of the features of your crowdsale, such as the `rate`, `wallet` for fundraising, and `token`.
    constructor(
        uint256 rate, // rate in TKNbits
        address payable wallet, // sale beneficiary
        KitsuenCoin token, // the KaseiCoin itself that the KitsuenCoinCrowdsale will work with
        uint goal, // the crowdsale goal
        uint open, // the crowdsale opening time
        uint close // the crowdsale closing time
    ) public
        Crowdsale(rate, wallet, token)
        CappedCrowdsale(goal)
        TimedCrowdsale(open, close)
        RefundableCrowdsale(goal)
    {
        // constructor can stay empty
    }
}


contract KitsuenCoinCrowdsaleDeployer {
    // Create an `address public` variable called `Kitsuen_token_address`.
    address public Kitsuen_token_address;
    // Create an `address public` variable called `Kitsuen_crowdsale_address`.
    address public Kitsuen_crowdsale_address;

    // Add the constructor.
    constructor(
        string memory name,
        string memory symbol,
        address payable wallet, // this address will receive all Ether raised by the crowdsale
        uint goal
    ) public {
        // Create a new instance of the KaseiCoin contract.
        KitsuenCoin token = new KitsuenCoin(name, symbol, 0);
        
        // Assign the token contract's address to the `kasei_token_address` variable.
        Kitsuen_token_address = address(token);

        // Create a new instance of the `KaseiCoinCrowdsale` contract
        KitsuenCoinCrowdsale Kitsuen_crowdsale = new KitsuenCoinCrowdsale (1, wallet, token, goal, now, now + 24 weeks);
            
        // Aassign the `KitsuenCoinCrowdsale` contract's address to the `Kitsuen_crowdsale_address` variable.
        Kitsuen_crowdsale_address = address(Kitsuen_crowdsale);

        // Set the `KitsuenCoinCrowdsale` contract as a minter
        token.addMinter(Kitsuen_crowdsale_address);
        
        // Have the `KitsuenCoinCrowdsaleDeployer` renounce its minter role.
        token.renounceMinter();
    }
}