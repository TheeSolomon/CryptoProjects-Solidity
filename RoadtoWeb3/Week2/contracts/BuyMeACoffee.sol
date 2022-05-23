//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

/**
 * @dev: This is the base contract for the BuyMeARootbeer SC. 
 */

// Deployed to Goerli at 0x021561d77cdA84ee29571a8E21Bb8ca41C6FC887 at 10:46PM PHT 05/20/2022.
// Deployed to Goerli at 0x5FbDB2315678afecb367f032d93F642f64180aa3 at 8:55PM PHT 05/22/2022.

contract BuyMeACoffee {
    // Event to emit when a memo is created. 
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // Memo struct.
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // Address of contract deployer.
    address payable owner;

    // List of all memos received from coffee buyers.
    Memo[] memos;

    constructor() {
        owner = payable(msg.sender);
    }

    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }

    /**
     * @dev buy a coffee for contract owner
     * @param _name name of the coffee buyer
     * @param _message a nice message for the coffee buyer
    */

    function buyCoffee(string memory _name, string memory _message) public payable {
        // Requires buyer to at least have balance to buy coffee.
        require(msg.value > 0, "Insufficient funds. No ETH.");

        // Add memo to storage.
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        emit NewMemo (
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }
}
