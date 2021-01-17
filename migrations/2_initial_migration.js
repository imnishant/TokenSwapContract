var MyContract = artifacts.require("./DEX.sol");

module.exports = function(deployer) {
  deployer.deploy(MyContract);
};