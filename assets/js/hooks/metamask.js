const web3Provider = new ethers.providers.Web3Provider(window.ethereum)

function init() {

    // Check that the web page is run in a secure context,
    // as otherwise MetaMask won't be available
    if (location.protocol !== 'https:') {
        console.log("FAILING AT HTTPS")
    }
}


export const Metamask = {
    mounted() {
        let signer = web3Provider.getSigner()
        const message = 'Signing this message is verification that the Metamask wallet you are using belongs to you.'

        window.addEventListener('load', async () => {
            init();
            let address
            web3Provider.listAccounts().then((accounts) => {
                if (accounts.length > 0) {
                    signer = web3Provider.getSigner();
                    address = signer.getAddress().then((address) => {return address});
                }
                this.pushEvent("account-check", {connected: accounts.length > 0, current_wallet_address: address})
            })
        })

        window.addEventListener(`phx:get-current-wallet`, (e) => {
            signer.getAddress().then((address) => {

                this.pushEvent("verify-signature", {current_wallet_address: address})
            })
        })

        window.addEventListener(`phx:connect-metamask`, (e) => {
            web3Provider.provider.request({method: 'eth_requestAccounts'}).then((accounts) => {
                if (accounts.length > 0) {
                signer.signMessage(message).then((signature) => {

                    console.log("SIGNATURE:::::: ", signature)
                    signer.getAddress().then((address) => {
                        console.log("ADDRESS::::: ", address)
                        this.pushEvent("wallet-connected", {public_address: address, signature: signature})
                    });

                })
                }
            }, (error) => console.log(error))

        })

        window.addEventListener("phx:coin-transaction", (event) => {

            let contract = new ethers.Contract(event.detail.contract_address, metaCoinAbi, signer)
            contract.sendCoin(event.detail.to_address, 10)

        })

        window.addEventListener("phx:mint-nft", (event) => {
            // let contract = new ethers.Contract(event.detail.contract_address, tokenAbi, signer)
            // signer.getAddress.then((address) => {
            //     contract.mint(adde)
            // })

        })

    },
}

