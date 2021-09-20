var Migrations = artifacts.require("./Migrations.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations, "0x15458ef540ade6068dfe2f44e8fa733c", "0x15458ef540ade6068dfe2f44e8fa734c");
};