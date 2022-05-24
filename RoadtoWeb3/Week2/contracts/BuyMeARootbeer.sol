//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract BuyMeARootbeer {
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
    address payable public currentOwner;

    // List of all memos received from rootbeer buyers.
    Memo[] memos;

    //Deploy logic.
    constructor() {
        // Upon contract deployment, registers the address of the deployer as the contract owner.
        // Note1: Only contract owner can withdraw tips.
        // Challenge1: Change owner address only by specific people.
        currentOwner = payable(msg.sender);
    }

    // Modifier for identifying certain fucntion that can only be deployed by the owner.
    modifier onlyOwner() {
        require(payable(msg.sender) == currentOwner, "You're not the owner! Please contact contract owner in regards to executing this function");
        _;
    }

    // Acquires all the memos sent to the owner.    
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }

    /**
     * @dev buy a rootbeer for contract owner
     * @param _name name of the rootbeer buyer
     * @param _message a nice message for the rootbeer buyer
    */

    // Main function for buying a rootbeer for the owner.
    function buyRootbeer(string memory _name, string memory _message) public payable {
        // Requires buyer to at least have balance to buy rootbeer.
        require(msg.value > 0, "Insufficient funds. Requires more than 0 ETH to purchasee a Rootbeer.");

        // Add memo to storage.
        memos.push(Memo(msg.sender, block.timestamp, _name, _message));

        emit NewMemo (msg.sender, block.timestamp, _name, _message);
    }

    // Withdraws the tips from the contract to the owner's address.
    function withdrawTips() public onlyOwner {
        currentOwner.transfer(address(this).balance);
    }

    // Returns the amount currently in the contract.
    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }

    // Updates the owner address.
    function changeOwner (address _newOwner) public onlyOwner {
        currentOwner = payable(_newOwner);
    }

    /**
     * @dev Sends an amount of tips to another address.
     * @dev Testing to see if this one would be working. Will be adding another js script for it. (05/24/2022)
     * @param _tipReceiver encode the address of the receiver
    */
    function sendTips (address payable _tipReceiver) public onlyOwner {
        _tipReceiver.transfer(address(this).balance);
    }
}

/**
Contract Deployment Log:

Goerli Test Network:
1. Deployed at 0xBC5D2c5d158cb5Dbf3CEf876d00fcaB25669679f (5:54PM PHT 05/23/2022)

 */