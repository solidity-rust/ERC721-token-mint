var Metabases = artifacts.require("./Metabases.sol");

module.exports = async (deployer, network, addresses) => {
  await deployer.deploy(Metabases);
};