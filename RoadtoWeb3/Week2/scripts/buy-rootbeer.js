// scripts/buy-rootbeer.js

const { id } = require("ethers/lib/utils");
const hre = require("hardhat");

// Returns the Ether balance of a given address.
async function getBalance(address) {
  const balanceBigInt = await hre.waffle.provider.getBalance(address);
  return hre.ethers.utils.formatEther(balanceBigInt);
}

// Logs the Ether balances for a list of addresses.
async function printBalances(addresses) {
  let idx = 0;
  for (const address of addresses) {
    console.log(`Address ${idx} balance: `, await getBalance(address));
    idx ++;
  }
}

// Logs the memos stored on-chain from rootbeer purchases.
async function printMemos(memos) {
  for (const memo of memos) {
    const timestamp = memo.timestamp;
    const tipper = memo.name;
    const tipperAddress = memo.from;
    const message = memo.message;
    console.log(`At ${timestamp}, ${tipper} (${tipperAddress}) said: "${message}"`);
  }
}

async function main() {
  // Get the example accounts we'll be working with.
  const [owner, tipper, tipper2, tipper3] = await hre.ethers.getSigners();

  // We get the contract to deploy.
  const BuyMeARootbeer = await hre.ethers.getContractFactory("BuyMeARootbeer");
  const buymearootbeer = await BuyMeARootbeer.deploy();

  // Deploy the contract.
  await buymearootbeer.deployed();
  console.log("BuyMeARootbeer deployed to:", buymearootbeer.address);

  // Check balances before the rootbeer purchase.
  const addresses = [owner.address, tipper.address, buymearootbeer.address];
  console.log("== start ==");
  await printBalances(addresses);

  // Buy the owner a few rootbeers.
  const tip = {value: hre.ethers.utils.parseEther("1")};
  await buymearootbeer.connect(tipper).buyRootbeer("Maverick", "Drink up!", tip);
  await buymearootbeer.connect(tipper2).buyRootbeer("Rumble", "Nice work bro!", tip);
  await buymearootbeer.connect(tipper3).buyRootbeer("Solomon", "I love rootbeer!", tip);

  // Check balances after the rootbeer purchase.
  console.log("== bought rootbeer ==");
  await printBalances(addresses);

  // Withdraw.
  await buymearootbeer.connect(owner).withdrawTips();

  // Check balances after withdrawal.
  console.log("== withdrawTips ==");
  await printBalances(addresses);

  // Check out the memos.
  console.log("== memos ==");
  const memos = await buymearootbeer.getMemos();
  printMemos(memos);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
