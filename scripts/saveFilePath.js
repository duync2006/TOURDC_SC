var path = require('path');
const fs = require("fs");

async function saveFrontendFiles(address, name) {

  const contractsDir = path.join(__dirname, "..", '..', "TourDC_FE", "TourDC-FE", "contracts");
  console.log(contractsDir)
  const contractsDirTokenAddress = path.join(__dirname, "..", '..', "TourDC_FE", "TourDC-FE", "contracts", `${name}-address.json`);
  const contractsDirABI = path.join(__dirname, "..", '..', "TourDC_FE", "TourDC-FE", "contracts", `${name}-address.json`);
  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    path.join(contractsDir, `${name}-address.json`),
    JSON.stringify({ Token: address }, undefined, 2)
  );

  const TokenArtifact = artifacts.readArtifactSync(`${name}`);

  fs.writeFileSync(
    path.join(contractsDir, `${name}.json`),
    JSON.stringify(TokenArtifact, null, 2)
  );
}
async function saveSCFiles(address, name) {

  const contractsDir = path.join(__dirname, "..", "deploys");

  const contractsDirTokenAddress = path.join(contractsDir, `${name}-address.json`);
  const contractsDirABI = path.join(contractsDir, `${name}-address.json`);
  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    path.join(contractsDir, `${name}-address.json`),
    JSON.stringify({ Token: address }, undefined, 2)
  );

  const TokenArtifact = artifacts.readArtifactSync(`${name}`);

  fs.writeFileSync(
    path.join(contractsDir, `${name}.json`),
    JSON.stringify(TokenArtifact, null, 2)
  );
}
module.exports = {
  saveFrontendFiles,
  saveSCFiles
};