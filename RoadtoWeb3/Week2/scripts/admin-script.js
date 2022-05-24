// scripts/withdraw.js
// This script can only be deployed by the person whose wallet address deployed the original contract.

const hre = require("hardhat");
const abi = require("../artifacts/contracts/BuyMeARootbeer.sol/BuyMeARootbeer.json");

// Returns the current balance of the contract.
async function getBalance(provider, address) {
    const balanceBigInt = await provider.getBalance(address);
    return hre.ethers.utils.formatEther(balanceBigInt);
}

/**
 * @dev Still need to figure out how to make the main script for this. (05/24/2022)
 */
async function main() {

}
  
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });