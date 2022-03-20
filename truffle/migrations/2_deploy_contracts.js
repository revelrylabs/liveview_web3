const VerifySignature = artifacts.require("VerifySignature");
const CovidVaccineToken = artifacts.require("CovidVaccineToken");

module.exports = function(deployer) {
  deployer.deploy(VerifySignature);
  deployer.deploy(CovidVaccineToken);
};
