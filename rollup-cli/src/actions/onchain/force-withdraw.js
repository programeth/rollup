/* eslint-disable no-restricted-syntax */
const ethers = require('ethers');
const { fix2float } = require('../../../../js/utils');
const { getGasPrice } = require('./utils');

/**
 * on-chain transaction to build a leaf on exit tree
 * @param {String} nodeEth - URL of the ethereum node
 * @param {String} addressSC - rollup address
 * @param {String} amount - amount to transfer to the leaf of exit tree
 * @param {Obejct} walletRollup - ethAddress and babyPubKey together
 * @param {String} abi - abi of rollup contract
 * @param {Number} idFrom - transfer funds from this id to exit tree
 * @param {Number} gasLimit - transaction gas limit
 * @param {Number} gasMultiplier - multiply gas price
 * @returns {Promise} - promise will resolve when the Tx is sent, and return the Tx itself with the Tx Hash.
 */
async function forceWithdraw(nodeEth, addressSC, amount, walletRollup, abi, idFrom, gasLimit = 5000000, gasMultiplier = 1) {
    let walletEth = walletRollup.ethWallet.wallet;
    const provider = new ethers.providers.JsonRpcProvider(nodeEth);
    walletEth = walletEth.connect(provider);
    const contractWithSigner = new ethers.Contract(addressSC, abi, walletEth);
    const feeOnchainTx = await contractWithSigner.FEE_ONCHAIN_TX();
    const overrides = {
        gasLimit,
        gasPrice: await getGasPrice(gasMultiplier, provider),
        value: feeOnchainTx,
    };

    const amountF = fix2float(amount);
    try {
        return await contractWithSigner.forceWithdraw(idFrom, amountF, overrides);
    } catch (error) {
        throw new Error(`Message error: ${error.message}`);
    }
}

module.exports = {
    forceWithdraw,
};
