const main = async () => {
    
    const tokenContract = await ethers.getContractFactory("VIEIRATOKEN");
    const tokenDeploy = await tokenContract.deploy();
  
    await tokenDeploy.deployed()
    console.log("vieiraToken deployed to:", tokenDeploy.address);
  
  };
 
  main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });