// hardhat.config.js

require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-waffle");
require("dotenv").config()

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

const GOERLI_URL = process.env.GOERLI_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks: {
    /**
     * @dev You will need to create your own environment variables by creating a .env file and stating the following variables:
     * GOERLI_URL=<https://eth-goerli.alchemyapi.io/v2/(your goerli api key)>
     * GOERLI_API_KEY=<API KEY>
     * PRIVATE_KEY=<wallet private key>
     * Note: I am using alchemy for managing my DAPPs.
     */
    goerli: {
      url: GOERLI_URL,
      accounts: [PRIVATE_KEY]
    }
  }
};
