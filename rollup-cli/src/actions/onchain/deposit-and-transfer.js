/* eslint-disable no-restricted-syntax */
const ethers = require('ethers');
const { fix2float } = require('../../../../js/utils');
const { Wallet } = require('../../wallet.js');
/**
 * @dev deposit on an existing loadAmount tree leaf
 * @param nodeEth URL of the ethereum node
 * @param addressSC rollup address
 * @param loadAmount initial Amount on balance tree
 * @param tokenId token type identifier
 * @param walletJson from this one can obtain the ethAddress and babyPubKey
 * @param passphrase for decrypt the Wallet
 * @param ethAddress allowed address to control new balance tree leaf
 * @param abi abi of rollup contract
 * @param UrlOperator URl from operator
*/
async function depositAndTransfer(nodeEth, addressSC, loadAmount, amount, tokenId, walletJson, passphrase, ethAddress, abi, toId, gasLimit = 5000000, gasMultiplier = 1) {
    const walletRollup = await Wallet.fromEncryptedJson(walletJson, passphrase);
    let walletEth = walletRollup.ethWallet.wallet;
    const walletBaby = walletRollup.babyjubWallet;
    const provider = new ethers.providers.JsonRpcProvider(nodeEth);
    const pubKeyBabyjub = [walletBaby.publicKey[0].toString(), walletBaby.publicKey[1].toString()];
    walletEth = walletEth.connect(provider);
    const address = ethAddress || await walletEth.getAddress();
    const contractWithSigner = new ethers.Contract(addressSC, abi, walletEth);
    const fee_onchain_tx = await contractWithSigner.FEE_ONCHAIN_TX();
    const overrides = {
        gasLimit: gasLimit,
        gasPrice: await _getGasPrice(gasMultiplier, provider),
        value: fee_onchain_tx
    };

    const amountF = fix2float(amount);
    try {
        return await contractWithSigner.depositAndTransfer(loadAmount, tokenId,
            address, pubKeyBabyjub, toId, amountF, overrides);
    } catch (error) {
        throw new Error(`Message error: ${error.message}`);
    }
}

async function _getGasPrice(multiplier, provider){
    const strAvgGas = await provider.getGasPrice();
    const avgGas = BigInt(strAvgGas);
    const res = (avgGas * BigInt(multiplier))
    return await ethers.utils.bigNumberify(res.toString());
}

module.exports = {
    depositAndTransfer,
};
