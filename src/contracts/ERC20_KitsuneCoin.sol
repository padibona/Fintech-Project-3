pragma solidity ^0.5.5;

//  Import the following contracts from the OpenZeppelin library:
//    * `ERC20`
//    * `ERC20Detailed`
//    * `ERC20Mintable`
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

// // Create a constructor for the KaseiCoin contract and have the contract inherit the libraries that you imported from OpenZeppelin.
contract KitsuneCoin is ERC20, ERC20Detailed, ERC20Mintable {
    constructor(
        string memory name,
        string memory symbol,
        uint initial_supply
    )
        ERC20Detailed(KitsuneCoin, KIT, 10000000)
        public
    {
        // constructor can stay empty
    }
}

pragma solidity ^0.5.5;

import "./KitsuneCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";


// Bootstrap the KaseiCoinCrowdsale contract by inheriting the following OpenZeppelin:
// * Crowdsale
// * MintedCrowdsale
contract KitsuneCoinCrowdsale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {
    
    // Provide parameters for all of the features of your crowdsale, such as the `rate`, `wallet` for fundraising, and `token`.
    constructor(
        uint256 rate, // rate in TKNbits
        address payable wallet, // sale beneficiary
        KitsuneCoin token, // the KitsuneCoin itself that the KitsuneCoinCrowdsale will work with
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


contract KitsuneCoinCrowdsaleDeployer {
    // Create an `address public` variable called `kasei_token_address`.
    address public KitsuneCoin_token_address;
    // Create an `address public` variable called `kasei_crowdsale_address`.
    address public KitsuneCoin_crowdsale_address;

    // Add the constructor.
    constructor(
        string memory name,
        string memory symbol,
        address payable wallet, // this address will receive all Ether raised by the crowdsale
        uint goal
    ) public {
        // Create a new instance of the KitsuneCoin contract.
        KitsuneCoin token = new KitsuneCoin(KitsuneCoin, KIT, 0);
        
        // Assign the token contract's address to the `KitsuneCoin_token_address` variable.
        KitsuneCoin_token_address = address(KIT);

        // Create a new instance of the `KitsuneCoinCrowdsale` contract
        KitsuneCoinCrowdsale KitsuneCoin_crowdsale = new KitsuneCoinCrowdsale (1, wallet, token, goal, now, now + 24 weeks);
            
        // Aassign the `KitsuneCoinCrowdsale` contract's address to the `kasei_crowdsale_address` variable.
        KitsuneCoin_crowdsale_address = address(KitsuneCoin_crowdsale);

        // Set the `KitsuneCoinCrowdsale` contract as a minter
        token.addMinter(kasei_crowdsale_address);
        
        // Have the `KitsuneCoinCrowdsaleDeployer` renounce its minter role.
        token.renounceMinter();
    }
}