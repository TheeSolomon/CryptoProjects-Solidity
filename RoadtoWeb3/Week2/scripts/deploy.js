// scripts/deploy.js

const hre = require("hardhat");

async function main() {
  // We get the contract to deploy.
  const BuyMeARootbeer = await hre.ethers.getContractFactory("BuyMeARootbeer");
  const buymearootbeer = await BuyMeARootbeer.deploy();

  await buymearootbeer.deployed();

  console.log("BuyMeARootbeer deployed to:", buymearootbeer.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });