//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BuyMeARootbeer is Ownable {
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

    // Registers the address of the deployer as the contract owner.
    constructor() {
        // owner = payable(msg.sender);
        owner = payable(owner());
    }

    // Acquires all the memos sent to the owner.    
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }

    /**
     * @dev buy a coffee for contract owner
     * @param _name name of the coffee buyer
     * @param _message a nice message for the coffee buyer
    */

    function buyRootbeer(string memory _name, string memory _message) public payable {
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

    // Withdraws the tips from the contract to the owner's address.
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    
    function transferOwner(address newOwner) public payable onlyOwner {

    }
}