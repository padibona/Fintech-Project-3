pragma solidity ^0.5.5;
import "./KitsuneCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";
// Bootstrap the KitsuenCoinCrowdsale contract by inheriting the following OpenZeppelin:
// * Crowdsale
// * MintedCrowdsale
contract KitsuneCoinCrowdsale is Crowdsale, MintedCrowdsale {
    // Provide parameters for all of the features of your crowdsale, such as the `rate`, `wallet` for fundraising, and `token`.
    constructor(
        uint256 rate, // rate in TKNbits
        address payable wallet, // sale beneficiary
        KitsuneCoin token // the KitsuneCoin itself that the KitsuneCoinCrowdsale will work with        
    ) public
        Crowdsale(rate, wallet, token)        
    {
        // constructor can stay empty
    }
}
contract KitsuneCoinCrowdsaleDeployer {
    // Create an `address public` variable called `Kitsuen_token_address`.
    address public Kitsune_token_address;
    // Create an `address public` variable called `Kitsuen_crowdsale_address`.
    address public Kitsune_crowdsale_address;
    // Add the constructor.
    constructor(
        string memory name,
        string memory symbol,
        address payable wallet // this address will receive all Ether raised by the crowdsale
    ) public {
        // Create a new instance of the KaseiCoin contract.
        KitsuneCoin token = new KitsuneCoin(name, symbol, 0);
        // Assign the token contract's address to the `kasei_token_address` variable.
        Kitsune_token_address = address(token);
        // Create a new instance of the `KaseiCoinCrowdsale` contract
        KitsuneCoinCrowdsale Kitsune_crowdsale = new KitsuneCoinCrowdsale (1, wallet, token);
        // Aassign the `KitsuneCoinCrowdsale` contract's address to the `Kitsune_crowdsale_address` variable.
        Kitsune_crowdsale_address = address(Kitsune_crowdsale);
        // Set the `KitsuneCoinCrowdsale` contract as a minter
        token.addMinter(Kitsune_crowdsale_address);
        // Have the `KitsuneCoinCrowdsaleDeployer` renounce its minter role.
        token.renounceMinter();
    }
}