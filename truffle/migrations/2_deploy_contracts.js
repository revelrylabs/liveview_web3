const ConvertLib = artifacts.require("ConvertLib");
const MetaCoin = artifacts.require("MetaCoin");
const VerifySignature = artifacts.require("VerifySignature");
const Token = artifacts.require("Token");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(MetaCoin);
  deployer.deploy(VerifySignature);
  deployer.deploy(Token);
};
